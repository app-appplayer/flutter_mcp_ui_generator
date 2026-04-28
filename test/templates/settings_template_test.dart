import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-198: SettingsTemplate
  group('TC-198: SettingsTemplate', () {
    test('Normal: generates settings page', () {
      final template = SettingsTemplate();
      final result = template.generate(title: 'Settings');

      expect(result['type'], equals('page'));
      expect(result['title'], equals('Settings'));
      expect(result['content'], isA<Map>());
    });

    test('Normal: implements Template abstract class', () {
      final template = SettingsTemplate();
      expect(template, isA<Template>());
    });

    test('Boundary: custom setting options via config', () {
      final template = SettingsTemplate();
      final result = template.generate(
        title: 'Preferences',
        config: {'showTheme': true},
      );

      expect(result['title'], equals('Preferences'));
    });
  });

  // TC-199: Template abstract class contract
  group('TC-199: Template abstract class contract', () {
    test('Normal: all 6 templates implement Template', () {
      expect(CounterTemplate(), isA<Template>());
      expect(FormTemplate(), isA<Template>());
      expect(ListDetailTemplate(), isA<Template>());
      expect(DashboardTemplate(), isA<Template>());
      expect(LoginTemplate(), isA<Template>());
      expect(SettingsTemplate(), isA<Template>());
    });

    test('Boundary: config null is valid', () {
      final templates = <Template>[
        CounterTemplate(),
        FormTemplate(),
        ListDetailTemplate(),
        DashboardTemplate(),
        LoginTemplate(),
        SettingsTemplate(),
      ];

      for (final t in templates) {
        final result = t.generate(title: 'Test');
        expect(result, isA<Map<String, dynamic>>());
        expect(result['type'], equals('page'));
      }
    });
  });
}
