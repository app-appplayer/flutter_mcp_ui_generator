import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-194: FormTemplate
  group('TC-194: FormTemplate', () {
    test('Normal: generates form UI JSON', () {
      final template = FormTemplate();
      final result = template.generate(title: 'Registration');

      expect(result['type'], equals('page'));
      expect(result['title'], equals('Registration'));
      expect(result['content'], isA<Map>());
    });

    test('Normal: implements Template abstract class', () {
      final template = FormTemplate();
      expect(template, isA<Template>());
    });

    test('Boundary: custom field configuration via config', () {
      final template = FormTemplate();
      final result = template.generate(
        title: 'Custom Form',
        config: {
          'fields': [
            {'label': 'Email', 'path': 'email', 'type': 'email'},
          ],
          'submitLabel': 'Send',
        },
      );

      expect(result['title'], equals('Custom Form'));
    });
  });
}
