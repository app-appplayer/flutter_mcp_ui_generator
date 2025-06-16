import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('MCPUIJsonGenerator', () {
    group('Application & Page Builders', () {
      test('should create application with all properties', () {
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

      test('should create application with minimal properties', () {
        final app = MCPUIJsonGenerator.application(
          title: 'Minimal App',
          version: '1.0.0',
          routes: {},
        );

        expect(app['type'], 'application');
        expect(app['title'], 'Minimal App');
        expect(app['version'], '1.0.0');
        expect(app['initialRoute'], '/');
        expect(app['routes'], {});
        expect(app.containsKey('theme'), false);
        expect(app.containsKey('navigation'), false);
        expect(app.containsKey('state'), false);
      });

      test('should create page with all properties', () {
        final page = MCPUIJsonGenerator.page(
          title: 'Test Page',
          content: {'type': 'text', 'value': 'Hello'},
          route: '/test',
          state: {'initial': {'count': 0}},
          lifecycle: {
            'onInit': [{'type': 'tool', 'tool': 'loadData'}],
            'onDestroy': [{'type': 'tool', 'tool': 'cleanup'}],
          },
        );

        expect(page['type'], 'page');
        expect(page['title'], 'Test Page');
        expect(page['content'], isNotNull);
        expect(page['route'], '/test');
        expect(page['state'], isNotNull);
        expect(page['lifecycle'], isNotNull);
      });

      test('should create page with minimal properties', () {
        final page = MCPUIJsonGenerator.page(
          title: 'Minimal Page',
          content: {'type': 'text', 'value': 'Hello'},
        );

        expect(page['type'], 'page');
        expect(page['title'], 'Minimal Page');
        expect(page['content'], isNotNull);
        expect(page.containsKey('route'), false);
        expect(page.containsKey('state'), false);
        expect(page.containsKey('lifecycle'), false);
      });
    });
  });
}
