import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-195: ListDetailTemplate
  group('TC-195: ListDetailTemplate', () {
    test('Normal: generates master-detail layout', () {
      final template = ListDetailTemplate();
      final result = template.generate(title: 'Items');

      expect(result['type'], equals('page'));
      expect(result['title'], equals('Items'));
      expect(result['content'], isA<Map>());
    });

    test('Normal: implements Template abstract class', () {
      final template = ListDetailTemplate();
      expect(template, isA<Template>());
    });

    test('Boundary: custom list item and detail views via config', () {
      final template = ListDetailTemplate();
      final result = template.generate(
        title: 'Products',
        config: {'itemBinding': 'products'},
      );

      expect(result['title'], equals('Products'));
    });
  });
}
