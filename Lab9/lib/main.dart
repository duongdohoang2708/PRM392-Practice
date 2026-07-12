import 'package:flutter/material.dart';

import 'screens/book_screen.dart';

void main() {
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Book Manager",

      theme: ThemeData(useMaterial3: true),

      home: const BookScreen(),
    );
  }
}
