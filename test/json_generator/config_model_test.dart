import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'package:flutter_mcp_ui_core/flutter_mcp_ui_core.dart' as core;

void main() {
  // TC-156: MCPUIJsonGenerator.applicationConfig
  group('TC-156: MCPUIJsonGenerator.applicationConfig', () {
    test('Normal: produces ApplicationConfig with all options', () {
      final c = MCPUIJsonGenerator.applicationConfig(
        title: 'Test App',
        version: '1.0.0',
        routes: {'/': 'ui://pages/home'},
        initialRoute: '/',
        theme: {'mode': 'light'},
        navigation: {'type': 'bottomNav'},
        state: {'counter': 0},
      );

      expect(c, isA<core.ApplicationConfig>());
      expect(c.title, equals('Test App'));
      expect(c.version, equals('1.0.0'));
    });

    test('Boundary: minimal config parameters', () {
      final c = MCPUIJsonGenerator.applicationConfig(
        title: 'App',
        version: '0.1',
        routes: {'/': 'ui://pages/main'},
      );

      expect(c, isA<core.ApplicationConfig>());
      expect(c.title, equals('App'));
    });
  });

  // TC-157: MCPUIJsonGenerator.pageConfig
  group('TC-157: MCPUIJsonGenerator.pageConfig', () {
    test('Normal: produces PageConfig', () {
      final c = MCPUIJsonGenerator.pageConfig(
        title: 'Home',
        content: MCPUIJsonGenerator.text('Hello'),
        route: '/home',
        state: {'count': 0},
        lifecycle: MCPUIJsonGenerator.lifecycle(
          onInit: [MCPUIJsonGenerator.toolAction('load')],
        ),
      );

      expect(c, isA<core.PageConfig>());
      expect(c.title, equals('Home'));
    });

    test('Boundary: minimal config parameters', () {
      final c = MCPUIJsonGenerator.pageConfig(
        title: 'Page',
        content: MCPUIJsonGenerator.text('Content'),
      );

      expect(c, isA<core.PageConfig>());
    });
  });

  // TC-158: MCPUIJsonGenerator.themeDefinition (1.3)
  group('TC-158: MCPUIJsonGenerator.themeDefinition', () {
    test('Normal: produces ThemeDefinition with M3 14-domain shape', () {
      final c = MCPUIJsonGenerator.themeDefinition(
        mode: 'dark',
        color: MCPUIJsonGenerator.themeColors(primary: '#FF0000'),
        typography: MCPUIJsonGenerator.themeTypography(),
        spacing: MCPUIJsonGenerator.themeSpacing(),
        shape: MCPUIJsonGenerator.themeShape(),
        elevation: MCPUIJsonGenerator.themeElevation(),
      );

      expect(c, isA<core.ThemeDefinition>());
      expect(c.mode, equals('dark'));
      expect(c.color?.primary, equals('#FF0000'));
      expect(c.typography?.bodyLarge?.fontSize, equals(16));
      expect(c.spacing?.md, equals(16));
      expect(c.shape?.medium?.uniform, equals(12));
      expect(c.elevation?.level3?.shadow, equals(6));
    });

    test('Boundary: minimal — system mode + no overrides', () {
      final c = MCPUIJsonGenerator.themeDefinition();

      expect(c, isA<core.ThemeDefinition>());
      expect(c.mode, equals('system'));
    });

    test('seed-only color block produces ColorSchemeDefinition with seed', () {
      final c = MCPUIJsonGenerator.themeDefinition(
        color: MCPUIJsonGenerator.themeColors(seed: '#3F51B5'),
      );
      expect(c.color?.seed, equals('#3F51B5'));
    });
  });
}
