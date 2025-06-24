import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  group('Application', () {
    test('application', () {
      final app = MCPUIJsonGenerator.application(
        title: 'Test App',
        version: '1.0.0',
        routes: {
          '/': {'uri': 'ui://pages/home'},
          '/settings': {'uri': 'ui://pages/settings'},
        },
        initialRoute: '/home',
        theme: {'primaryColor': '#2196F3'},
        navigation: {'type': 'drawer'},
        state: {'initial': {'user': 'John'}},
      );

      expect(app['type'], 'application');
      expect(app['title'], 'Test App');
      expect(app['version'], '1.0.0');
      expect(app['initialRoute'], '/home');
      expect(app['routes'], isNotNull);
      expect(app['theme'], isNotNull);
      expect(app['navigation'], isNotNull);
      expect(app['state'], isNotNull);
    });

    test('page', () {
      final page = MCPUIJsonGenerator.page(
        title: 'Test Page',
        content: {'type': 'text', 'content': 'Hello'},
        route: '/test',
        state: {'initial': {'count': 0}},
        lifecycle: {
          'onInit': [{'type': 'tool', 'name': 'loadData'}],
          'onDestroy': [{'type': 'tool', 'name': 'cleanup'}],
        },
      );

      expect(page['type'], 'page');
      expect(page['lifecycle']['onInit'].length, 1);
      expect(page['lifecycle']['onDestroy'].length, 1);
    });
  });
}