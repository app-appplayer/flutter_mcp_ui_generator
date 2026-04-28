import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-145: MCPUIJsonGenerator.withAccessibility
  group('TC-145: MCPUIJsonGenerator.withAccessibility', () {
    test('Normal: wraps widget with accessibility properties', () {
      final w = MCPUIJsonGenerator.withAccessibility(
        MCPUIJsonGenerator.button(
          label: 'Submit',
          click: MCPUIJsonGenerator.toolAction('submit'),
        ),
        label: 'Submit',
        description: 'Submits the form',
        role: 'button',
      );

      expect(w['type'], equals('button'));
      expect(w['label'], equals('Submit'));
      expect(w['description'], equals('Submits the form'));
      expect(w['role'], equals('button'));
    });

    test('Boundary: only label provided', () {
      final w = MCPUIJsonGenerator.withAccessibility(
        MCPUIJsonGenerator.text('Hello'),
        label: 'Greeting text',
      );

      expect(w['type'], equals('text'));
      expect(w['label'], equals('Greeting text'));
      expect(w.containsKey('role'), isFalse);
    });
  });

  // TC-146: MCPUIJsonGenerator.accessibleButton
  group('TC-146: MCPUIJsonGenerator.accessibleButton', () {
    test('Normal: produces button with accessibility properties', () {
      final w = MCPUIJsonGenerator.accessibleButton(
        label: 'Save',
        click: MCPUIJsonGenerator.toolAction('save'),
        accessibilityLabel: 'Save document',
      );

      expect(w['type'], equals('button'));
      // accessibilityLabel overrides label in the accessibility wrapper
      expect(w['label'], equals('Save document'));
      expect(w.containsKey('role'), isTrue);
    });

    test('Boundary: minimal params', () {
      final w = MCPUIJsonGenerator.accessibleButton(
        label: 'OK',
        click: MCPUIJsonGenerator.toolAction('ok'),
      );

      expect(w['type'], equals('button'));
    });
  });

  // TC-147: MCPUIJsonGenerator.accessibleTextInput
  group('TC-147: MCPUIJsonGenerator.accessibleTextInput', () {
    test('Normal: produces text input with accessibility', () {
      final w = MCPUIJsonGenerator.accessibleTextInput(
        label: 'Email',
        value: '{{email}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'email',
          value: '{{event.value}}',
        ),
        accessibilityLabel: 'Email address input',
        accessibilityDescription: 'Enter your email address',
      );

      expect(w['type'], equals('textInput'));
      expect(w.containsKey('role'), isTrue);
    });

    test('Boundary: minimal params', () {
      final w = MCPUIJsonGenerator.accessibleTextInput(
        label: 'Name',
        value: '{{name}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'name',
        ),
      );

      expect(w['type'], equals('textInput'));
    });
  });
}
