import 'dart:async';

void main(){
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  Stream<int> numberStream = Stream.fromIterable(numbers);
  numberStream.map((n) => n * n).
  where((n) => n.isEven).
  listen((data) {print(data);});
}