import 'package:flutter/material.dart';

import '../models/post.dart';



/// PostCard displays one post item.
///
/// This widget only handles UI.
/// It does not know anything about API.
class PostCard extends StatelessWidget {


  final Post post;



  const PostCard({

    super.key,

    required this.post,

  });



  @override
  Widget build(BuildContext context) {


    return Card(


      margin:
      const EdgeInsets.only(
        bottom:12,
      ),



      child: Padding(

        padding:
        const EdgeInsets.all(16),



        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,


          children: [


            Text(

              '#${post.id}',

              style:
              Theme.of(context)
                  .textTheme
                  .labelMedium,

            ),



            const SizedBox(
              height:8,
            ),



            Text(

              post.title,

              style:
              Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(

                fontWeight:
                FontWeight.bold,

              ),

            ),



            const SizedBox(
              height:8,
            ),



            Text(
              post.body,
            ),


          ],

        ),

      ),

    );

  }

}