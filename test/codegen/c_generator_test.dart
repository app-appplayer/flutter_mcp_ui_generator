import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  group('CCodeGenerator', () {
    test('fromDefinition emits header guard, function, and JSON literal', () {
      final code = CCodeGenerator.fromDefinition({
        'type': 'application',
        'title': 'Demo',
        'version': '1.0',
        'routes': {'/': 'home.json'},
      });

      expect(code, contains('#ifndef MCP_UI_CREATE_APPLICATION_H'));
      expect(code, contains('#define MCP_UI_CREATE_APPLICATION_H'));
      expect(code, contains('#endif /* MCP_UI_CREATE_APPLICATION_H */'));
      expect(code, contains('static inline const char* create_application(void)'));
      expect(code, contains(r'\"type\":\"application\"'));
      expect(code, contains(r'\"title\":\"Demo\"'));
    });

    test('fromApplication uses fixed function and guard names', () {
      final code = CCodeGenerator.fromApplication({
        'type': 'application',
        'routes': {},
      });

      expect(code, contains('static inline const char* create_application(void)'));
      expect(code, contains('#ifndef MCP_UI_APPLICATION_H'));
    });

    test('fromPage builds function name from title (snake_case)', () {
      final code = CCodeGenerator.fromPage({
        'type': 'page',
        'title': 'Home Page',
      });

      expect(code, contains('create_home_page_page(void)'));
    });

    test('fromWidget builds function name from widget type', () {
      final code = CCodeGenerator.fromWidget({
        'type': 'button',
        'label': 'Click',
      });

      expect(code, contains('create_button(void)'));
    });

    test('escapes JSON characters that would break a C string literal', () {
      final code = CCodeGenerator.fromDefinition({
        'type': 'text',
        'value': 'line1\nline2\t"quoted"\\backslash',
      });

      // Newline is part of JSON encoding (\n in the string), then the
      // dart-side encoder backslash-escapes for the literal.
      expect(code, contains(r'\\n'));
      expect(code, contains(r'\\t'));
      expect(code, contains(r'\\\"'));
      expect(code, contains(r'\\\\'));
    });

    test('long JSON is split across adjacent string literals', () {
      // Build a payload longer than the 200-char chunk size.
      final longValue = List.filled(50, 'x').join('') * 5;
      final code = CCodeGenerator.fromDefinition({
        'type': 'text',
        'value': longValue,
      });

      // Adjacent string literals concatenate at compile time in C; we
      // just need to see at least one boundary `" "` pair on its own
      // line of indentation.
      expect(code.contains('"\n        "'), isTrue);
    });

    test('UTF-8 multibyte is emitted as raw byte hex escapes', () {
      final code = CCodeGenerator.fromDefinition({
        'type': 'text',
        'value': '한',
      });

      // `한` U+D55C in UTF-8 = `ED 95 9C` — three hex escapes.
      expect(code, contains(r'\xED\x95\x9C'));
    });
  });
}
