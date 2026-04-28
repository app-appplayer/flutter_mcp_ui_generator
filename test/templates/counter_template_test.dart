import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-193: CounterTemplate
  group('TC-193: CounterTemplate', () {
    test('Normal: generates counter UI JSON', () {
      final template = CounterTemplate();
      final result = template.generate(title: 'Counter');

      expect(result['type'], equals('page'));
      expect(result['title'], equals('Counter'));
      expect(result['content'], isA<Map>());
      expect(result['state'], isA<Map>());
    });

    test('Normal: implements Template abstract class', () {
      final template = CounterTemplate();
      expect(template, isA<Template>());
    });

    test('Boundary: custom title via config parameter', () {
      final template = CounterTemplate();
      final result = template.generate(
        title: 'My Counter',
        config: {'initialValue': 10, 'step': 5},
      );

      expect(result['title'], equals('My Counter'));
      expect(result['state'], isA<Map>());
    });
  });
}
