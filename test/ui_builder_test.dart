import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'package:test/test.dart';

void main() {
  group('MCPUIBuilder', () {
    test('should create base MCPUIBuilder instance', () {
      final builder = MCPUIBuilder();
      final result = builder.build();
      
      expect(result, {});
    });

    group('ApplicationBuilder', () {
      test('should create application with basic properties', () {
        final app = MCPUIBuilder.application(
          title: 'Test App',
          version: '1.0.0',
        ).build();

        expect(app['type'], 'application');
        expect(app['title'], 'Test App');
        expect(app['version'], '1.0.0');
        expect(app['routes'], {});
      });

      test('should create application with routes', () {
        final app = MCPUIBuilder.application(
          title: 'Test App',
          version: '1.0.0',
        )
        .addRoute('/home', 'ui://pages/home')
        .addRoute('/settings', 'ui://pages/settings')
        .build();

        expect(app['routes']['/home'], 'ui://pages/home');
        expect(app['routes']['/settings'], 'ui://pages/settings');
      });
    });
  });
}