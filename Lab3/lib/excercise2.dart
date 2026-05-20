class User{
  final String? name;
  final String? email;
  User({this.name, this.email});

  factory User.fromJson(Map<String, String> json){
    return User(
      name: json["name"] as String,
      email: json["email"] as String
    );
  }
  String toString(){
    return "User: Name: $name, Email: $email";
  }
}
void main() async{
  final List<User> users = [];
  Future<List<User>> getUsers() async{
    await Future.delayed(Duration(seconds: 1));
    return users;
  }
  void addUser(User user){
    users.add(user);
  }
  Map<String, String> apiJson1 = {
    "name" : "Duong",
    "email" : "abc@gmail.com"
  };
  Map<String, String> apiJson2 = {
    "name" : "Anh",
    "email" : "ddd@gmail.com"
  };
  Map<String, String> apiJson3 = {
    "name" : "Tung",
    "email" : "pqd@gmail.com"
  };
  User user1 = User.fromJson(apiJson1);
  User user2 = User.fromJson(apiJson2);
  User user3 = User.fromJson(apiJson3);
  addUser(user1);
  addUser(user2);
  addUser(user3);
  var userList = await getUsers();
  for(User user in userList){
    print(user);
  }
}