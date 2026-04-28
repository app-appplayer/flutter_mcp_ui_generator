import 'package:mcp_bundle/mcp_bundle.dart';

/// Write adapter that implements [UiPort] from mcp_bundle.
///
/// Converts programmatically generated UI definition JSON into
/// bundle-compatible sections. Returns [UiWriteOutput] containing
/// [UiSection] and manifestMetadata map.
///
/// Single-direction adapter: [toDefinition] and [toAppInfo] throw
/// [UnsupportedError].
class BundleUiWriteAdapter implements UiPort {
  @override
  Future<UiResult<UiWriteOutput>> fromDefinition(
      Map<String, dynamic> definitionJson) async {
    // Handle empty definition gracefully
    if (definitionJson.isEmpty) {
      return UiResult.ok(UiWriteOutput(
        uiSection: const UiSection(pages: []),
        manifestMetadata: {},
      ));
    }

    // Extract manifest metadata
    final manifestMetadata = <String, dynamic>{};

    // title → name mapping
    if (definitionJson['title'] != null) {
      manifestMetadata['name'] = definitionJson['title'];
    }
    if (definitionJson['version'] != null) {
      manifestMetadata['version'] = definitionJson['version'];
    }
    if (definitionJson['id'] != null) {
      manifestMetadata['id'] = definitionJson['id'];
    }
    if (definitionJson['description'] != null) {
      manifestMetadata['description'] = definitionJson['description'];
    }
    if (definitionJson['icon'] != null) {
      // bundle:// URIs preserved as-is (resolution is read adapter's concern)
      manifestMetadata['icon'] = definitionJson['icon'];
    }
    if (definitionJson['splash'] != null) {
      manifestMetadata['splash'] = definitionJson['splash'];
    }
    if (definitionJson['category'] != null) {
      // Free-form string; AppCategory mapping is caller's concern
      manifestMetadata['category'] = definitionJson['category'];
    }
    if (definitionJson['publisher'] != null) {
      manifestMetadata['publisher'] = definitionJson['publisher'];
    }
    if (definitionJson['screenshots'] != null) {
      manifestMetadata['screenshots'] = definitionJson['screenshots'];
    }

    // Unwrap timestamps from TimestampInfo
    final timestamps = definitionJson['timestamps'];
    if (timestamps is Map<String, dynamic>) {
      if (timestamps['createdAt'] != null) {
        manifestMetadata['createdAt'] = timestamps['createdAt'];
      }
      if (timestamps['updatedAt'] != null) {
        manifestMetadata['updatedAt'] = timestamps['updatedAt'];
      }
    }

    // Extract UI section: routes, theme, state, navigation
    final pageDefinitions = <PageDefinition>[];

    // Convert routes + pages to PageDefinitions
    final routes = definitionJson['routes'];
    final pages = definitionJson['pages'] as Map<String, dynamic>?;
    if (routes is Map<String, dynamic>) {
      for (final entry in routes.entries) {
        final routePath = entry.key;
        final resourceUri = entry.value as String;

        // Extract page ID from resource URI (ui://pages/{id})
        final pageId = resourceUri.startsWith('ui://pages/')
            ? resourceUri.substring('ui://pages/'.length)
            : entry.key.replaceAll('/', '_').replaceFirst('_', '');

        // Try to get embedded page content
        final pageJson = pages?[pageId] as Map<String, dynamic>?;
        final root = pageJson != null
            ? WidgetNode.fromJson(
                pageJson['root'] as Map<String, dynamic>? ?? pageJson)
            : const WidgetNode(type: 'container');

        pageDefinitions.add(PageDefinition(
          id: pageId.isEmpty ? 'main' : pageId,
          name: pageId.isEmpty ? 'Main' : pageId,
          route: routePath,
          root: root,
        ));
      }
    }

    // Build theme config
    ThemeConfig? themeConfig;
    if (definitionJson['theme'] != null) {
      themeConfig = ThemeConfig.fromJson(
          definitionJson['theme'] as Map<String, dynamic>);
    }

    // Build navigation config
    NavigationConfig? navigationConfig;
    if (definitionJson['navigation'] != null) {
      navigationConfig = NavigationConfig.fromJson(
          definitionJson['navigation'] as Map<String, dynamic>);
    }

    // Build state
    // Supports flat values: {"initial": {"count": 0}}
    // and rich definitions: {"initial": {"count": {"initialValue": 0, "type": "number", "persist": true}}}
    final stateMap = <String, StateDefinition>{};
    final stateJson = definitionJson['state'];
    if (stateJson is Map<String, dynamic>) {
      final initial = stateJson['initial'] as Map<String, dynamic>?;
      if (initial != null) {
        for (final entry in initial.entries) {
          final value = entry.value;
          if (value is Map<String, dynamic> &&
              (value.containsKey('initialValue') ||
                  value.containsKey('type') ||
                  value.containsKey('persist') ||
                  value.containsKey('computed'))) {
            // Rich StateDefinition format
            stateMap[entry.key] = StateDefinition.fromJson(value);
          } else {
            // Flat value format
            stateMap[entry.key] = StateDefinition(initialValue: value);
          }
        }
      }
    }

    final uiSection = UiSection(
      pages: pageDefinitions,
      theme: themeConfig,
      navigation: navigationConfig,
      state: stateMap,
    );

    return UiResult.ok(UiWriteOutput(
      uiSection: uiSection,
      manifestMetadata: manifestMetadata,
    ));
  }

  @override
  Future<UiResult<Map<String, dynamic>>> toDefinition(McpBundle bundle) {
    throw UnsupportedError(
        'BundleUiWriteAdapter does not support read operations');
  }

  @override
  Future<UiResult<Map<String, dynamic>>> toAppInfo(McpBundle bundle) {
    throw UnsupportedError(
        'BundleUiWriteAdapter does not support read operations');
  }
}
