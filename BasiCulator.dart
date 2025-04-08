import 'dart:io';

void main() {
  print("📌 BasiCulator - Basic Calculator");
  print("Enter the first number: ");
  double? n1 = double.parse(stdin.readLineSync()!);
  print("Enter the second number: ");
  double? n2 = double.parse(stdin.readLineSync()!);
  print("Choose an operation (+, -, *, /, comp): ");
  String? operation = stdin.readLineSync();
  double result = 0.0;
  switch (operation) {
    case '+':
      result = n1 + n2;
      break;
    case '-':
      result = n1 - n2;
      break;
    case '*':
      result = n1 * n2;
      break;
    case '/':
      if (n2 != 0) {
        result = n1 / n2;
      } else {
        print("Error: Division by zero is not allowed.");
        return;
      }
      break;

    case 'comp':
      print('Comparison results');
      print('$n1 > $n2 : ${n1 > n2}');
      print('$n1 < $n2 : ${n1 < n2}');
      print('$n1 >= $n2 : ${n1 >= n2}');
      print('$n1 <= $n2 : ${n1 <= n2}');
      print('$n1 == $n2 : ${n1 == n2}');
      print('$n1 != $n2 : ${n1 != n2}');
      return;
    default:
      print("Error: Invalid operation.");
      return;
  }
  print("The result of $n1 $operation $n2 is $result");
}
