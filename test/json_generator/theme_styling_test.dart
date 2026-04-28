import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-048: MCPUIJsonGenerator.theme — full
  group('TC-048: MCPUIJsonGenerator.theme', () {
    test('Normal: produces complete theme map with all 1.3 14-domain sections', () {
      final t = MCPUIJsonGenerator.theme(
        mode: 'light',
        color: {'primary': '#FF0000'},
        typography: {
          'displayLarge': {'fontSize': 57}
        },
        spacing: {'md': 16},
        shape: {'medium': 12},
        elevation: {
          'level3': {'shadow': 6}
        },
        light: {
          'color': {'primary': '#0000FF'}
        },
        dark: {
          'color': {'primary': '#FF00FF'}
        },
      );

      expect(t['mode'], equals('light'));
      expect(t['color'], isA<Map>());
      expect(t['typography'], isA<Map>());
      expect(t['spacing'], isA<Map>());
      expect(t['shape'], isA<Map>());
      expect(t['elevation'], isA<Map>());
      expect(t['light'], isA<Map>());
      expect(t['dark'], isA<Map>());
    });

    test('Boundary: mode only produces minimal theme map', () {
      final t = MCPUIJsonGenerator.theme(mode: 'dark');

      expect(t['mode'], equals('dark'));
      expect(t.containsKey('color'), isFalse);
    });
  });

  // TC-049: MCPUIJsonGenerator.themeColors — M3 28-role
  group('TC-049: MCPUIJsonGenerator.themeColors', () {
    test('Normal: emits only specified slots (no defaults)', () {
      final c = MCPUIJsonGenerator.themeColors(
        primary: '#FF0000',
        secondary: '#00FF00',
        onPrimary: '#FFFFFF',
      );

      expect(c['primary'], equals('#FF0000'));
      expect(c['secondary'], equals('#00FF00'));
      expect(c['onPrimary'], equals('#FFFFFF'));
      // Unspecified slots are NOT emitted (allowing seed-derived runtime fallback).
      expect(c.containsKey('surface'), isFalse);
    });

    test('Boundary: empty call produces empty map', () {
      final c = MCPUIJsonGenerator.themeColors();
      expect(c, isEmpty);
    });

    test('seed-only allows runtime to auto-derive 28 roles', () {
      final c = MCPUIJsonGenerator.themeColors(seed: '#3F51B5');
      expect(c['seed'], equals('#3F51B5'));
      expect(c.containsKey('primary'), isFalse);
    });
  });

  // TC-050: MCPUIJsonGenerator.themeTypography — M3 15-role
  group('TC-050: MCPUIJsonGenerator.themeTypography', () {
    test('Normal: produces all 15 M3 type roles with defaults', () {
      final t = MCPUIJsonGenerator.themeTypography(
        displayLarge: {'fontSize': 64, 'fontWeight': 'bold'},
      );

      expect(t['displayLarge'], isA<Map>());
      expect((t['displayLarge'] as Map)['fontSize'], equals(64));
      // Other roles get M3 defaults
      expect(t['headlineLarge'], isA<Map>());
      expect(t['bodyLarge'], isA<Map>());
      expect(t['labelSmall'], isA<Map>());
    });

    test('Boundary: default arguments populate all 15 roles', () {
      final t = MCPUIJsonGenerator.themeTypography();
      const roles = [
        'displayLarge', 'displayMedium', 'displaySmall',
        'headlineLarge', 'headlineMedium', 'headlineSmall',
        'titleLarge', 'titleMedium', 'titleSmall',
        'bodyLarge', 'bodyMedium', 'bodySmall',
        'labelLarge', 'labelMedium', 'labelSmall',
      ];
      for (final role in roles) {
        expect(t[role], isA<Map>(), reason: role);
      }
    });
  });

  // TC-051: MCPUIJsonGenerator.themeSpacing — 9 primitives + 4 layout aliases
  group('TC-051: MCPUIJsonGenerator.themeSpacing', () {
    test('Normal: produces canonical 9-primitive 8pt grid', () {
      final s = MCPUIJsonGenerator.themeSpacing(xxs: 2, xs: 4, md: 8);

      expect(s['xxs'], equals(2));
      expect(s['xs'], equals(4));
      expect(s['md'], equals(8));
    });

    test('Boundary: default arguments produce all 9 primitives', () {
      final s = MCPUIJsonGenerator.themeSpacing();
      expect(s['xxs'], equals(2));
      expect(s['xs'], equals(4));
      expect(s['sm'], equals(8));
      expect(s['md'], equals(16));
      expect(s['lg'], equals(24));
      expect(s['xl'], equals(32));
      expect(s['2xl'], equals(48));
      expect(s['3xl'], equals(64));
      expect(s['4xl'], equals(96));
    });

    test('Boundary: layout aliases are emitted only when supplied', () {
      final s = MCPUIJsonGenerator.themeSpacing(screenPadding: 16);
      expect(s['screenPadding'], equals(16));
      expect(s.containsKey('cardPadding'), isFalse);
    });
  });

  // TC-052: MCPUIJsonGenerator.themeShape — M3 7-family
  group('TC-052: MCPUIJsonGenerator.themeShape', () {
    test('Normal: produces M3 7-family corner radii', () {
      final s = MCPUIJsonGenerator.themeShape(small: 4, medium: 8);
      expect(s['small'], equals(4));
      expect(s['medium'], equals(8));
    });

    test('Boundary: default arguments produce M3 standard radii', () {
      final s = MCPUIJsonGenerator.themeShape();
      expect(s['none'], equals(0));
      expect(s['extraSmall'], equals(4));
      expect(s['small'], equals(8));
      expect(s['medium'], equals(12));
      expect(s['large'], equals(16));
      expect(s['extraLarge'], equals(28));
      expect(s['full'], equals(9999));
    });
  });

  // TC-053: MCPUIJsonGenerator.themeElevation — M3 6-level
  group('TC-053: MCPUIJsonGenerator.themeElevation', () {
    test('Normal: produces explicit shadow values', () {
      final e = MCPUIJsonGenerator.themeElevation(level1Shadow: 2, level3Shadow: 8);
      expect((e['level1'] as Map)['shadow'], equals(2));
      expect((e['level3'] as Map)['shadow'], equals(8));
    });

    test('Boundary: default arguments produce M3 6-level scale', () {
      final e = MCPUIJsonGenerator.themeElevation();
      expect((e['level0'] as Map)['shadow'], equals(0));
      expect((e['level1'] as Map)['shadow'], equals(1));
      expect((e['level2'] as Map)['shadow'], equals(3));
      expect((e['level3'] as Map)['shadow'], equals(6));
      expect((e['level4'] as Map)['shadow'], equals(8));
      expect((e['level5'] as Map)['shadow'], equals(12));
    });
  });

  // TC-114: MCPUIJsonGenerator.textStyle
  group('TC-114: MCPUIJsonGenerator.textStyle', () {
    test('Normal: produces text style map', () {
      final s = MCPUIJsonGenerator.textStyle(
        fontSize: 16,
        fontWeight: 'bold',
        color: '#000',
      );

      expect(s['fontSize'], equals(16));
      expect(s['fontWeight'], equals('bold'));
      expect(s['color'], equals('#000'));
    });

    test('Boundary: single property only', () {
      final s = MCPUIJsonGenerator.textStyle(fontSize: 14);

      expect(s['fontSize'], equals(14));
      expect(s.containsKey('fontWeight'), isFalse);
    });
  });

  // TC-115: MCPUIJsonGenerator.edgeInsets
  group('TC-115: MCPUIJsonGenerator.edgeInsets', () {
    test('Normal: uniform edge insets', () {
      final e = MCPUIJsonGenerator.edgeInsets(all: 8);

      expect(e['all'], equals(8));
    });

    test('Normal: per-side edge insets', () {
      final e = MCPUIJsonGenerator.edgeInsets(
        top: 4,
        bottom: 8,
        left: 12,
        right: 16,
      );

      expect(e['top'], equals(4));
      expect(e['bottom'], equals(8));
      expect(e['left'], equals(12));
      expect(e['right'], equals(16));
    });

    test('Boundary: horizontal/vertical only', () {
      final e = MCPUIJsonGenerator.edgeInsets(horizontal: 16, vertical: 8);

      expect(e['horizontal'], equals(16));
      expect(e['vertical'], equals(8));
    });
  });

  // TC-116: MCPUIJsonGenerator.decoration
  group('TC-116: MCPUIJsonGenerator.decoration', () {
    test('Normal: produces decoration map', () {
      final d = MCPUIJsonGenerator.decoration(
        color: '#FFF',
        borderRadius: 8,
        border: MCPUIJsonGenerator.border(color: '#000'),
      );

      expect(d['color'], equals('#FFF'));
      expect(d['borderRadius'], equals(8));
      expect(d['border'], isA<Map>());
    });

    test('Boundary: color only', () {
      final d = MCPUIJsonGenerator.decoration(color: '#FFF');

      expect(d['color'], equals('#FFF'));
      expect(d.containsKey('border'), isFalse);
    });
  });

  // TC-117: MCPUIJsonGenerator.border
  group('TC-117: MCPUIJsonGenerator.border', () {
    test('Normal: produces border definition map', () {
      final b = MCPUIJsonGenerator.border(
        color: '#000',
        width: 2,
        style: 'dashed',
      );

      expect(b['color'], equals('#000'));
      expect(b['width'], equals(2));
      expect(b['style'], equals('dashed'));
    });

    test('Boundary: minimal params', () {
      final b = MCPUIJsonGenerator.border();

      expect(b['width'], equals(1));
      expect(b['style'], equals('solid'));
    });
  });
}
