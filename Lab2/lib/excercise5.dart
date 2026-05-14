void main() async {
  //async/await
  print("--------------ASYNC/AWAIT--------------");
  Future<String> loadData() async {
    await Future.delayed(Duration(seconds: 2));
    return "Data loaded successfully!";
  }
  print("Loading...");
  String data =  await loadData();
  print(data);

  print("--------------NULL SAFETY--------------");
  //null safety
  String? username;
  //use ? when variable can be null
  print("Username length: ${username?.length}");
  //use ?? to assign default value when variable is null
  print("Username: ${username ?? "Duong"}");
  //use ! to force Dart beleive that variable is not null
  username = "Duong";
  print("Username uppercase: ${username!.toUpperCase()}");

  print("--------------STREAM--------------");
  Stream<int> countNumbers() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }
    Stream<int> numberStream = countNumbers();

    numberStream.listen((number) {
      print("Stream value: $number");
    });

}