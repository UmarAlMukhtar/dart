import 'dart:io';

class Car {
  String? name;
  int? price;

  Car({this.name, this.price});

  @override
  String toString() {
    return '$name (\$${price})';
  }

  void changePrice(int newPrice) {
    price = newPrice;
  }
}

class Person {
  String? name;
  List<Car>? ownedCars;
  int? moneyLeft;

  Person({this.name, this.ownedCars, this.moneyLeft});

  @override
  String toString() {
    return 'Person{name: $name, cars: $ownedCars, moneyLeft: $moneyLeft}';
  }

  void buyCar(Car car) {
    if (moneyLeft != null && car.price != null && moneyLeft! >= car.price!) {
      ownedCars?.add(car);
      moneyLeft = moneyLeft! - car.price!;
    } else {
      print('Not enough money to buy the car.');
    }
  }

  void sellCar(Car car) {
    if (ownedCars != null && ownedCars!.contains(car)) {
      ownedCars?.remove(car);
      moneyLeft = moneyLeft! + car.price!;
    } else {
      print('Car not found in the collection.');
    }
  }
}

void main() {
  print('Enter your name: ');
  String? name = stdin.readLineSync();
  print('Enter your money: ');
  int? money = int.parse(stdin.readLineSync()!);

  Person person = Person(name: name, moneyLeft: money, ownedCars: []);

  print('Your name is ${person.name} and you have \$${person.moneyLeft}.');

  List<Car> cars = [
    Car(name: 'Dodge', price: 10000),
    Car(name: 'Lamborghini', price: 20000),
    Car(name: 'Ferrari', price: 30000),
    Car(name: 'BMW', price: 40000),
    Car(name: 'Mercedes', price: 50000),
    Car(name: 'Toyota', price: 60000),
    Car(name: 'Honda', price: 70000),
    Car(name: 'Nissan', price: 80000),
    Car(name: 'Ford', price: 90000),
    Car(name: 'Chevrolet', price: 100000),
  ];

  while (true) {
    print("\n--- Menu ---");
    print("1. Buy a car");
    print("2. Sell a car");
    print("3. Show your cars");
    print("4. Show your money left");
    print("5. Exit");
    stdout.write("Enter your choice: ");
    int? choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        print("\nAvailable cars: ");
        for (int i = 0; i < cars.length; i++) {
          print('${i + 1}. ${cars[i]}');
        }
        stdout.write("Enter the name of the car you want to buy: ");
        String? carName = stdin.readLineSync();
        Car? carToBuy;
        for (var car in cars) {
          if (car.name!.toLowerCase() == carName!.toLowerCase()) {
            carToBuy = car;
            break;
          }
        }
        if (carToBuy != null) {
          person.buyCar(carToBuy);
          if (person.moneyLeft! < carToBuy.price!) {
            break;
          } else {
            print("You bought the car: ${carToBuy}");
          }
        } else {
          print("Car not found.");
        }
        break;

      case 2:
        if (person.ownedCars!.isEmpty) {
          print("You have no cars to sell.");
          break;
        }
        print("\nYour cars: ");
        for (int i = 0; i < person.ownedCars!.length; i++) {
          print('${i + 1}. ${person.ownedCars![i]}');
        }
        stdout.write("Enter the name of the car you want to sell: ");
        String? carNameToSell = stdin.readLineSync();
        Car? carToSell;
        for (var car in person.ownedCars!) {
          if (car.name!.toLowerCase() == carNameToSell!.toLowerCase()) {
            carToSell = car;
            break;
          }
        }
        if (carToSell != null) {
          person.sellCar(carToSell);
          print("You sold the car: ${carToSell}");
        } else {
          print("Car not found.");
        }
        break;

      case 3:
        if (person.ownedCars!.isEmpty) {
          print("You have no cars.");
        } else {
          print("\nYour cars: ");
          for (var car in person.ownedCars!) {
            print('- $car');
          }
        }
        break;

      case 4:
        print("\nYour money left: \$${person.moneyLeft}");
        break;

      case 5:
        print("Exiting the program.");
        return;

      default:
        print("Invalid choice. Please try again.");
    }
  }
}
