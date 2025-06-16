import 'dart:convert';
import 'dart:io';
import 'json_generator.dart';

/// App Generator for creating complete Flutter app structures
class MCPUIAppGenerator {
  /// App configuration
  final AppConfig config;
  
  MCPUIAppGenerator({required this.config});
  
  /// Generate complete app structure
  Future<void> generateApp() async {
    print('🚀 Generating Flutter MCP UI App: ${config.appName}');
    
    // Create directory structure
    await _createDirectoryStructure();
    
    // Generate files
    await _generatePubspecYaml();
    await _generateMainDart();
    await _generateAppConfig();
    await _generatePages();
    await _generateAssets();
    await _generatePlatformFiles();
    
    print('✅ App generation complete!');
    print('📁 Location: ${config.outputPath}/${config.packageName}');
  }
  
  /// Create directory structure
  Future<void> _createDirectoryStructure() async {
    final dirs = [
      'lib',
      'lib/pages',
      'lib/config',
      'lib/generated',
      'assets',
      'assets/images',
      'assets/fonts',
      'test',
      'android/app/src/main/kotlin/${config.organizationName.replaceAll('.', '/')}/${config.packageName}',
      'ios/Runner',
    ];
    
    for (final dir in dirs) {
      await Directory('${config.outputPath}/${config.packageName}/$dir').create(recursive: true);
    }
  }
  
  /// Generate pubspec.yaml
  Future<void> _generatePubspecYaml() async {
    final pubspec = '''
name: ${config.packageName}
description: ${config.description}
version: 1.0.0+1
publish_to: 'none'

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # MCP UI Runtime
  flutter_mcp_ui_runtime:
    ${config.useLocalPackages ? 'path: ${config.runtimePath}' : 'git:\n      url: https://github.com/yourusername/flutter_mcp_ui_runtime.git'}
  
  # Additional dependencies
  provider: ^6.0.0
  shared_preferences: ^2.0.0
  http: ^1.0.0
  ${config.additionalDependencies.join('\n  ')}

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/ui/
  
  ${config.fonts.isNotEmpty ? _generateFontsSection() : ''}
''';
    
    await File('${config.outputPath}/${config.packageName}/pubspec.yaml').writeAsString(pubspec);
  }
  
  /// Generate main.dart
  Future<void> _generateMainDart() async {
    final mainDart = '''
import 'package:flutter/material.dart';
import 'package:flutter_mcp_ui_runtime/flutter_mcp_ui_runtime.dart';
${config.multiPage ? "import 'dart:convert';" : ''}
import 'config/app_config.dart';
import 'generated/ui_definitions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${config.appName}',
      theme: ThemeData(
        primarySwatch: ${config.primaryColor},
        useMaterial3: ${config.useMaterial3},
      ),
      home: const MCPUIApp(),
    );
  }
}

class MCPUIApp extends StatefulWidget {
  const MCPUIApp({super.key});

  @override
  State<MCPUIApp> createState() => _MCPUIAppState();
}

class _MCPUIAppState extends State<MCPUIApp> {
  late MCPUIRuntime runtime;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _initializeRuntime();
  }

  Future<void> _initializeRuntime() async {
    try {
      runtime = MCPUIRuntime();
      
      // Load UI definition
      final uiDefinition = ${config.multiPage ? 'applicationDefinition' : 'pageDefinition'};
      
      await runtime.initialize(
        uiDefinition,
        pageLoader: ${config.multiPage ? '_loadPage' : 'null'},
      );
      
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }
  
  ${config.multiPage ? '''
  Future<String> _loadPage(String pageUri) async {
    // Load page from assets or network
    if (pageUri.startsWith('ui://')) {
      final pageName = pageUri.substring(5);
      final pageJson = pagesMap[pageName];
      if (pageJson != null) {
        return jsonEncode(pageJson);
      }
    }
    throw Exception('Page not found: \$pageUri');
  }
  ''' : ''}

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    if (error != null) {
      return Scaffold(
        body: Center(
          child: Text('Error: \$error'),
        ),
      );
    }
    
    return runtime.buildUI(
      initialState: AppConfig.initialState,
      onToolCall: _handleToolCall,
    );
  }
  
  void _handleToolCall(String tool, Map<String, dynamic> args) {
    // Handle tool calls
    print('Tool called: \$tool with args: \$args');
    
    switch (tool) {
      ${config.tools.map((tool) => '''
      case '${tool.name}':
        ${tool.handler}
        break;
      ''').join('\n      ')}
      default:
        print('Unknown tool: \$tool');
    }
  }
}
''';
    
    await File('${config.outputPath}/${config.packageName}/lib/main.dart').writeAsString(mainDart);
  }
  
  /// Generate app config
  Future<void> _generateAppConfig() async {
    final appConfig = '''
/// App Configuration
class AppConfig {
  static const String appName = '${config.appName}';
  static const String appVersion = '${config.appVersion}';
  static const String organizationName = '${config.organizationName}';
  static const String packageName = '${config.packageName}';
  
  ${config.mcpServerUrl != null ? '''
  /// MCP Server Configuration
  static const String mcpServerUrl = '${config.mcpServerUrl}';
  static const bool enableMCPIntegration = true;
  ''' : '''
  /// MCP Server Configuration
  static const String? mcpServerUrl = null;
  static const bool enableMCPIntegration = false;
  '''}
  
  /// Initial State
  static final Map<String, dynamic> initialState = ${const JsonEncoder.withIndent('    ').convert(config.initialState)};
  
  /// Feature Flags
  static const bool enableAnalytics = ${config.enableAnalytics};
  static const bool enableCrashReporting = ${config.enableCrashReporting};
  static const bool enableDebugMode = ${config.enableDebugMode};
}
''';
    
    await File('${config.outputPath}/${config.packageName}/lib/config/app_config.dart').writeAsString(appConfig);
  }
  
  /// Generate pages
  Future<void> _generatePages() async {
    if (config.multiPage) {
      // Generate application definition
      final appDef = MCPUIJsonGenerator.application(
        title: config.appName,
        version: config.appVersion,
        routes: config.routes,
        initialRoute: config.initialRoute,
        navigation: config.navigation,
        theme: config.theme,
        state: {'initial': config.initialState},
      );
      
      // Escape dollar signs in the JSON string
      final appDefJson = const JsonEncoder.withIndent('  ').convert(appDef);
      final escapedAppDef = appDefJson.replaceAll(r'$', r'\$');
      
      final pagesJson = config.pages.entries.map((entry) {
        final pageJson = const JsonEncoder.withIndent('    ').convert(entry.value);
        final escapedPage = pageJson.replaceAll(r'$', r'\$');
        return "  '${entry.key}': $escapedPage,";
      }).join('\n');
      
      final appDefCode = '''
/// Application Definition
final Map<String, dynamic> applicationDefinition = $escapedAppDef;

/// Pages Map
final Map<String, Map<String, dynamic>> pagesMap = {
$pagesJson
};
''';
      
      await File('${config.outputPath}/${config.packageName}/lib/generated/ui_definitions.dart').writeAsString(appDefCode);
    } else {
      // Single page app
      final pageDef = config.pages.values.first;
      final pageDefJson = const JsonEncoder.withIndent('  ').convert(pageDef);
      final escapedPageDef = pageDefJson.replaceAll(r'$', r'\$');
      
      final pageDefCode = '''
/// Page Definition
final Map<String, dynamic> pageDefinition = $escapedPageDef;
''';
      
      await File('${config.outputPath}/${config.packageName}/lib/generated/ui_definitions.dart').writeAsString(pageDefCode);
    }
  }
  
  /// Generate assets
  Future<void> _generateAssets() async {
    // Create UI JSON files in assets
    for (final entry in config.pages.entries) {
      final jsonFile = File('${config.outputPath}/${config.packageName}/assets/ui/${entry.key}.json');
      await jsonFile.create(recursive: true);
      await jsonFile.writeAsString(jsonEncode(entry.value));
    }
    
    // Create placeholder README in images
    await File('${config.outputPath}/${config.packageName}/assets/images/README.md').writeAsString(
      '# Images\n\nPlace your image assets here.'
    );
  }
  
  /// Generate platform-specific files
  Future<void> _generatePlatformFiles() async {
    // Android MainActivity
    await _generateAndroidMainActivity();
    
    // iOS Info.plist updates
    await _generateIOSConfig();
    
    // README
    await _generateReadme();
  }
  
  /// Generate Android MainActivity
  Future<void> _generateAndroidMainActivity() async {
    final mainActivity = '''
package ${config.organizationName}.${config.packageName}

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}
''';
    
    await File('${config.outputPath}/${config.packageName}/android/app/src/main/kotlin/${config.organizationName.replaceAll('.', '/')}/${config.packageName}/MainActivity.kt')
        .writeAsString(mainActivity);
  }
  
  /// Generate iOS configuration
  Future<void> _generateIOSConfig() async {
    // This would normally update Info.plist
    // For now, just create a placeholder
    final iosReadme = '''
# iOS Configuration

Remember to update Info.plist with:
- CFBundleDisplayName: ${config.appName}
- CFBundleIdentifier: ${config.organizationName}.${config.packageName}
''';
    
    await File('${config.outputPath}/${config.packageName}/ios/README.md').writeAsString(iosReadme);
  }
  
  /// Generate README
  Future<void> _generateReadme() async {
    final readme = '''
# ${config.appName}

${config.description}

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Architecture

This app is built using:
- Flutter MCP UI Runtime for dynamic UI rendering
- MCP UI DSL for UI definitions
${config.mcpServerUrl != null ? '- MCP Server integration for AI capabilities' : ''}

## Project Structure

```
lib/
├── main.dart           # App entry point
├── config/            # Configuration files
├── generated/         # Generated UI definitions
└── pages/            # Page-specific code

assets/
├── images/           # Image assets
└── ui/              # UI JSON definitions
```

## Configuration

See `lib/config/app_config.dart` for app configuration options.

${config.additionalReadmeContent ?? ''}
''';
    
    await File('${config.outputPath}/${config.packageName}/README.md').writeAsString(readme);
  }
  
  /// Generate fonts section for pubspec
  String _generateFontsSection() {
    return '''
  fonts:
${config.fonts.map((font) => '''
    - family: ${font.family}
      fonts:
${font.fonts.map((f) => '''
        - asset: ${f.asset}
          ${f.weight != null ? 'weight: ${f.weight}' : ''}
          ${f.style != null ? 'style: ${f.style}' : ''}
''').join('')}
''').join('')}
''';
  }
}

/// App configuration
class AppConfig {
  final String appName;
  final String packageName;
  final String organizationName;
  final String description;
  final String appVersion;
  final String outputPath;
  
  // UI Configuration
  final bool multiPage;
  final Map<String, Map<String, dynamic>> pages;
  final Map<String, Map<String, dynamic>> routes;
  final String initialRoute;
  final Map<String, dynamic>? navigation;
  final Map<String, dynamic>? theme;
  final Map<String, dynamic> initialState;
  
  // Platform Configuration
  final String primaryColor;
  final bool useMaterial3;
  final List<FontConfig> fonts;
  
  // MCP Configuration
  final String? mcpServerUrl;
  final List<ToolConfig> tools;
  
  // Development Configuration
  final bool useLocalPackages;
  final String? runtimePath;
  final bool enableAnalytics;
  final bool enableCrashReporting;
  final bool enableDebugMode;
  
  // Additional
  final List<String> additionalDependencies;
  final String? additionalReadmeContent;
  
  AppConfig({
    required this.appName,
    required this.packageName,
    required this.organizationName,
    required this.description,
    this.appVersion = '1.0.0',
    required this.outputPath,
    this.multiPage = false,
    required this.pages,
    this.routes = const {},
    this.initialRoute = '/',
    this.navigation,
    this.theme,
    this.initialState = const {},
    this.primaryColor = 'Colors.blue',
    this.useMaterial3 = true,
    this.fonts = const [],
    this.mcpServerUrl,
    this.tools = const [],
    this.useLocalPackages = false,
    this.runtimePath,
    this.enableAnalytics = false,
    this.enableCrashReporting = false,
    this.enableDebugMode = true,
    this.additionalDependencies = const [],
    this.additionalReadmeContent,
  });
}

/// Font configuration
class FontConfig {
  final String family;
  final List<FontAsset> fonts;
  
  FontConfig({
    required this.family,
    required this.fonts,
  });
}

/// Font asset
class FontAsset {
  final String asset;
  final int? weight;
  final String? style;
  
  FontAsset({
    required this.asset,
    this.weight,
    this.style,
  });
}

/// Tool configuration
class ToolConfig {
  final String name;
  final String handler;
  
  ToolConfig({
    required this.name,
    required this.handler,
  });
}