import 'dart:async';

void main() {
  print('1. Start');

  scheduleMicrotask(() {
    print('2. Microtask');
  });

  Future(() {
    print('3. Future event');
  });

  print('4. End');
  // Microtasks run before event queue callbacks because Dart always processes the microtask queue first.
}