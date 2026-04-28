import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/src/app_generator.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-214: MCPUIAppGenerator — project scaffolding
  group('TC-214: MCPUIAppGenerator — project scaffolding', () {
    test('Normal: creates MCPUIAppGenerator with AppConfig', () {
      final config = AppConfig(
        appName: 'Test App',
        packageName: 'test_app',
        organizationName: 'com.example',
        description: 'A test app',
        outputPath: '/tmp/test_output',
        pages: {
          'home': MCPUIJsonGenerator.page(
            title: 'Home',
            content: MCPUIJsonGenerator.text('Hello'),
          ),
        },
      );

      final generator = MCPUIAppGenerator(config: config);
      expect(generator, isA<MCPUIAppGenerator>());
      expect(generator.config, equals(config));
    });

    test('Boundary: multi-page app configuration', () {
      final config = AppConfig(
        appName: 'Multi Page',
        packageName: 'multi_page',
        organizationName: 'com.example',
        description: 'Multi page app',
        outputPath: '/tmp/test_output',
        multiPage: true,
        pages: {
          'home': MCPUIJsonGenerator.page(
            title: 'Home',
            content: MCPUIJsonGenerator.text('Home'),
          ),
          'settings': MCPUIJsonGenerator.page(
            title: 'Settings',
            content: MCPUIJsonGenerator.text('Settings'),
          ),
        },
        routes: {'/': 'home', '/settings': 'settings'},
      );

      expect(config.multiPage, isTrue);
      expect(config.pages.length, equals(2));
      expect(config.routes.length, equals(2));
    });

    test('Boundary: with MCP server integration enabled', () {
      final config = AppConfig(
        appName: 'MCP App',
        packageName: 'mcp_app',
        organizationName: 'com.example',
        description: 'MCP integrated app',
        outputPath: '/tmp/test_output',
        mcpServerUrl: 'http://localhost:8080',
        pages: {
          'main': MCPUIJsonGenerator.page(
            title: 'Main',
            content: MCPUIJsonGenerator.text('Main'),
          ),
        },
      );

      expect(config.mcpServerUrl, equals('http://localhost:8080'));
    });

    test('Boundary: custom local package paths, fonts, tools', () {
      final config = AppConfig(
        appName: 'Custom',
        packageName: 'custom_app',
        organizationName: 'com.example',
        description: 'Custom app',
        outputPath: '/tmp/test_output',
        useLocalPackages: true,
        runtimePath: '../flutter_mcp_ui_runtime',
        fonts: [
          FontConfig(
            family: 'Roboto',
            fonts: [
              FontAsset(asset: 'assets/fonts/Roboto-Regular.ttf', weight: 400),
              FontAsset(asset: 'assets/fonts/Roboto-Bold.ttf', weight: 700),
            ],
          ),
        ],
        tools: [
          ToolConfig(name: 'fetchData', handler: 'handleFetchData'),
        ],
        pages: {
          'main': MCPUIJsonGenerator.page(
            title: 'Main',
            content: MCPUIJsonGenerator.text('Main'),
          ),
        },
      );

      expect(config.useLocalPackages, isTrue);
      expect(config.runtimePath, equals('../flutter_mcp_ui_runtime'));
      expect(config.fonts.length, equals(1));
      expect(config.fonts.first.family, equals('Roboto'));
      expect(config.tools.length, equals(1));
    });
  });

  // TC-215: MCPUIAppGenerator — AppConfig
  group('TC-215: MCPUIAppGenerator — AppConfig', () {
    test('Normal: AppConfig with all options specified', () {
      final config = AppConfig(
        appName: 'Full App',
        packageName: 'full_app',
        organizationName: 'com.example.full',
        description: 'A fully configured app',
        appVersion: '2.0.0',
        outputPath: '/tmp/full',
        multiPage: true,
        pages: {
          'home': MCPUIJsonGenerator.page(
            title: 'Home',
            content: MCPUIJsonGenerator.text('Home'),
          ),
        },
        routes: {'/': 'home'},
        initialRoute: '/home',
        theme: MCPUIJsonGenerator.theme(mode: 'dark'),
        initialState: {'counter': 0},
        primaryColor: 'Colors.red',
        useMaterial3: true,
        fonts: [],
        mcpServerUrl: 'http://localhost:3000',
        tools: [],
        useLocalPackages: false,
        runtimeVersion: '^1.0.0',
        enableAnalytics: true,
        enableCrashReporting: true,
        enableDebugMode: false,
        additionalDependencies: ['http: ^1.0.0'],
        additionalReadmeContent: 'Custom readme section',
      );

      expect(config.appName, equals('Full App'));
      expect(config.appVersion, equals('2.0.0'));
      expect(config.multiPage, isTrue);
      expect(config.enableAnalytics, isTrue);
      expect(config.enableCrashReporting, isTrue);
      expect(config.enableDebugMode, isFalse);
      expect(config.additionalDependencies.length, equals(1));
    });

    test('Boundary: minimal AppConfig (defaults)', () {
      final config = AppConfig(
        appName: 'Minimal',
        packageName: 'minimal',
        organizationName: 'com.example',
        description: 'Minimal app',
        outputPath: '/tmp/minimal',
        pages: {
          'main': {'type': 'page', 'title': 'Main', 'content': {'type': 'text', 'content': 'Hi'}},
        },
      );

      expect(config.appVersion, equals('1.0.0'));
      expect(config.multiPage, isFalse);
      expect(config.initialRoute, equals('/'));
      expect(config.useMaterial3, isTrue);
      expect(config.enableDebugMode, isTrue);
      expect(config.enableAnalytics, isFalse);
    });
  });
}
