import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';


/// ApiService handles all communication with REST API.
///
/// Responsibilities:
///
/// - Send HTTP requests
/// - Receive JSON response
/// - Decode JSON
/// - Convert JSON into Model objects
///
/// UI should not directly call http.get().
///
/// Instead:
///
/// Screen
///    ↓
/// ApiService
///    ↓
/// REST API
class ApiService {


  final String baseUrl =
      'https://jsonplaceholder.typicode.com';



  /// Fetch posts from API.
  ///
  /// Return:
  ///
  /// Future<List<Post>>
  ///
  /// because network requests are asynchronous.
  Future<List<Post>> fetchPosts() async {


    try {


      final response = await http.get(

        Uri.parse(
          '$baseUrl/posts',
        ),

      );



      // HTTP status 200 means request succeeded.
      if(response.statusCode == 200){


        // Convert JSON string into Dart object.
        //
        // Because API returns an array,
        // jsonDecode returns List<dynamic>.
        final List<dynamic> jsonList =
        jsonDecode(response.body);



        // Convert every JSON object into Post model.
        return jsonList
            .map(
              (json) =>
              Post.fromJson(json),
        )
            .toList();


      }


      else {


        throw Exception(
          'Failed to load posts',
        );


      }


    }


    catch(error){


      // Convert all errors into readable exception.
      throw Exception(
        'Something went wrong: $error',
      );


    }

  }

}