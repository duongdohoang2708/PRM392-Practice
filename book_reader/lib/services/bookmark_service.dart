import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService {
  String _bookmarkKey(String bookId) {
    return 'bookmark_$bookId';
  }

  Future<String?> getBookmarkedChapterId(String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_bookmarkKey(bookId));
  }

  Future<void> saveBookmark({
    required String bookId,
    required String chapterId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_bookmarkKey(bookId), chapterId);
  }

  Future<void> removeBookmark(String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_bookmarkKey(bookId));
  }

  Future<bool> isChapterBookmarked({
    required String bookId,
    required String chapterId,
  }) async {
    final bookmarkedChapterId = await getBookmarkedChapterId(bookId);
    return bookmarkedChapterId == chapterId;
  }
}