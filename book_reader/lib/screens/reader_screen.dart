import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/bookmark_service.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;
  final Chapter chapter;

  const ReaderScreen({
    super.key,
    required this.book,
    required this.chapter,
  });

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final BookmarkService _bookmarkService = BookmarkService();

  bool _isBookmarked = false;
  bool _isLoadingBookmark = true;

  @override
  void initState() {
    super.initState();
    _loadBookmarkStatus();
  }

  Future<void> _loadBookmarkStatus() async {
    final isBookmarked = await _bookmarkService.isChapterBookmarked(
      bookId: widget.book.id,
      chapterId: widget.chapter.id,
    );

    if (!mounted) return;

    setState(() {
      _isBookmarked = isBookmarked;
      _isLoadingBookmark = false;
    });
  }

  Future<void> _toggleBookmark() async {
    if (_isBookmarked) {
      await _bookmarkService.removeBookmark(widget.book.id);
    } else {
      await _bookmarkService.saveBookmark(
        bookId: widget.book.id,
        chapterId: widget.chapter.id,
      );
    }

    if (!mounted) return;

    setState(() {
      _isBookmarked = !_isBookmarked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked ? 'Bookmark saved' : 'Bookmark removed',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final chapter = widget.chapter;

    return Scaffold(
      appBar: AppBar(
        title: Text(chapter.title),
        actions: [
          IconButton(
            onPressed: _isLoadingBookmark ? null : _toggleBookmark,
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            ),
            tooltip: _isBookmarked ? 'Remove bookmark' : 'Save bookmark',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              chapter.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            SelectableText(
              chapter.content,
              style: const TextStyle(
                fontSize: 18,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}