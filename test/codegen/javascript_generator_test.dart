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

  // TC-210: JavaScriptCodeGenerator.fromDefinition
  group('TC-210: JavaScriptCodeGenerator.fromDefinition', () {
    test('Normal: converts definition to valid JavaScript source', () {
      final code = JavaScriptCodeGenerator.fromDefinition(sampleApp);

      expect(code, isA<String>());
      expect(code, contains('export function'));
    });

    test('Boundary: minimal definition', () {
      final code = JavaScriptCodeGenerator.fromDefinition(sampleWidget);

      expect(code, isA<String>());
      expect(code, contains('export function'));
    });
  });

  // TC-211: JavaScriptCodeGenerator.fromApplication, fromPage, fromWidget
  group('TC-211: JavaScriptCodeGenerator.fromApplication/fromPage/fromWidget', () {
    test('Normal: fromApplication produces JavaScript code', () {
      final code = JavaScriptCodeGenerator.fromApplication(sampleApp);

      expect(code, isA<String>());
      expect(code, contains('createApplication'));
    });

    test('Normal: fromPage produces JavaScript code', () {
      final code = JavaScriptCodeGenerator.fromPage(samplePage);

      expect(code, isA<String>());
    });

    test('Normal: fromWidget produces JavaScript code', () {
      final code = JavaScriptCodeGenerator.fromWidget(sampleWidget);

      expect(code, isA<String>());
    });

    test('Boundary: empty/minimal input', () {
      final code = JavaScriptCodeGenerator.fromWidget({'type': 'box'});

      expect(code, isA<String>());
    });
  });
}
