import 'package:flutter/material.dart';

import 'screens/post_list_screen.dart';

void main() {
  // Entry point of Flutter application.
  runApp(const ApiListApp());
}


/// Root widget of Lab 8.
///
/// Responsibilities:
/// - Create MaterialApp
/// - Configure theme
/// - Define first screen
///
/// This widget does not contain business logic.
class ApiListApp extends StatelessWidget {
  const ApiListApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'API List App',

      // Remove debug banner.
      debugShowCheckedModeBanner: false,


      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),


      // First screen.
      home: const PostListScreen(),
    );
  }
}