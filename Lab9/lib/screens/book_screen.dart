import 'package:flutter/material.dart';

import '../models/book.dart';

import '../services/storage_service.dart';

import '../widgets/book_card.dart';

/// Main screen of Book Manager.
///
/// This screen handles:
///
/// - Loading local JSON data
/// - Displaying books
/// - Searching books
/// - Adding books
/// - Editing books
/// - Deleting books
///
/// The screen uses StatefulWidget because the list changes
/// whenever users perform CRUD operations.
class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  /// Storage service handles all file operations.
  ///
  /// UI should not directly use:
  /// - File
  /// - jsonEncode
  /// - jsonDecode
  ///
  /// Those responsibilities belong to StorageService.
  final StorageService _storageService = StorageService();

  /// Stores all books loaded from JSON file.
  List<Book> books = [];

  /// Stores filtered books displayed on screen.
  ///
  /// Example:
  ///
  /// books:
  /// [
  /// Clean Code,
  /// Atomic Habits
  /// ]
  ///
  /// search "clean"
  ///
  /// filteredBooks:
  /// [
  /// Clean Code
  /// ]
  List<Book> filteredBooks = [];

  /// Controller for search TextField.
  final TextEditingController searchController = TextEditingController();

  /// Used to display loading indicator
  /// while reading local JSON.
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Load local data when screen starts.
    loadBooks();

    // Listen to search changes.
    //
    // Every time user types:
    // update filtered list.
    searchController.addListener(searchBooks);
  }

  /// Load books from local JSON storage.
  ///
  /// First application launch:
  ///
  /// assets/books.json
  ///        |
  ///        ↓
  /// device storage
  ///
  ///
  /// Next launches:
  ///
  /// device storage
  ///        |
  ///        ↓
  /// app data
  Future<void> loadBooks() async {
    final result = await _storageService.loadBooks();

    setState(() {
      books = result;

      filteredBooks = result;

      isLoading = false;
    });
  }

  /// Search books by title, author, or category.
  ///
  /// Example:
  ///
  /// User types:
  /// "programming"
  ///
  /// App checks:
  /// title
  /// author
  /// category
  void searchBooks() {
    final keyword = searchController.text.toLowerCase();

    setState(() {
      filteredBooks = books.where((book) {
        return book.title.toLowerCase().contains(keyword) ||
            book.author.toLowerCase().contains(keyword) ||
            book.category.toLowerCase().contains(keyword);
      }).toList();
    });
  }

  /// Save current book list.
  ///
  /// This method is called after:
  ///
  /// - Add
  /// - Edit
  /// - Delete
  Future<void> saveBooks() async {
    await _storageService.saveBooks(books);
  }

  /// Add new book.
  ///
  /// The ID is automatically generated
  /// based on current maximum ID.
  Future<void> addBook(Book book) async {
    setState(() {
      books.add(book);
    });

    filteredBooks = books;

    await saveBooks();

    searchBooks();

    showMessage("Book added successfully");
  }

  /// Edit existing book.
  ///
  /// Find the book by ID,
  /// replace old data with new data.
  Future<void> editBook(Book updatedBook) async {
    final index = books.indexWhere((book) => book.id == updatedBook.id);

    if (index != -1) {
      setState(() {
        books[index] = updatedBook;
      });

      await saveBooks();

      searchBooks();

      showMessage("Book updated successfully");
    }
  }

  /// Delete book.
  ///
  /// Before deleting:
  /// show confirmation dialog.
  Future<void> deleteBook(Book book) async {
    final confirm = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Delete book?"),

          content: Text("Remove ${book.title}?"),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },

              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },

              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      setState(() {
        books.removeWhere((item) => item.id == book.id);
      });

      await saveBooks();

      searchBooks();

      showMessage("Book deleted");
    }
  }

  /// Show Snackbar message.
  ///
  /// Optional enhancement from lab.
  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  /// Open Add/Edit dialog.
  ///
  /// The same dialog is reused:
  ///
  /// Add mode:
  /// book == null
  ///
  /// Edit mode:
  /// book contains existing data
  void showBookDialog({Book? book}) {
    final titleController = TextEditingController(text: book?.title ?? '');

    final authorController = TextEditingController(text: book?.author ?? '');

    final categoryController = TextEditingController(
      text: book?.category ?? '',
    );

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: Text(book == null ? "Add Book" : "Edit Book"),

          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,

                  decoration: const InputDecoration(labelText: "Title"),
                ),

                TextField(
                  controller: authorController,

                  decoration: const InputDecoration(labelText: "Author"),
                ),

                TextField(
                  controller: categoryController,

                  decoration: const InputDecoration(labelText: "Category"),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                final newBook = Book(
                  id: book?.id ?? DateTime.now().millisecondsSinceEpoch,

                  title: titleController.text,

                  author: authorController.text,

                  category: categoryController.text,
                );

                Navigator.pop(context);

                if (book == null) {
                  addBook(newBook);
                } else {
                  editBook(newBook);
                }
              },

              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book Manager")),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBookDialog();
        },

        child: const Icon(Icons.add),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),

                  child: TextField(
                    controller: searchController,

                    decoration: InputDecoration(
                      labelText: "Search books",

                      prefixIcon: const Icon(Icons.search),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: filteredBooks.length,

                    itemBuilder: (context, index) {
                      final book = filteredBooks[index];

                      return BookCard(
                        book: book,

                        onEdit: () {
                          showBookDialog(book: book);
                        },

                        onDelete: () {
                          deleteBook(book);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }
}
