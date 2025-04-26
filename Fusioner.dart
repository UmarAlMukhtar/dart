import 'dart:io';

void main() {
  List<int> numbers = [];
  print("Enter the no of numbers: ");
  int n = int.parse(stdin.readLineSync()!);
  print("Enter the list of numbers(press enter after each no):");
  for (int i = 0; i < n; i++) {
    int num = int.parse(stdin.readLineSync()!);
    numbers.add(num);
  }

  var doubleNumbers = (int number) => number * 2;
  var squareNumbers = (int number) => number * number;

  print("Double of numbers: ");
  processList(numbers, doubleNumbers);
  print("Square of numbers: ");
  processList(numbers, squareNumbers);
}

void processList(List<int> numbers, int Function(int) operation) {
  for (var number in numbers) {
    print("The result of the operation on $number is: ${operation(number)}");
  }
}
