import 'dart:io';

void main() {
  print("Enter a number: ");
  int? n = int.parse(stdin.readLineSync()!);
  int sum = 0;
  for (int i = 1; i <= 10; i++) {
    print("$n x $i = ${n * i}");
    sum += n * i;
  }
  print("Sum = $sum");
}
