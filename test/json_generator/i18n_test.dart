import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-151: MCPUIJsonGenerator.i18n
  group('TC-151: MCPUIJsonGenerator.i18n', () {
    test('Normal: returns i18n key reference with args', () {
      final ref = MCPUIJsonGenerator.i18n('greeting', args: {'name': 'User'});

      expect(ref, contains('i18n:greeting'));
      expect(ref, contains('name=User'));
    });

    test('Boundary: key without args', () {
      final ref = MCPUIJsonGenerator.i18n('title');

      expect(ref, equals('i18n:title'));
    });
  });

  // TC-152: MCPUIJsonGenerator.i18nConfig
  group('TC-152: MCPUIJsonGenerator.i18nConfig', () {
    test('Normal: produces i18n configuration map', () {
      final c = MCPUIJsonGenerator.i18nConfig(
        locales: ['en', 'ko', 'ja'],
        defaultLocale: 'en',
        translations: {
          'en': {'hello': 'Hello'},
          'ko': {'hello': 'Annyeong'},
        },
      );

      expect(c['locales'], isA<List>());
      expect((c['locales'] as List).length, equals(3));
      expect(c['defaultLocale'], equals('en'));
      expect(c['translations'], isA<Map>());
    });

    test('Boundary: minimal config', () {
      final c = MCPUIJsonGenerator.i18nConfig(
        locales: ['en'],
        defaultLocale: 'en',
        translations: {'en': {'ok': 'OK'}},
      );

      expect((c['locales'] as List).length, equals(1));
    });
  });

  // TC-153: MCPUIJsonGenerator.i18nTranslations
  group('TC-153: MCPUIJsonGenerator.i18nTranslations', () {
    test('Normal: produces translation map', () {
      final t = MCPUIJsonGenerator.i18nTranslations({
        'en': {'hello': 'Hello', 'bye': 'Bye'},
        'ko': {'hello': 'Annyeong', 'bye': 'Annyeong'},
      });

      expect(t['en'], isA<Map>());
      expect(t['ko'], isA<Map>());
    });

    test('Boundary: single locale', () {
      final t = MCPUIJsonGenerator.i18nTranslations({
        'en': {'hello': 'Hello'},
      });

      expect(t.length, equals(1));
    });
  });

  // TC-154: MCPUIJsonGenerator.i18nText
  group('TC-154: MCPUIJsonGenerator.i18nText', () {
    test('Normal: produces text widget with i18n key', () {
      final w = MCPUIJsonGenerator.i18nText('greeting', args: {'name': 'User'});

      expect(w['type'], equals('text'));
      expect((w['content'] as String), contains('i18n:greeting'));
    });

    test('Boundary: key only', () {
      final w = MCPUIJsonGenerator.i18nText('title');

      expect(w['type'], equals('text'));
      expect(w['content'], equals('i18n:title'));
    });
  });

  // TC-155: MCPUIJsonGenerator.i18nButton
  group('TC-155: MCPUIJsonGenerator.i18nButton', () {
    test('Normal: produces button with i18n label', () {
      final w = MCPUIJsonGenerator.i18nButton(
        labelKey: 'submit',
        click: MCPUIJsonGenerator.toolAction('submit'),
      );

      expect(w['type'], equals('button'));
      expect((w['label'] as String), contains('i18n:submit'));
    });

    test('Boundary: key only with minimal params', () {
      final w = MCPUIJsonGenerator.i18nButton(
        labelKey: 'ok',
        click: MCPUIJsonGenerator.toolAction('ok'),
      );

      expect(w['type'], equals('button'));
      expect(w['label'], equals('i18n:ok'));
    });
  });
}
