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

  group('TC-DG-1: DartCodeGenerator.fromDefinition', () {
    test('Normal: converts definition to valid Dart source', () {
      final code = DartCodeGenerator.fromDefinition(sampleApp);

      expect(code, isA<String>());
      // Function emits a `Map<String, dynamic>` returning function.
      expect(code, contains('Map<String, dynamic> create'));
      expect(code, contains('return'));
      // Generated header doc comment is present.
      expect(code, contains('Auto-generated MCP UI DSL definition'));
    });

    test('Boundary: minimal definition (single widget)', () {
      final code = DartCodeGenerator.fromDefinition(sampleWidget);

      expect(code, isA<String>());
      expect(code, contains('Map<String, dynamic> create'));
    });
  });

  group('TC-DG-2: fromApplication/fromPage/fromWidget', () {
    test('fromApplication uses createApplication name', () {
      final code = DartCodeGenerator.fromApplication(sampleApp);

      expect(code, contains('createApplication'));
    });

    test('fromPage uses Page suffix and PascalCases the title', () {
      final code = DartCodeGenerator.fromPage(samplePage);

      expect(code, contains('Page()'));
      expect(code, contains('Home'));
    });

    test('fromWidget uses createText for a text widget', () {
      final code = DartCodeGenerator.fromWidget(sampleWidget);

      expect(code, contains('createText'));
    });

    test('Boundary: empty/minimal widget input', () {
      final code = DartCodeGenerator.fromWidget(<String, dynamic>{
        'type': 'box',
      });

      expect(code, isA<String>());
      expect(code, contains('createBox'));
    });
  });

  group('TC-DG-3: literal escaping + value shapes', () {
    test('strings with single quotes / dollars are escaped', () {
      final code = DartCodeGenerator.fromWidget(<String, dynamic>{
        'type': 'text',
        'text': "Hello 'world' \$tricky",
      });
      // Must escape both `'` and `$` so the produced literal compiles.
      expect(code, contains(r"Hello \'world\' \$tricky"));
    });

    test('null / bool / int / double are emitted natively', () {
      final code = DartCodeGenerator.fromWidget(<String, dynamic>{
        'type': 'box',
        'show': true,
        'width': 16,
        'opacity': 0.5,
        'note': null,
      });
      expect(code, contains("'show': true"));
      expect(code, contains("'width': 16"));
      expect(code, contains("'opacity': 0.5"));
      expect(code, contains("'note': null"));
    });

    test('empty list / map use typed empty literals', () {
      final code = DartCodeGenerator.fromWidget(<String, dynamic>{
        'type': 'box',
        'children': <dynamic>[],
        'props': <String, dynamic>{},
      });
      expect(code, contains('<dynamic>[]'));
      expect(code, contains('<String, dynamic>{}'));
    });
  });

  group('TC-DG-4: toModule', () {
    test('produces a build() function and kModuleName const', () {
      final code = DartCodeGenerator.toModule('home_module', sampleApp);

      expect(code, contains("kModuleName = 'home_module'"));
      expect(code, contains('Map<String, dynamic> build()'));
    });
  });
}
