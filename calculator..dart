import 'dart:io';

void main() {
  print('Basic Calculator in Dart');

  // Read first number
  stdout.write('Enter first number: ');
  double num1 = double.parse(stdin.readLineSync()!);

  // Read operator
  stdout.write('Enter an operator (+, -, *, /): ');
  String operator = stdin.readLineSync()!;

  // Read second number
  stdout.write('Enter second number: ');
  double num2 = double.parse(stdin.readLineSync()!);

  double result;

  // Perform calculation based on operator
  switch (operator) {
    case '+':
      result = num1 + num2;
      print('Result: $num1 + $num2 = $result');
      break;
    case '-':
      result = num1 - num2;
      print('Result: $num1 - $num2 = $result');
      break;
    case '*':
      result = num1 * num2;
      print('Result: $num1 * $num2 = $result');
      break;
    case '/':
      if (num2 != 0) {
        result = num1 / num2;
        print('Result: $num1 / $num2 = $result');
      } else {
        print('Error: Division by zero is not allowed.');
      }
      break;
    default:
      print('Invalid operator.');
  }
}
