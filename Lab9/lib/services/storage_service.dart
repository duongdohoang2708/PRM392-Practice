import 'dart:convert';

import 'dart:io';

import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';

import '../models/book.dart';

class StorageService {
  static const String fileName = "books.json";

  /// Load initial JSON from assets.
  ///
  /// Used for Lab 9.1.
  Future<List<Book>> loadAssetBooks() async {
    final String jsonString = await rootBundle.loadString(
      "assets/data/books.json",
    );

    final List<dynamic> jsonList = jsonDecode(jsonString);

    return jsonList.map((item) => Book.fromJson(item)).toList();
  }

  /// Get application document directory.
  Future<File> getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File("${directory.path}/$fileName");
  }

  /// Read JSON from device storage.
  ///
  /// If file does not exist:
  /// create it from assets.
  Future<List<Book>> loadBooks() async {
    final file = await getLocalFile();

    if (!await file.exists()) {
      final books = await loadAssetBooks();

      await saveBooks(books);

      return books;
    }

    final jsonString = await file.readAsString();

    final List<dynamic> jsonList = jsonDecode(jsonString);

    return jsonList.map((item) => Book.fromJson(item)).toList();
  }

  /// Save list of books into JSON file.
  ///
  /// This method is called after:
  ///
  /// Add
  /// Edit
  /// Delete
  Future<void> saveBooks(List<Book> books) async {
    final file = await getLocalFile();

    final jsonString = jsonEncode(books.map((book) => book.toJson()).toList());

    await file.writeAsString(jsonString);
  }
}
