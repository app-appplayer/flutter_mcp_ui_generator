import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  group('Helpers', () {
    test('binding', () {
      expect(MCPUIJsonGenerator.binding('user.name'), equals('{{user.name}}'));
      expect(MCPUIJsonGenerator.binding('form.email'), equals('{{form.email}}'));
      expect(MCPUIJsonGenerator.binding('data.items'), equals('{{data.items}}'));
    });

    test('conditional', () {
      final conditional = MCPUIJsonGenerator.conditional(
        'isLoggedIn',
        'Welcome',
        'Please login',
      );
      expect(conditional, equals('{{isLoggedIn ? Welcome : Please login}}'));
    });

    test('toPrettyJson', () {
      final widget = {'type': 'text', 'content': 'Hello'};
      final json = MCPUIJsonGenerator.toPrettyJson(widget);

      expect(json.contains('{\n'), true);
      expect(json.contains('"type": "text"'), true);
    });
  });
}