import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  group('CppCodeGenerator', () {
    test('fromDefinition emits #pragma once, namespace, raw-string body', () {
      final code = CppCodeGenerator.fromDefinition({
        'type': 'application',
        'title': 'Demo',
        'routes': {},
      });

      expect(code, contains('#pragma once'));
      expect(code, contains('#include <string>'));
      expect(code, contains('namespace mcp_ui {'));
      expect(code, contains('}  // namespace mcp_ui'));
      expect(code, contains('inline std::string create_application()'));
      expect(code, contains('R"json('));
      expect(code, contains(')json"'));
    });

    test('namespace is configurable', () {
      final code = CppCodeGenerator.fromDefinition({
        'type': 'application',
        'routes': {},
      }, namespace: 'acme');

      expect(code, contains('namespace acme {'));
      expect(code, contains('}  // namespace acme'));
      expect(code, isNot(contains('namespace mcp_ui')));
    });

    test('empty namespace omits the wrapper', () {
      final code = CppCodeGenerator.fromDefinition({
        'type': 'application',
        'routes': {},
      }, namespace: '');

      expect(code, isNot(contains('namespace ')));
      expect(code, contains('inline std::string create_application()'));
    });

    test('default delimiter survives quote-bearing JSON payloads', () {
      // `jsonEncode` escapes every `"` → `\"`, so the closing
      // sequence `)json"` cannot appear in serialized JSON. The
      // default `json` delimiter is therefore safe across the
      // generator's normal input domain.
      final code = CppCodeGenerator.fromDefinition({
        'type': 'text',
        'value': 'string with )json" baked in',
      });

      // The payload's quote was escaped as `\"`, so the generator
      // can keep the canonical `json` delimiter.
      expect(code, contains('R"json('));
      expect(code, contains(')json"'));
    });

    test('fromPage / fromWidget produce sensible function names', () {
      expect(
          CppCodeGenerator.fromPage({'type': 'page', 'title': 'Home'}),
          contains('inline std::string create_home_page()'));
      expect(
          CppCodeGenerator.fromWidget({'type': 'button'}),
          contains('inline std::string create_button()'));
    });

    test('UTF-8 survives raw-string verbatim', () {
      final code = CppCodeGenerator.fromDefinition({
        'type': 'text',
        'value': '한글 ✓',
      });

      // C++ raw string literal preserves the bytes — the source must
      // contain the original characters (no hex escapes).
      expect(code, contains('한글'));
      expect(code, contains('✓'));
    });
  });
}
