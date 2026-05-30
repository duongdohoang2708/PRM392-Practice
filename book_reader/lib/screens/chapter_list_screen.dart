import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/bookmark_service.dart';
import 'reader_screen.dart';

class ChapterListScreen extends StatefulWidget {
  final Book book;

  const ChapterListScreen({
    super.key,
    required this.book,
  });

  @override
  State<ChapterListScreen> createState() => _ChapterListScreenState();
}

class _ChapterListScreenState extends State<ChapterListScreen> {
  final BookmarkService _bookmarkService = BookmarkService();

  String? _bookmarkedChapterId;
  bool _isLoadingBookmark = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarkedChapter();
  }

  Future<void> _loadBookmarkedChapter() async {
    final chapterId = await _bookmarkService.getBookmarkedChapterId(
      widget.book.id,
    );

    if (!mounted) return;

    setState(() {
      _bookmarkedChapterId = chapterId;
      _isLoadingBookmark = false;
    });
  }

  Chapter? _findBookmarkedChapter() {
    if (_bookmarkedChapterId == null) return null;

    for (final chapter in widget.book.chapters) {
      if (chapter.id == _bookmarkedChapterId) {
        return chapter;
      }
    }

    return null;
  }

  Future<void> _openReader(Chapter chapter) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReaderScreen(
          book: widget.book,
          chapter: chapter,
        ),
      ),
    );

    await _loadBookmarkedChapter();
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final bookmarkedChapter = _findBookmarkedChapter();

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: _isLoadingBookmark
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          if (bookmarkedChapter != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.bookmark),
                  title: const Text('Continue Reading'),
                  subtitle: Text(bookmarkedChapter.title),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _openReader(bookmarkedChapter);
                  },
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: book.chapters.length,
              itemBuilder: (context, index) {
                final chapter = book.chapters[index];
                final isBookmarked =
                    chapter.id == _bookmarkedChapterId;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(chapter.title),
                    trailing: Icon(
                      isBookmarked
                          ? Icons.bookmark
                          : Icons.menu_book,
                    ),
                    onTap: () {
                      _openReader(chapter);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}