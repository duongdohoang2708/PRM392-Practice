void main() {
  //if/else
  print("--------------IF/ELSE--------------");
  int score = 60;
  if (score > 50) {
    print("Passed");
  } else
    print("Not Passed");
  //switch case
  print("--------------SWITCH--------------");
  String day = "Monday";
  switch (day) {
    case "Monday" :
      print("Frist day of the week");
      break;
    case "Sunday" :
      print("Last day of the week");
      break;
    default:
      print("Middle day of the week");
  }
      //loop
      print("--------------LOOP--------------");
      List<String> fruits = [
        "Apple",
        "Banana",
        "Orange"
      ];
      //for loop
      print("FOR LOOP");
      for (int i = 0; i < fruits.length; i++) {
        print(fruits[i]);
      }
      print("FOR-IN LOOP");
      for (String fruit in fruits){
        print(fruit);
      }
      print("FOR-EACH LOOP");
      fruits.forEach(
              (fruit) {print(fruit);}
      );
      print("--------------FUNCTIONS--------------");
      int add(int a, int b) {//normal function
        return a + b;
      }
      int multiply(int a, int b) => a * b;//arrow function

      int result1 = add(5, 3);
      print("Normal function: $result1");
      int result2 = multiply(4, 2);
      print("Arrow function: $result2");

}