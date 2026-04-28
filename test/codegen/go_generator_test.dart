import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  final sampleApp = MCPUIJsonGenerator.application(
    title: 'Test App',
    version: '1.0.0',
    routes: {'/': 'ui://pages/home'},
  );

  final samplePage = MCPUIJsonGenerator.page(
    title: 'Home',
    content: MCPUIJsonGenerator.text('Hello'),
  );

  final sampleWidget = MCPUIJsonGenerator.text('Hello World');

  // TC-212: GoCodeGenerator.fromDefinition
  group('TC-212: GoCodeGenerator.fromDefinition', () {
    test('Normal: converts definition to valid Go source', () {
      final code = GoCodeGenerator.fromDefinition(sampleApp);

      expect(code, isA<String>());
      expect(code, contains('package'));
      expect(code, contains('func'));
      expect(code, contains('map[string]interface{}'));
    });

    test('Boundary: minimal definition', () {
      final code = GoCodeGenerator.fromDefinition(sampleWidget);

      expect(code, isA<String>());
      expect(code, contains('package'));
    });
  });

  // TC-213: GoCodeGenerator.fromApplication, fromPage, fromWidget
  group('TC-213: GoCodeGenerator.fromApplication/fromPage/fromWidget', () {
    test('Normal: fromApplication produces Go code with package main', () {
      final code = GoCodeGenerator.fromApplication(sampleApp);

      expect(code, isA<String>());
      expect(code, contains('package main'));
      expect(code, contains('CreateApplication'));
    });

    test('Normal: fromPage produces Go code with package mcpui', () {
      final code = GoCodeGenerator.fromPage(samplePage);

      expect(code, isA<String>());
      expect(code, contains('package mcpui'));
    });

    test('Normal: fromWidget produces Go code with package mcpui', () {
      final code = GoCodeGenerator.fromWidget(sampleWidget);

      expect(code, isA<String>());
      expect(code, contains('package mcpui'));
    });

    test('Boundary: empty/minimal input', () {
      final code = GoCodeGenerator.fromWidget({'type': 'box'});

      expect(code, isA<String>());
    });
  });
}
