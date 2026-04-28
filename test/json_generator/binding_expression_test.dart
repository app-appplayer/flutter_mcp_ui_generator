import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-123: MCPUIJsonGenerator.binding
  group('TC-123: MCPUIJsonGenerator.binding', () {
    test('Normal: produces binding expression', () {
      expect(MCPUIJsonGenerator.binding('count'), equals('{{count}}'));
    });

    test('Boundary: nested path', () {
      expect(
        MCPUIJsonGenerator.binding('user.profile.name'),
        equals('{{user.profile.name}}'),
      );
    });
  });

  // TC-124: MCPUIJsonGenerator.localState
  group('TC-124: MCPUIJsonGenerator.localState', () {
    test('Normal: produces local state binding', () {
      expect(
        MCPUIJsonGenerator.localState('expanded'),
        equals('{{local.expanded}}'),
      );
    });

    test('Boundary: nested path', () {
      expect(
        MCPUIJsonGenerator.localState('form.name'),
        equals('{{local.form.name}}'),
      );
    });
  });

  // TC-125: MCPUIJsonGenerator.appState
  group('TC-125: MCPUIJsonGenerator.appState', () {
    test('Normal: produces app state binding', () {
      expect(
        MCPUIJsonGenerator.appState('user.name'),
        equals('{{app.user.name}}'),
      );
    });

    test('Boundary: simple path', () {
      expect(MCPUIJsonGenerator.appState('theme'), equals('{{app.theme}}'));
    });
  });

  // TC-126: MCPUIJsonGenerator.themeBinding
  group('TC-126: MCPUIJsonGenerator.themeBinding', () {
    test('Normal: produces theme binding expression', () {
      expect(
        MCPUIJsonGenerator.themeBinding('color.primary'),
        equals('{{theme.color.primary}}'),
      );
    });

    test('Boundary: simple path', () {
      expect(
        MCPUIJsonGenerator.themeBinding('mode'),
        equals('{{theme.mode}}'),
      );
    });
  });

  // TC-127: MCPUIJsonGenerator.routeState
  group('TC-127: MCPUIJsonGenerator.routeState', () {
    test('Normal: produces route state binding', () {
      expect(
        MCPUIJsonGenerator.routeState('params.id'),
        equals('{{route.params.id}}'),
      );
    });

    test('Boundary: simple path', () {
      expect(
        MCPUIJsonGenerator.routeState('path'),
        equals('{{route.path}}'),
      );
    });
  });

  // TC-128: MCPUIJsonGenerator.preference
  group('TC-128: MCPUIJsonGenerator.preference', () {
    test('Normal: produces preference binding', () {
      expect(
        MCPUIJsonGenerator.preference('darkMode'),
        equals('{{preferences.darkMode}}'),
      );
    });

    test('Boundary: nested path', () {
      expect(
        MCPUIJsonGenerator.preference('notifications.enabled'),
        equals('{{preferences.notifications.enabled}}'),
      );
    });
  });

  // TC-129: MCPUIJsonGenerator.conditional
  group('TC-129: MCPUIJsonGenerator.conditional', () {
    test('Normal: produces conditional expression', () {
      final c = MCPUIJsonGenerator.conditional('x > 0', 'yes', 'no');

      expect(c, contains('x > 0'));
      expect(c, contains('yes'));
      expect(c, contains('no'));
    });

    test('Boundary: complex condition expression', () {
      final c = MCPUIJsonGenerator.conditional(
        'a > 0 && b < 10',
        'valid',
        'invalid',
      );

      expect(c, contains('a > 0 && b < 10'));
    });
  });

  // TC-130: MCPUIJsonGenerator.computed
  group('TC-130: MCPUIJsonGenerator.computed', () {
    test('Normal: produces computed expression', () {
      expect(MCPUIJsonGenerator.computed('a + b'), equals('{{a + b}}'));
    });

    test('Boundary: complex expression', () {
      expect(
        MCPUIJsonGenerator.computed('price * quantity * (1 + tax)'),
        equals('{{price * quantity * (1 + tax)}}'),
      );
    });
  });

  // TC-131: MCPUIJsonGenerator.themeColor (M3 28-role)
  group('TC-131: MCPUIJsonGenerator.themeColor', () {
    test('Normal: produces theme color binding', () {
      expect(
        MCPUIJsonGenerator.themeColor('primary'),
        equals('{{theme.color.primary}}'),
      );
    });

    test('Boundary: surface container slot', () {
      expect(
        MCPUIJsonGenerator.themeColor('surfaceContainerHigh'),
        equals('{{theme.color.surfaceContainerHigh}}'),
      );
    });
  });

  // TC-132: MCPUIJsonGenerator.themeTypographyProperty
  group('TC-132: MCPUIJsonGenerator.themeTypographyProperty', () {
    test('Normal: produces theme typography binding', () {
      expect(
        MCPUIJsonGenerator.themeTypographyProperty('headline', 'fontSize'),
        equals('{{theme.typography.headline.fontSize}}'),
      );
    });

    test('Boundary: different style/prop combinations', () {
      expect(
        MCPUIJsonGenerator.themeTypographyProperty('body1', 'color'),
        equals('{{theme.typography.body1.color}}'),
      );
    });
  });

  // TC-133: MCPUIJsonGenerator.themeSpacingValue
  group('TC-133: MCPUIJsonGenerator.themeSpacingValue', () {
    test('Normal: produces theme spacing binding', () {
      expect(
        MCPUIJsonGenerator.themeSpacingValue('medium'),
        equals('{{theme.spacing.medium}}'),
      );
    });

    test('Boundary: various size names', () {
      expect(
        MCPUIJsonGenerator.themeSpacingValue('xs'),
        equals('{{theme.spacing.xs}}'),
      );
    });
  });

  // TC-134: MCPUIJsonGenerator.themeShapeValue (M3 7-family)
  group('TC-134: MCPUIJsonGenerator.themeShapeValue', () {
    test('Normal: produces theme shape binding', () {
      expect(
        MCPUIJsonGenerator.themeShapeValue('medium'),
        equals('{{theme.shape.medium}}'),
      );
    });

    test('Boundary: full shape family', () {
      expect(
        MCPUIJsonGenerator.themeShapeValue('full'),
        equals('{{theme.shape.full}}'),
      );
    });
  });

  // TC-135: MCPUIJsonGenerator.themeElevationValue (M3 6-level)
  group('TC-135: MCPUIJsonGenerator.themeElevationValue', () {
    test('Normal: produces theme elevation binding', () {
      expect(
        MCPUIJsonGenerator.themeElevationValue('level1'),
        equals('{{theme.elevation.level1.shadow}}'),
      );
    });

    test('Boundary: high level (level5)', () {
      expect(
        MCPUIJsonGenerator.themeElevationValue('level5'),
        equals('{{theme.elevation.level5.shadow}}'),
      );
    });
  });
}
