import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-001: ApplicationBuilder — constructor and required params
  group('TC-001: ApplicationBuilder — constructor and required params', () {
    test('Normal: constructor creates builder with title and version', () {
      final app = MCPUIBuilder.application(
        title: 'My App',
        version: '1.0.0',
      ).build();

      expect(app['type'], equals('application'));
      expect(app['title'], equals('My App'));
      expect(app['version'], equals('1.0.0'));
    });

    test('Boundary: title with special characters', () {
      final app = MCPUIBuilder.application(
        title: 'My App — 日本語',
        version: '2.0.0-beta',
      ).build();

      expect(app['title'], equals('My App — 日本語'));
      expect(app['version'], equals('2.0.0-beta'));
    });
  });

  // TC-002: ApplicationBuilder — initialRoute
  group('TC-002: ApplicationBuilder — initialRoute', () {
    test('Normal: sets initialRoute in output', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).initialRoute('/dashboard').build();

      expect(app['initialRoute'], equals('/dashboard'));
    });

    test('Boundary: route with parameters', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).initialRoute('/users/:id').build();

      expect(app['initialRoute'], equals('/users/:id'));
    });
  });

  // TC-003: ApplicationBuilder — addRoute
  group('TC-003: ApplicationBuilder — addRoute', () {
    test('Normal: adds route mapping', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).addRoute('/dashboard', 'ui://pages/dashboard').build();

      expect(app['routes']['/dashboard'], equals('ui://pages/dashboard'));
    });

    test('Normal: multiple addRoute calls', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      )
          .addRoute('/home', 'ui://pages/home')
          .addRoute('/settings', 'ui://pages/settings')
          .addRoute('/profile', 'ui://pages/profile')
          .build();

      expect(app['routes'].length, equals(3));
    });

    test('Boundary: single route application', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).addRoute('/', 'ui://pages/main').build();

      expect(app['routes'].length, equals(1));
    });
  });

  // TC-004: ApplicationBuilder — theme (raw map)
  group('TC-004: ApplicationBuilder — theme (raw map)', () {
    test('Normal: sets complete theme map', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).theme({'mode': 'light', 'colors': {'primary': '#2196F3'}}).build();

      expect(app['theme']['mode'], equals('light'));
      expect(app['theme']['colors']['primary'], equals('#2196F3'));
    });

    test('Boundary: empty theme map', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).theme({}).build();

      expect(app['theme'], equals({}));
    });
  });

  // TC-005: ApplicationBuilder — fullTheme
  group('TC-005: ApplicationBuilder — fullTheme', () {
    test('Normal: builds theme with all sub-sections', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).fullTheme(
        mode: 'dark',
        colors: {'primary': '#FF0000'},
        typography: {'headline': {'fontSize': 24}},
        spacing: {'small': 4},
        borderRadius: {'small': 4.0},
        elevation: {'low': 2.0},
        light: {'primary': '#000000'},
        dark: {'primary': '#FFFFFF'},
      ).build();

      expect(app['theme']['mode'], equals('dark'));
      expect(app['theme']['colors'], isNotNull);
      expect(app['theme']['typography'], isNotNull);
      expect(app['theme']['spacing'], isNotNull);
      expect(app['theme']['borderRadius'], isNotNull);
      expect(app['theme']['elevation'], isNotNull);
      expect(app['theme']['light'], isNotNull);
      expect(app['theme']['dark'], isNotNull);
    });

    test('Normal: mode only produces minimal theme', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).fullTheme(mode: 'light').build();

      expect(app['theme']['mode'], equals('light'));
    });
  });

  // TC-006: ApplicationBuilder — themeMode
  group('TC-006: ApplicationBuilder — themeMode', () {
    test('Normal: sets mode in theme section', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).themeMode('dark').build();

      expect(app['theme']['mode'], equals('dark'));
    });

    test('Boundary: light mode', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).themeMode('light').build();

      expect(app['theme']['mode'], equals('light'));
    });
  });

  // TC-007: ApplicationBuilder — themeColors
  group('TC-007: ApplicationBuilder — themeColors', () {
    test('Normal: merges colors into theme', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).themeColors({'primary': '#FF0000', 'secondary': '#00FF00'}).build();

      expect(app['theme']['colors']['primary'], equals('#FF0000'));
      expect(app['theme']['colors']['secondary'], equals('#00FF00'));
    });

    test('Boundary: empty colors map', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).themeColors({}).build();

      expect(app['theme']['colors'], equals({}));
    });
  });

  // TC-008: ApplicationBuilder — themeTypography
  group('TC-008: ApplicationBuilder — themeTypography', () {
    test('Normal: merges typography into theme', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).themeTypography({'headline': {'fontSize': 24}}).build();

      expect(app['theme']['typography']['headline']['fontSize'], equals(24));
    });

    test('Boundary: empty typography map', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).themeTypography({}).build();

      expect(app['theme']['typography'], equals({}));
    });
  });

  // TC-009: ApplicationBuilder — themeSpacing
  group('TC-009: ApplicationBuilder — themeSpacing', () {
    test('Normal: merges spacing into theme', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).themeSpacing({'small': 4, 'medium': 8, 'large': 16}).build();

      expect(app['theme']['spacing']['small'], equals(4));
      expect(app['theme']['spacing']['medium'], equals(8));
      expect(app['theme']['spacing']['large'], equals(16));
    });

    test('Boundary: empty spacing map', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).themeSpacing({}).build();

      expect(app['theme']['spacing'], equals({}));
    });
  });

  // TC-010: ApplicationBuilder — incremental theme building
  group('TC-010: ApplicationBuilder — incremental theme building', () {
    test('Normal: chained theme methods merge all sections', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      )
          .themeMode('dark')
          .themeColors({'primary': '#FF0000'})
          .themeTypography({'headline': {'fontSize': 24}})
          .themeSpacing({'small': 4})
          .build();

      expect(app['theme']['mode'], equals('dark'));
      expect(app['theme']['colors'], isNotNull);
      expect(app['theme']['typography'], isNotNull);
      expect(app['theme']['spacing'], isNotNull);
    });

    test('Boundary: only mode and colors', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).themeMode('light').themeColors({'primary': '#000'}).build();

      expect(app['theme']['mode'], equals('light'));
      expect(app['theme']['colors'], isNotNull);
      expect(app['theme'].containsKey('typography'), isFalse);
    });
  });

  // TC-011: ApplicationBuilder — navigation
  group('TC-011: ApplicationBuilder — navigation', () {
    test('Normal: sets navigation config', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).navigation({'type': 'tabs', 'items': []}).build();

      expect(app['navigation']['type'], equals('tabs'));
    });

    test('Boundary: empty navigation map', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).navigation({}).build();

      expect(app['navigation'], equals({}));
    });
  });

  // TC-012: ApplicationBuilder — initialState
  group('TC-012: ApplicationBuilder — initialState', () {
    test('Normal: sets initial state', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).initialState({'counter': 0, 'user': null}).build();

      expect(app['state']['initial']['counter'], equals(0));
      expect(app['state']['initial']['user'], isNull);
    });

    test('Boundary: empty initial state', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).initialState({}).build();

      expect(app['state']['initial'], equals({}));
    });
  });

  // TC-013: ApplicationBuilder — build output (complete)
  group('TC-013: ApplicationBuilder — build output (complete)', () {
    test('Normal: complete build with all fields', () {
      final app = MCPUIBuilder.application(
        title: 'Test App',
        version: '1.0.0',
      )
          .initialRoute('/home')
          .addRoute('/home', 'ui://pages/home')
          .addRoute('/settings', 'ui://pages/settings')
          .theme({'primaryColor': '#2196F3'})
          .navigation({'type': 'drawer'})
          .initialState({'user': 'John'})
          .build();

      expect(app['type'], equals('application'));
      expect(app['title'], equals('Test App'));
      expect(app['version'], equals('1.0.0'));
      expect(app['initialRoute'], equals('/home'));
      expect(app['routes'].length, equals(2));
      expect(app['theme'], isNotNull);
      expect(app['navigation'], isNotNull);
      expect(app['state']['initial']['user'], equals('John'));
    });

    test('Boundary: minimal build (title and version only)', () {
      final app = MCPUIBuilder.application(
        title: 'Min App',
        version: '0.1.0',
      ).build();

      expect(app['type'], equals('application'));
      expect(app['title'], equals('Min App'));
      expect(app['version'], equals('0.1.0'));
      expect(app['routes'], isNotNull);
    });
  });

  // TC-013a: ApplicationBuilder — v1.2 metadata methods
  group('TC-013a: ApplicationBuilder — v1.2 metadata', () {
    test('Normal: id sets app identifier', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).id('com.example.app').build();

      expect(app['id'], equals('com.example.app'));
    });

    test('Normal: description sets description', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).description('A test app').build();

      expect(app['description'], equals('A test app'));
    });

    test('Normal: icon sets icon', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).icon('bundle://assets/icon.png').build();

      expect(app['icon'], equals('bundle://assets/icon.png'));
    });

    test('Normal: splash sets splash config', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).splash(image: 'splash.png', backgroundColor: '#FFFFFF', duration: 3000).build();

      expect(app['splash']['image'], equals('splash.png'));
      expect(app['splash']['backgroundColor'], equals('#FFFFFF'));
      expect(app['splash']['duration'], equals(3000));
    });

    test('Normal: category sets category', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).category('productivity').build();

      expect(app['category'], equals('productivity'));
    });

    test('Normal: publisher sets publisher info', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).publisher(
        name: 'Example Corp',
        logo: 'logo.png',
        url: 'https://example.com',
        email: 'contact@example.com',
      ).build();

      expect(app['publisher']['name'], equals('Example Corp'));
      expect(app['publisher']['logo'], equals('logo.png'));
      expect(app['publisher']['url'], equals('https://example.com'));
      expect(app['publisher']['email'], equals('contact@example.com'));
    });

    test('Normal: timestamps sets timestamps', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).timestamps(
        createdAt: '2026-01-01T00:00:00Z',
        updatedAt: '2026-03-01T00:00:00Z',
      ).build();

      expect(app['timestamps']['createdAt'], equals('2026-01-01T00:00:00Z'));
      expect(app['timestamps']['updatedAt'], equals('2026-03-01T00:00:00Z'));
    });

    test('Normal: screenshots sets screenshots', () {
      final app = MCPUIBuilder.application(
        title: 'App',
        version: '1.0.0',
      ).screenshots(['s1.png', 's2.png']).build();

      expect(app['screenshots'], equals(['s1.png', 's2.png']));
    });
  });
}
