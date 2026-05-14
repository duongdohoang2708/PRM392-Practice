void main(){
  print("--------------LIST--------------");
  List<int> numbers = [10, 20, 30];
  //indexing
  print("First number: ${numbers[0]}");
  //add
  numbers.add(40);
  //remove
  numbers.remove(20);
  print("Updated list: $numbers");

  print("--------------OPERATORS--------------");
  int a = 10;
  int b = 5;
  //arithmetic
  print("a + b = ${a+b}");
  print("a - b = ${a-b}");
  //comparison
  print("a == b: ${a==b}");
  print("a > b: ${a>b}");
  //logical
  bool isStudent = true;
  bool hasTicket = false;
  print("Student can enter: ${isStudent && hasTicket}");
  //ternary operator
  String result = (a>b)? "a is bigger" : "b is bigger";
  print(result);

  print("------------------SET--------------");
  Set<String> fruits = {"apple", "banana", "peach"};
  print("Fruits set: $fruits");
  //add
  fruits.add("orange");
  fruits.add("banana");
  //remove
  fruits.remove("peach");
  print("Updated fruits set: $fruits");

  print("------------------MAP--------------");
  Map<String, String> user = {
    "name" : "Duong",
    "age" : "22",
    "address" : "Hanoi"
  };
  print("User name:  ${user["name"]}");
  //add
  user["gender"] = "Male";
  //update
  user["age"] = "20";
  //remove
  user.remove("name");
  print("Updated map: $user");
}