import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/src/json_generator.dart';

void main() {
  group('Theme System Tests', () {
    test('theme() should create complete theme structure', () {
      final theme = MCPUIJsonGenerator.theme(
        mode: 'dark',
        colors: {'primary': '#FF0000'},
        typography: {'h1': {'fontSize': 40}},
      );

      expect(theme['mode'], equals('dark'));
      expect(theme['colors']['primary'], equals('#FF0000'));
      expect(theme['typography']['h1']['fontSize'], equals(40));
    });

    test('themeColors() should create color palette', () {
      final colors = MCPUIJsonGenerator.themeColors(
        primary: '#4CAF50',
        secondary: '#FF9800',
      );

      expect(colors['primary'], equals('#4CAF50'));
      expect(colors['secondary'], equals('#FF9800'));
      expect(colors['background'], equals('#FFFFFF'));
    });

    test('themeTypography() should create typography scale', () {
      final typography = MCPUIJsonGenerator.themeTypography(
        h1: {'fontSize': 36, 'fontWeight': 'bold'},
      );

      expect(typography['h1']['fontSize'], equals(36));
      expect(typography['h1']['fontWeight'], equals('bold'));
      expect(typography['body1']['fontSize'], equals(16));
    });

    test('themeSpacing() should create spacing scale', () {
      final spacing = MCPUIJsonGenerator.themeSpacing(md: 20);

      expect(spacing['md'], equals(20));
      expect(spacing['sm'], equals(8));
      expect(spacing['lg'], equals(24));
    });

    test('themeBorderRadius() should create border radius scale', () {
      final borderRadius = MCPUIJsonGenerator.themeBorderRadius(md: 12);

      expect(borderRadius['md'], equals(12));
      expect(borderRadius['sm'], equals(4));
      expect(borderRadius['lg'], equals(16));
    });

    test('themeElevation() should create elevation scale', () {
      final elevation = MCPUIJsonGenerator.themeElevation(md: 6);

      expect(elevation['md'], equals(6));
      expect(elevation['sm'], equals(2));
      expect(elevation['lg'], equals(8));
    });

    test('theme binding helpers should generate correct expressions', () {
      expect(MCPUIJsonGenerator.themeColor('primary'), equals('{{theme.colors.primary}}'));
      expect(MCPUIJsonGenerator.themeTypographyProperty('h1', 'fontSize'), 
             equals('{{theme.typography.h1.fontSize}}'));
      expect(MCPUIJsonGenerator.themeSpacingValue('md'), equals('{{theme.spacing.md}}'));
      expect(MCPUIJsonGenerator.themeBorderRadiusValue('lg'), equals('{{theme.borderRadius.lg}}'));
      expect(MCPUIJsonGenerator.themeElevationValue('sm'), equals('{{theme.elevation.sm}}'));
    });

    test('application() should accept theme parameter', () {
      final theme = MCPUIJsonGenerator.themeColors(primary: '#123456');
      final app = MCPUIJsonGenerator.application(
        title: 'Test App',
        version: '1.0.0',
        routes: {'/home': {'uri': 'ui://pages/home'}},
        theme: theme,
      );

      expect(app['theme']['primary'], equals('#123456'));
    });

    test('text widget with theme bindings should work', () {
      final text = MCPUIJsonGenerator.text(
        'Hello',
        style: MCPUIJsonGenerator.textStyle(
          color: MCPUIJsonGenerator.themeColor('primary'),
          fontSize: 18,
        ),
      );

      expect(text['style']['color'], equals('{{theme.colors.primary}}'));
      expect(text['style']['fontSize'], equals(18));
    });
  });
}