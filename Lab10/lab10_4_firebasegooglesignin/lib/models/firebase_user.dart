/// Application user model.
///
/// This wraps FirebaseUser data
/// into our own model.
class FirebaseUserModel {


  final String uid;


  final String name;


  final String email;


  final String photoUrl;



  const FirebaseUserModel({

    required this.uid,

    required this.name,

    required this.email,

    required this.photoUrl,

  });


}