import 'package:flutter_test/flutter_test.dart';

double calc(double a, double b, String op) {
  if(b == 0) {
    throw ArgumentError();
  }

  switch (op) {
    case '+':
      return a + b;
    case '-':
      return a - b;
    case '*':
      return a * b;
    case '/':
      return b == 0 ? 0 : a / b;
    default:
      throw ArgumentError('Invalid operator: $op');
  }
}

void main() {

  group('Test Calc Method', () {

    test('Test Addition in calc method', () {

      /// AAA ( Arrange, Act, Assert )

      // Arrange
      const double num1 = 5;
      const double num2 = 10;
      const String operation = '+';

      // Act
      final double result = calc(num1, num2, operation);

      // Assert
      expect(result, 15);
      expect(result, isA<double>());

    });

    test('Test Subtraction in calc method', () {

      /// AAA ( Arrange, Act, Assert )

      // Arrange
      const double num1 = 5;
      const double num2 = 10;
      const String operation = '-';

      // Act
      final double result = calc(num1, num2, operation);

      // Assert
      expect(result, -5);
      expect(result, isA<double>());

    });

    test('Test Multiplication in calc method', () {

      /// AAA ( Arrange, Act, Assert )

      // Arrange
      const double num1 = 5;
      const double num2 = 10;
      const String operation = '*';

      // Act
      final double result = calc(num1, num2, operation);

      // Assert
      expect(result, 50);
      expect(result, isA<double>());

    });

    test('Test Division in calc method', () {
      /// AAA ( Arrange, Act, Assert )

      // Arrange
      const double num1 = 5;
      const double num2 = 10;
      const String operation = '/';

      // Act
      final double result = calc(num1, num2, operation);

      // Assert
      expect(result, 0.5);
      expect(result, isA<double>());
    });

    test('Test Division by Zero in calc method', () {
      /// AAA ( Arrange, Act, Assert )

      // Arrange
      const double num1 = 5;
      const double num2 = 0;
      const String operation = '/';

      // Act
      // Assert
      expect(() => calc(num1, num2, operation), throwsArgumentError);
    });

    test('Test When user enter invalid sign in calc method', () {
      /// AAA ( Arrange, Act, Assert )

      // Arrange
      const double num1 = 5;
      const double num2 = 10;
      const String operation = '#';

      // Act & Assert
      expect(() => calc(num1, num2, operation), throwsArgumentError);
    });

  });
}