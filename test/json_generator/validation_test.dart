import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-148: MCPUIJsonGenerator.validation
  group('TC-148: MCPUIJsonGenerator.validation', () {
    test('Normal: produces validation rule map', () {
      final v = MCPUIJsonGenerator.validation(
        required: true,
        minLength: 3,
        maxLength: 50,
        pattern: r'^[a-zA-Z]+$',
      );

      expect(v['required'], isTrue);
      expect(v['minLength'], equals(3));
      expect(v['maxLength'], equals(50));
      expect(v['pattern'], isA<String>());
    });

    test('Boundary: custom error message', () {
      final v = MCPUIJsonGenerator.validation(
        required: true,
        message: 'Field is mandatory',
      );

      expect(v['required'], isTrue);
      expect(v['message'], equals('Field is mandatory'));
    });
  });

  // TC-149: MCPUIJsonGenerator.requiredValidation
  group('TC-149: MCPUIJsonGenerator.requiredValidation', () {
    test('Normal: produces required validation shorthand', () {
      final v = MCPUIJsonGenerator.requiredValidation();

      expect(v['required'], isTrue);
      expect(v['message'], isA<String>());
    });

    test('Boundary: custom message', () {
      final v = MCPUIJsonGenerator.requiredValidation(message: 'Please fill in');

      expect(v['required'], isTrue);
      expect(v['message'], equals('Please fill in'));
    });
  });

  // TC-150: MCPUIJsonGenerator.emailValidation
  group('TC-150: MCPUIJsonGenerator.emailValidation', () {
    test('Normal: produces email validation shorthand', () {
      final v = MCPUIJsonGenerator.emailValidation();

      expect(v['email'], isA<String>());
      expect(v['message'], isA<String>());
    });

    test('Boundary: custom message', () {
      final v = MCPUIJsonGenerator.emailValidation(message: 'Bad email');

      expect(v['email'], isA<String>());
      expect(v['message'], equals('Bad email'));
    });
  });
}
