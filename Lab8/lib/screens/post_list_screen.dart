import 'package:flutter/material.dart';

import '../models/post.dart';

import '../services/api_service.dart';

import '../widgets/post_card.dart';



/// Displays posts received from API.
///
/// This screen uses FutureBuilder because:
///
/// API request does not return immediately.
///
/// Flow:
///
/// Open screen
///      ↓
/// Call API
///      ↓
/// waiting
///      ↓
/// receive data
///      ↓
/// display ListView
class PostListScreen extends StatelessWidget {


  const PostListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ApiService apiService =
    ApiService();
    return Scaffold(


      appBar: AppBar(

        title: const Text(
          'Posts',
        ),

      ),

      body: FutureBuilder<List<Post>>(
        future: apiService.fetchPosts(),
        builder:
            (
            context,
            snapshot,
            ){
          // Loading state.
          //
          // While waiting for API response,
          // show progress indicator.
          if(snapshot.connectionState ==
              ConnectionState.waiting){


            return const Center(

              child:
              CircularProgressIndicator(),

            );

          }



          // Error state.
          //
          // Happens when:
          // - no internet
          // - API failure
          // - parsing error
          if(snapshot.hasError){


            return Center(

              child: Column(

                mainAxisAlignment:
                MainAxisAlignment.center,


                children: [


                  const Text(
                    'Something went wrong',
                  ),


                  const SizedBox(height:12),


                  Text(
                    snapshot.error.toString(),
                    textAlign:
                    TextAlign.center,
                  ),


                ],

              ),

            );


          }




          // Success state.
          //
          // snapshot.data contains List<Post>
          if(snapshot.hasData){


            final posts =
            snapshot.data!;



            return ListView.builder(


              padding:
              const EdgeInsets.all(16),



              itemCount:
              posts.length,



              itemBuilder:
                  (
                  context,
                  index,
                  ){


                return PostCard(

                  post:
                  posts[index],

                );


              },

            );


          }




          return const SizedBox();

        },

      ),

    );

  }

}