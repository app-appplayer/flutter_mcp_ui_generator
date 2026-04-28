import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-054: MCPUIJsonGenerator.application
  group('TC-054: MCPUIJsonGenerator.application', () {
    test('Normal: produces complete application definition', () {
      final app = MCPUIJsonGenerator.application(
        title: 'Test App',
        version: '1.0.0',
        routes: {'/': 'ui://pages/home', '/settings': 'ui://pages/settings'},
        initialRoute: '/home',
        theme: {'primaryColor': '#2196F3'},
        navigation: {'type': 'drawer'},
        state: {'initial': {'user': 'John'}},
      );

      expect(app['type'], equals('application'));
      expect(app['title'], equals('Test App'));
      expect(app['version'], equals('1.0.0'));
      expect(app['initialRoute'], equals('/home'));
      expect(app['routes'], isNotNull);
      expect(app['theme'], isNotNull);
      expect(app['navigation'], isNotNull);
      expect(app['state'], isNotNull);
    });

    test('Boundary: minimal arguments', () {
      final app = MCPUIJsonGenerator.application(
        title: 'Min',
        version: '0.1.0',
        routes: {},
      );

      expect(app['type'], equals('application'));
      expect(app['title'], equals('Min'));
      expect(app['version'], equals('0.1.0'));
    });
  });

  // TC-055: MCPUIJsonGenerator.page
  group('TC-055: MCPUIJsonGenerator.page', () {
    test('Normal: produces page definition with all fields', () {
      final page = MCPUIJsonGenerator.page(
        title: 'Test Page',
        content: MCPUIJsonGenerator.text('Hello'),
        route: '/test',
        state: {'initial': {'count': 0}},
        lifecycle: {
          'onInit': [MCPUIJsonGenerator.toolAction('load')],
        },
      );

      expect(page['type'], equals('page'));
      expect(page['title'], equals('Test Page'));
      expect(page['content'], isA<Map>());
      expect(page['route'], equals('/test'));
      expect(page['state'], isNotNull);
      expect(page['lifecycle'], isNotNull);
    });

    test('Boundary: minimal arguments', () {
      final page = MCPUIJsonGenerator.page(
        title: 'Min Page',
        content: MCPUIJsonGenerator.text('Hello'),
      );

      expect(page['type'], equals('page'));
      expect(page['title'], equals('Min Page'));
    });
  });
}
