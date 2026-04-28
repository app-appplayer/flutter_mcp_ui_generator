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

  // TC-208: TypeScriptCodeGenerator.fromDefinition
  group('TC-208: TypeScriptCodeGenerator.fromDefinition', () {
    test('Normal: converts definition to valid TypeScript source', () {
      final code = TypeScriptCodeGenerator.fromDefinition(sampleApp);

      expect(code, isA<String>());
      expect(code, contains('export function'));
      expect(code, contains('MCPUIDefinition'));
    });

    test('Boundary: minimal definition', () {
      final code = TypeScriptCodeGenerator.fromDefinition(sampleWidget);

      expect(code, isA<String>());
      expect(code, contains('export function'));
    });
  });

  // TC-209: TypeScriptCodeGenerator.fromApplication, fromPage, fromWidget
  group('TC-209: TypeScriptCodeGenerator.fromApplication/fromPage/fromWidget', () {
    test('Normal: fromApplication produces TypeScript code', () {
      final code = TypeScriptCodeGenerator.fromApplication(sampleApp);

      expect(code, isA<String>());
      expect(code, contains('createApplication'));
    });

    test('Normal: fromPage produces TypeScript code', () {
      final code = TypeScriptCodeGenerator.fromPage(samplePage);

      expect(code, isA<String>());
    });

    test('Normal: fromWidget produces TypeScript code', () {
      final code = TypeScriptCodeGenerator.fromWidget(sampleWidget);

      expect(code, isA<String>());
    });

    test('Boundary: empty/minimal input', () {
      final code = TypeScriptCodeGenerator.fromWidget({'type': 'box'});

      expect(code, isA<String>());
    });
  });
}
