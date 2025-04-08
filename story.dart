import 'dart:io';

void main() {
  print("📌 Personal Biodata Generator");

  print("Enter your Name: ");
  String name = stdin.readLineSync() ?? "";

  print("Enter your Phone Number: ");
  String phone = stdin.readLineSync() ?? "";

  print("Enter your Age: ");
  int age = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;

  print("Enter your Height (in cm): ");
  double height = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;

  print("Enter your Weight (in kg): ");
  double weight = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;

  print("Enter your Address: ");
  String address = stdin.readLineSync() ?? "";

  print("Enter your Hobbies (comma-separated): ");
  String hobbiesInput = stdin.readLineSync() ?? "";
  List<String> hobbies = hobbiesInput.split(',').map((h) => h.trim()).toList();

  // Display Biodata
  print("\n========================================");
  print("            Personal Biodata          ");
  print("========================================");
  print("Name      : $name");
  print("Phone No. : $phone");
  print("Age       : $age years");
  print("Height    : $height cm");
  print("Weight    : $weight kg");
  print("Address   : $address");
  print("Hobbies   : ${hobbies.join(', ')}");
  print("========================================");
}
