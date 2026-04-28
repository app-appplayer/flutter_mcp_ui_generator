import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-200: QuickBuilders.textButton
  group('TC-200: QuickBuilders.textButton', () {
    test('Normal: creates text button with label and action', () {
      final action = MCPUIJsonGenerator.stateAction(
        action: 'set',
        binding: 'saved',
        value: true,
      );
      final button = QuickBuilders.textButton('Save', action);

      expect(button['type'], equals('button'));
      expect(button['label'], equals('Save'));
      expect(button['variant'], equals('text'));
      expect(button['onTap'], isNotNull);
    });

    test('Boundary: label with binding expression', () {
      final button = QuickBuilders.textButton(
        '{{buttonLabel}}',
        MCPUIJsonGenerator.stateAction(action: 'toggle', binding: 'flag'),
      );

      expect(button['label'], equals('{{buttonLabel}}'));
    });
  });

  // TC-201: QuickBuilders.iconButton
  group('TC-201: QuickBuilders.iconButton', () {
    test('Normal: creates elevated button with icon', () {
      final button = QuickBuilders.iconButton(
        label: 'Add',
        icon: 'add',
        click: MCPUIJsonGenerator.stateAction(
          action: 'append',
          binding: 'items',
          value: 'new item',
        ),
      );

      expect(button['type'], equals('button'));
      expect(button['label'], equals('Add'));
      expect(button['icon'], equals('add'));
      expect(button['variant'], equals('elevated'));
    });
  });

  // TC-202: QuickBuilders.formField
  group('TC-202: QuickBuilders.formField', () {
    test('Normal: creates form field with state binding', () {
      final field = QuickBuilders.formField(
        label: 'Username',
        path: 'user.name',
      );

      expect(field['type'], equals('textInput'));
      expect(field['label'], equals('Username'));
      expect(field['value'], equals('{{user.name}}'));
      expect(field['onChange'], isNotNull);
    });

    test('Boundary: optional parameters', () {
      final field = QuickBuilders.formField(
        label: 'Email',
        path: 'email',
        placeholder: 'Enter email',
        helperText: 'Your email address',
      );

      expect(field['placeholder'], equals('Enter email'));
      expect(field['helperText'], equals('Your email address'));
    });
  });

  // TC-203: QuickBuilders.section
  group('TC-203: QuickBuilders.section', () {
    test('Normal: creates labeled section', () {
      final section = QuickBuilders.section(
        title: 'Personal Info',
        children: [
          MCPUIJsonGenerator.text('Name: John'),
          MCPUIJsonGenerator.text('Age: 30'),
        ],
      );

      expect(section['type'], equals('linear'));
      expect(section['direction'], equals('vertical'));
      // First child should be the title text
      expect(section['children'], isA<List>());
      expect(section['children'].length, greaterThanOrEqualTo(2));
    });

    test('Boundary: empty children list', () {
      final section = QuickBuilders.section(
        title: 'Empty Section',
        children: [],
      );

      expect(section['type'], equals('linear'));
    });
  });

  // TC-204: QuickBuilders.loadingIndicator
  group('TC-204: QuickBuilders.loadingIndicator', () {
    test('Normal: creates centered spinner with message', () {
      final indicator = QuickBuilders.loadingIndicator('Loading...');

      expect(indicator['type'], equals('center'));
      expect(indicator['child'], isNotNull);
    });

    test('Boundary: no message creates spinner only', () {
      final indicator = QuickBuilders.loadingIndicator();

      expect(indicator['type'], equals('center'));
    });
  });

  // TC-205: QuickBuilders.errorMessage
  group('TC-205: QuickBuilders.errorMessage', () {
    test('Normal: creates styled error with icon', () {
      final error = QuickBuilders.errorMessage('Something went wrong');

      expect(error['type'], equals('box'));
      expect(error['child'], isNotNull);
    });
  });
}
