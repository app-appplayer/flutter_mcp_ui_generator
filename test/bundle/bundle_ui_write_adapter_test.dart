import 'package:flutter_test/flutter_test.dart';
import 'package:mcp_bundle/mcp_bundle.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  late BundleUiWriteAdapter adapter;

  setUp(() {
    adapter = BundleUiWriteAdapter();
  });

  // ==========================================================================
  // UiPort interface compliance (TC-V12-047, TC-V12-044, TC-V12-045)
  // ==========================================================================
  group('UiPort interface compliance', () {
    // TC-V12-047: BundleUiWriteAdapter is UiPort
    test('BundleUiWriteAdapter is UiPort', () {
      expect(adapter, isA<UiPort>());
    });

    // TC-V12-044: BundleUiWriteAdapter.toDefinition() throws UnsupportedError
    test('toDefinition() throws UnsupportedError', () {
      const bundle = McpBundle(
        manifest: BundleManifest(
          id: 'com.example.app',
          name: 'App',
          version: '1.0.0',
        ),
      );
      expect(
        () => adapter.toDefinition(bundle),
        throwsA(isA<UnsupportedError>()),
      );
    });

    // TC-V12-045: BundleUiWriteAdapter.toAppInfo() throws UnsupportedError
    test('toAppInfo() throws UnsupportedError', () {
      const bundle = McpBundle(
        manifest: BundleManifest(
          id: 'com.example.app',
          name: 'App',
          version: '1.0.0',
        ),
      );
      expect(
        () => adapter.toAppInfo(bundle),
        throwsA(isA<UnsupportedError>()),
      );
    });
  });

  // ==========================================================================
  // fromDefinition — metadata extraction (TC-V12-037 ~ TC-V12-043)
  // ==========================================================================
  group('fromDefinition() metadata extraction', () {
    // TC-V12-037: Extract manifestMetadata — title → name mapping
    test('maps title to name in manifestMetadata', () async {
      final result = await adapter.fromDefinition({
        'title': 'My App',
        'version': '1.0.0',
        'routes': {'/': 'ui://pages/home'},
      });

      expect(result.success, isTrue);
      expect(result.data!.manifestMetadata['name'], equals('My App'));
      expect(result.data!.manifestMetadata['version'], equals('1.0.0'));
    });

    // TC-V12-035, TC-V12-038, TC-V12-039: Full definition with all v1.2 metadata
    test('passes through all v1.2 metadata fields', () async {
      final result = await adapter.fromDefinition({
        'title': 'My App',
        'version': '1.0.0',
        'id': 'com.example.app',
        'description': 'A test app',
        'icon': 'bundle://assets/icon.png',
        'category': 'productivity',
        'publisher': {'name': 'Publisher'},
        'splash': {'image': 'splash.png'},
        'screenshots': ['s1.png', 's2.png'],
        'routes': {'/': 'ui://pages/home'},
      });

      expect(result.success, isTrue);
      final meta = result.data!.manifestMetadata;
      expect(meta['name'], equals('My App'));
      expect(meta['id'], equals('com.example.app'));
      expect(meta['description'], equals('A test app'));
      expect(meta['icon'], equals('bundle://assets/icon.png'));
      expect(meta['category'], equals('productivity'));
      expect(meta['publisher'], equals({'name': 'Publisher'}));
      expect(meta['splash'], equals({'image': 'splash.png'}));
      expect(meta['screenshots'], equals(['s1.png', 's2.png']));
    });

    // TC-V12-040: Extract manifestMetadata — timestamps unwrap from TimestampInfo
    test('unwraps timestamps into flat createdAt/updatedAt', () async {
      final result = await adapter.fromDefinition({
        'title': 'App',
        'version': '1.0.0',
        'timestamps': {
          'createdAt': '2026-01-01T00:00:00.000Z',
          'updatedAt': '2026-03-01T00:00:00.000Z',
        },
        'routes': {},
      });

      expect(result.success, isTrue);
      final meta = result.data!.manifestMetadata;
      expect(meta['createdAt'], equals('2026-01-01T00:00:00.000Z'));
      expect(meta['updatedAt'], equals('2026-03-01T00:00:00.000Z'));
      expect(meta.containsKey('timestamps'), isFalse);
    });

    // TC-V12-041: bundle:// URIs preserved in write output
    test('preserves bundle:// URIs in manifestMetadata', () async {
      final result = await adapter.fromDefinition({
        'title': 'App',
        'version': '1.0.0',
        'icon': 'bundle://assets/icon.png',
        'routes': {},
      });

      expect(result.success, isTrue);
      expect(result.data!.manifestMetadata['icon'],
          equals('bundle://assets/icon.png'));
    });

    // TC-V12-043: fromDefinition error handling — empty input
    test('handles empty definition', () async {
      final result = await adapter.fromDefinition({});
      expect(result.success, isTrue);
      expect(result.data!.manifestMetadata, isEmpty);
      expect(result.data!.uiSection.pages, isEmpty);
    });
  });

  // ==========================================================================
  // fromDefinition — UI section extraction (TC-V12-036)
  // ==========================================================================
  group('fromDefinition() UI section extraction', () {
    // TC-V12-036: Extract UiSection from generated JSON
    test('converts routes to ScreenDefinitions', () async {
      final result = await adapter.fromDefinition({
        'title': 'App',
        'version': '1.0.0',
        'routes': {
          '/': 'ui://pages/home',
          '/settings': 'ui://pages/settings',
        },
      });

      expect(result.success, isTrue);
      final screens = result.data!.uiSection.pages;
      expect(screens.length, equals(2));
      expect(screens.map((s) => s.id).toList(), containsAll(['home', 'settings']));
    });

    // TC-V12-036 (continued): Extracts screen ID from resource URI
    test('extracts screen ID from ui://pages/ resource URI', () async {
      final result = await adapter.fromDefinition({
        'routes': {'/dashboard': 'ui://pages/dashboard'},
      });

      expect(result.success, isTrue);
      final screen = result.data!.uiSection.pages.first;
      expect(screen.id, equals('dashboard'));
      expect(screen.route, equals('/dashboard'));
    });

    // TC-V12-036 (continued): Uses embedded page content
    test('uses embedded page content when available', () async {
      final result = await adapter.fromDefinition({
        'routes': {'/': 'ui://pages/home'},
        'pages': {
          'home': {
            'root': {'type': 'text', 'props': {'content': 'Welcome'}},
          },
        },
      });

      expect(result.success, isTrue);
      final screen = result.data!.uiSection.pages.first;
      expect(screen.root.type, equals('text'));
    });

    // TC-V12-036 (boundary): Default container when no page content
    test('uses container widget when no page content', () async {
      final result = await adapter.fromDefinition({
        'routes': {'/': 'ui://pages/home'},
      });

      expect(result.success, isTrue);
      final screen = result.data!.uiSection.pages.first;
      expect(screen.root.type, equals('container'));
    });

    // TC-V12-036 (continued): Theme extraction
    test('extracts theme config', () async {
      final result = await adapter.fromDefinition({
        'routes': {},
        'theme': {
          'mode': 'light',
          'colors': {'primary': '#FF0000'},
        },
      });

      expect(result.success, isTrue);
      expect(result.data!.uiSection.theme, isNotNull);
    });

    // TC-V12-042: Minimal ApplicationDefinition (no v1.2 metadata)
    test('returns UiResult with no routes produces empty screens', () async {
      final result = await adapter.fromDefinition({
        'title': 'App',
        'version': '1.0.0',
        'routes': {},
      });

      expect(result.success, isTrue);
      expect(result.data!.uiSection.pages, isEmpty);
    });

    // TC-V12-042: Minimal definition — only required fields present
    test('minimal definition produces name and version only', () async {
      final result = await adapter.fromDefinition({
        'title': 'Minimal',
        'version': '0.1.0',
        'initialRoute': '/',
        'routes': {'/': 'ui://pages/main'},
      });

      expect(result.success, isTrue);
      final meta = result.data!.manifestMetadata;
      // Only name and version should be in metadata
      expect(meta['name'], equals('Minimal'));
      expect(meta['version'], equals('0.1.0'));
      // No v1.2 optional fields
      expect(meta.containsKey('id'), isFalse);
      expect(meta.containsKey('description'), isFalse);
      expect(meta.containsKey('icon'), isFalse);
      expect(meta.containsKey('splash'), isFalse);
      expect(meta.containsKey('category'), isFalse);
      expect(meta.containsKey('publisher'), isFalse);
      expect(meta.containsKey('screenshots'), isFalse);
      expect(meta.containsKey('createdAt'), isFalse);
      expect(meta.containsKey('updatedAt'), isFalse);
      // UiSection should have one route
      expect(result.data!.uiSection.pages.length, equals(1));
      expect(result.data!.uiSection.pages.first.route, equals('/'));
    });
  });

  // ==========================================================================
  // Write path data flow (TC-V12-052)
  // ==========================================================================
  group('write path data flow', () {
    // TC-V12-052: End-to-end write path — ApplicationDefinition JSON →
    // BundleUiWriteAdapter.fromDefinition() → UiWriteOutput with uiSection
    // and manifestMetadata suitable for McpBundle assembly.
    test('full definition produces complete UiWriteOutput', () async {
      // Simulate a full ApplicationDefinition JSON as would be produced
      // by MCPUIJsonGenerator / MCPUIBuilder
      final definitionJson = <String, dynamic>{
        'title': 'Generated App',
        'version': '1.0.0',
        'id': 'com.example.generated',
        'description': 'An app generated via MCPUIBuilder',
        'icon': 'bundle://assets/icon.png',
        'category': 'productivity',
        'publisher': {
          'name': 'Test Publisher',
          'url': 'https://example.com',
        },
        'splash': {
          'image': 'bundle://assets/splash.png',
          'backgroundColor': '#FFFFFF',
          'duration': 3000,
        },
        'screenshots': [
          'bundle://assets/s1.png',
          'bundle://assets/s2.png',
        ],
        'timestamps': {
          'createdAt': '2026-01-01T00:00:00.000Z',
          'updatedAt': '2026-03-01T00:00:00.000Z',
        },
        'routes': {
          '/': 'ui://pages/home',
          '/settings': 'ui://pages/settings',
          '/profile': 'ui://pages/profile',
        },
        'pages': {
          'home': {
            'root': {
              'type': 'column',
              'children': [
                {'type': 'text', 'props': {'content': 'Welcome'}},
              ],
            },
          },
          'settings': {
            'root': {'type': 'container'},
          },
          'profile': {
            'root': {'type': 'text', 'props': {'content': 'Profile'}},
          },
        },
        'theme': {
          'colors': {'primary': '#2196F3'},
        },
        'state': {
          'initial': {'count': 0, 'username': 'guest'},
        },
        'navigation': {
          'type': 'stack',
        },
      };

      final result = await adapter.fromDefinition(definitionJson);
      expect(result.success, isTrue);

      final output = result.data!;

      // Verify manifestMetadata contains all expected fields
      final meta = output.manifestMetadata;
      expect(meta['name'], equals('Generated App'));
      expect(meta['version'], equals('1.0.0'));
      expect(meta['id'], equals('com.example.generated'));
      expect(meta['description'], equals('An app generated via MCPUIBuilder'));
      expect(meta['icon'], equals('bundle://assets/icon.png'));
      expect(meta['category'], equals('productivity'));
      expect(meta['publisher'], equals({
        'name': 'Test Publisher',
        'url': 'https://example.com',
      }));
      expect(meta['splash'], equals({
        'image': 'bundle://assets/splash.png',
        'backgroundColor': '#FFFFFF',
        'duration': 3000,
      }));
      expect(meta['screenshots'], equals([
        'bundle://assets/s1.png',
        'bundle://assets/s2.png',
      ]));
      expect(meta['createdAt'], equals('2026-01-01T00:00:00.000Z'));
      expect(meta['updatedAt'], equals('2026-03-01T00:00:00.000Z'));

      // Verify uiSection contains correct pages
      final pages = output.uiSection.pages;
      expect(pages.length, equals(3));
      final pageIds = pages.map((p) => p.id).toSet();
      expect(pageIds, containsAll(['home', 'settings', 'profile']));

      // Verify routes are preserved on page definitions
      final homePage = pages.firstWhere((p) => p.id == 'home');
      expect(homePage.route, equals('/'));
      expect(homePage.root.type, equals('column'));

      // Verify theme was extracted
      expect(output.uiSection.theme, isNotNull);

      // Verify state was extracted
      expect(output.uiSection.state, isNotEmpty);
      expect(output.uiSection.state['count']?.initialValue, equals(0));
      expect(
          output.uiSection.state['username']?.initialValue, equals('guest'));

      // Verify navigation was extracted
      expect(output.uiSection.navigation, isNotNull);

      // Verify the output is suitable for McpBundle assembly
      // (manifestMetadata can build BundleManifest, uiSection is valid)
      final assembledManifest = BundleManifest(
        id: meta['id'] as String,
        name: meta['name'] as String,
        version: meta['version'] as String,
        description: meta['description'] as String?,
      );
      expect(assembledManifest.id, equals('com.example.generated'));

      final assembledBundle = McpBundle(
        manifest: assembledManifest,
        ui: output.uiSection,
      );
      expect(assembledBundle.ui, isNotNull);
      expect(assembledBundle.ui!.pages.length, equals(3));
    });
  });
}
