import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  group('MCPUIWidgetBuilders (auto-generated)', () {
    test('button — required label only', () {
      final m = MCPUIWidgetBuilders.button(label: 'OK');

      expect(m['type'], equals('button'));
      expect(m['label'], equals('OK'));
      expect(m.containsKey('variant'), isFalse);
    });

    test('button — optional fields are present when supplied', () {
      final m = MCPUIWidgetBuilders.button(
        label: 'Save',
        variant: 'filled',
        onTap: {'type': 'tool', 'tool': 'persist'},
      );

      expect(m['variant'], equals('filled'));
      expect(m['onTap'], isA<Map>());
    });

    test('text — required text', () {
      final m = MCPUIWidgetBuilders.text(text: 'Hello');
      expect(m['type'], equals('text'));
      expect(m['text'], equals('Hello'));
    });

    test('linear — vertical column with children', () {
      final m = MCPUIWidgetBuilders.linear(
        direction: 'vertical',
        children: [
          MCPUIWidgetBuilders.text(text: 'a'),
          MCPUIWidgetBuilders.text(text: 'b'),
        ],
      );

      expect(m['type'], equals('linear'));
      expect(m['direction'], equals('vertical'));
      expect((m['children'] as List).length, equals(2));
    });

    test('canvas — no parameters (empty-properties widget)', () {
      final m = MCPUIWidgetBuilders.canvas();
      expect(m, equals({'type': 'canvas'}));
    });

    test('alertDialog — onClose accepted as optional', () {
      final m = MCPUIWidgetBuilders.alertDialog(
        title: 'Delete?',
        onClose: {'type': 'state', 'action': 'set'},
      );

      expect(m['type'], equals('alertDialog'));
      expect(m['onClose'], isA<Map>());
    });

    test('reserved-word property name is escaped on the param side',
        () {
      // `conditional` widget has properties `else` / `switch` / `default`
      // — Dart reserved words. The generated method must accept them
      // under sanitised names but still emit the canonical map keys.
      final m = MCPUIWidgetBuilders.conditional(
        condition: '{{count > 0}}',
        then: {'type': 'text', 'text': 'positive'},
        else_: {'type': 'text', 'text': 'zero or negative'},
      );

      expect(m['type'], equals('conditional'));
      expect(m['then'], isA<Map>());
      expect(m['else'], isA<Map>());
    });

    test('every method produces a map with `type` discriminator', () {
      // Spot-check a representative cross-section. `row` / `column`
      // are aliases of `linear` and live only on the runtime side;
      // the generator emits the canonical name. `box` exposes width
      // / height / decoration; its single-`child` slot lives on the
      // yaml `children:` block (not under `properties:`) and is not
      // synthesised as a builder param yet.
      final samples = <Map<String, dynamic>>[
        MCPUIWidgetBuilders.linear(
            direction: 'horizontal',
            children: [MCPUIWidgetBuilders.text(text: 'a')]),
        MCPUIWidgetBuilders.icon(icon: 'home'),
        MCPUIWidgetBuilders.padding(
            padding: 16,
            child: MCPUIWidgetBuilders.text(text: 'p')),
        MCPUIWidgetBuilders.center(child: MCPUIWidgetBuilders.text(text: 'c')),
        MCPUIWidgetBuilders.box(width: 200, height: 80),
      ];
      for (final m in samples) {
        expect(m['type'], isA<String>());
        expect((m['type'] as String).isNotEmpty, isTrue);
      }
    });
  });
}
