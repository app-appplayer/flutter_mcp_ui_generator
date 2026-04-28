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

  // TC-206: PythonCodeGenerator.fromDefinition
  group('TC-206: PythonCodeGenerator.fromDefinition', () {
    test('Normal: converts definition to valid Python source', () {
      final code = PythonCodeGenerator.fromDefinition(sampleApp);

      expect(code, isA<String>());
      expect(code, contains('def create_'));
      expect(code, contains('return'));
      expect(code, contains('import json'));
    });

    test('Boundary: minimal definition (single widget)', () {
      final code = PythonCodeGenerator.fromDefinition(sampleWidget);

      expect(code, isA<String>());
      expect(code, contains('def create_'));
    });
  });

  // TC-207: PythonCodeGenerator.fromApplication, fromPage, fromWidget
  group('TC-207: PythonCodeGenerator.fromApplication/fromPage/fromWidget', () {
    test('Normal: fromApplication produces Python code', () {
      final code = PythonCodeGenerator.fromApplication(sampleApp);

      expect(code, isA<String>());
      expect(code, contains('create_application'));
    });

    test('Normal: fromPage produces Python code', () {
      final code = PythonCodeGenerator.fromPage(samplePage);

      expect(code, isA<String>());
      expect(code, contains('page'));
    });

    test('Normal: fromWidget produces Python code', () {
      final code = PythonCodeGenerator.fromWidget(sampleWidget);

      expect(code, isA<String>());
      expect(code, contains('create_'));
    });

    test('Boundary: empty/minimal input', () {
      final code = PythonCodeGenerator.fromWidget({'type': 'box'});

      expect(code, isA<String>());
    });
  });
}
