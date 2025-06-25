import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'dart:io';

void main() {
  group('App Generation Integration Tests', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('app_gen_test_');
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('should generate single page app correctly', () async {
      final config = AppConfig(
        appName: 'Test Counter App',
        packageName: 'test_counter_app',
        organizationName: 'com.test',
        description: 'A test counter app',
        outputPath: tempDir.path,
        pages: {
          'main': MCPUIJsonGenerator.page(
            title: 'Counter',
            content: MCPUIJsonGenerator.text('Counter: {{count}}'),
            state: {
              'initial': {'count': 0}
            },
          ),
        },
      );

      final generator = MCPUIAppGenerator(config: config);
      await generator.generateApp();

      // Verify files exist
      final appDir = Directory('${tempDir.path}/test_counter_app');
      expect(await appDir.exists(), isTrue);

      final pubspecFile = File('${appDir.path}/pubspec.yaml');
      expect(await pubspecFile.exists(), isTrue);

      final mainFile = File('${appDir.path}/lib/main.dart');
      expect(await mainFile.exists(), isTrue);

      final uiDefFile =
          File('${appDir.path}/lib/generated/ui_definitions.dart');
      expect(await uiDefFile.exists(), isTrue);

      // Verify content structure
      final uiDefContent = await uiDefFile.readAsString();
      expect(uiDefContent, contains('pageDefinition'));
      expect(uiDefContent, contains('"type": "page"'));
    });

    test('should generate multi-page app with correct route structure',
        () async {
      final homePage = MCPUIJsonGenerator.page(
        title: 'Home',
        content: MCPUIJsonGenerator.text('Welcome Home'),
      );

      final profilePage = MCPUIJsonGenerator.page(
        title: 'Profile',
        content: MCPUIJsonGenerator.text('User Profile'),
      );

      final config = AppConfig(
        appName: 'Test Multi App',
        packageName: 'test_multi_app',
        organizationName: 'com.test',
        description: 'A test multi-page app',
        outputPath: tempDir.path,
        multiPage: true,
        pages: {
          'home': homePage,
          'profile': profilePage,
        },
        routes: {
          '/': 'ui://home',
          '/profile': 'ui://profile',
        },
        navigation: MCPUIJsonGenerator.bottomNavigation(
          items: [
            {'icon': 'home', 'label': 'Home', 'route': '/'},
            {'icon': 'person', 'label': 'Profile', 'route': '/profile'},
          ],
          currentIndex: 0,
          click: MCPUIJsonGenerator.navigationAction(
            action: 'push',
            route: '{{event.route}}',
          ),
        ),
      );

      final generator = MCPUIAppGenerator(config: config);
      await generator.generateApp();

      // Verify app generation
      final appDir = Directory('${tempDir.path}/test_multi_app');
      expect(await appDir.exists(), isTrue);

      final uiDefFile =
          File('${appDir.path}/lib/generated/ui_definitions.dart');
      expect(await uiDefFile.exists(), isTrue);

      // Verify correct route structure in generated file
      final uiDefContent = await uiDefFile.readAsString();
      expect(uiDefContent, contains('applicationDefinition'));
      expect(uiDefContent, contains('"type": "application"'));
      expect(uiDefContent, contains('"/": "ui://home"'));
      expect(uiDefContent, contains('"/profile": "ui://profile"'));
      expect(uiDefContent, contains('pagesMap'));

      // Verify navigation structure
      expect(uiDefContent, contains('"type": "bottomNavigation"'));
      expect(uiDefContent, contains('"route": "/"'));
      expect(uiDefContent, contains('"route": "/profile"'));
    });

    test('should generate valid Dart code that compiles', () async {
      final config = AppConfig(
        appName: 'Test Compile App',
        packageName: 'test_compile_app',
        organizationName: 'com.test',
        description: 'A test app for compilation',
        outputPath: tempDir.path,
        pages: {
          'main': MCPUIJsonGenerator.page(
            title: 'Test',
            content: MCPUIJsonGenerator.text('Test'),
          ),
        },
      );

      final generator = MCPUIAppGenerator(config: config);
      await generator.generateApp();

      final appDir = Directory('${tempDir.path}/test_compile_app');

      // Run flutter pub get first to resolve dependencies
      final pubGetResult = await Process.run(
        'flutter',
        ['pub', 'get'],
        workingDirectory: appDir.path,
      );

      if (pubGetResult.exitCode != 0) {
        print('Flutter pub get failed:');
        print('stdout: ${pubGetResult.stdout}');
        print('stderr: ${pubGetResult.stderr}');
      }

      // Try to run dart analyze on the generated code
      final result = await Process.run(
        'dart',
        ['analyze', '--fatal-infos'],
        workingDirectory: appDir.path,
      );

      // Print output for debugging
      if (result.exitCode > 1) {
        print('Dart analyze failed with exit code: ${result.exitCode}');
        print('stdout: ${result.stdout}');
        print('stderr: ${result.stderr}');
      }

      // Should not have fatal analysis errors
      expect(result.exitCode,
          lessThanOrEqualTo(1)); // 0 = no issues, 1 = warnings only
    });
  });
}
