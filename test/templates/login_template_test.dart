import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-197: LoginTemplate
  group('TC-197: LoginTemplate', () {
    test('Normal: generates login form', () {
      final template = LoginTemplate();
      final result = template.generate(title: 'Login');

      expect(result['type'], equals('page'));
      expect(result['title'], equals('Login'));
      expect(result['content'], isA<Map>());
    });

    test('Normal: implements Template abstract class', () {
      final template = LoginTemplate();
      expect(template, isA<Template>());
    });

    test('Boundary: custom auth flow action via config', () {
      final template = LoginTemplate();
      final result = template.generate(
        title: 'Sign In',
        config: {'authTool': 'customAuth'},
      );

      expect(result['title'], equals('Sign In'));
    });
  });
}
