import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-196: DashboardTemplate
  group('TC-196: DashboardTemplate', () {
    test('Normal: generates dashboard with metrics', () {
      final template = DashboardTemplate();
      final result = template.generate(title: 'Dashboard');

      expect(result['type'], equals('page'));
      expect(result['title'], equals('Dashboard'));
      expect(result['content'], isA<Map>());
    });

    test('Normal: implements Template abstract class', () {
      final template = DashboardTemplate();
      expect(template, isA<Template>());
    });

    test('Boundary: custom card count via config', () {
      final template = DashboardTemplate();
      final result = template.generate(
        title: 'Metrics',
        config: {'cardCount': 6},
      );

      expect(result['title'], equals('Metrics'));
    });
  });
}
