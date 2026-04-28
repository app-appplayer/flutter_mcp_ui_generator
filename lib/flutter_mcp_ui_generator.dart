/// Flutter MCP UI Generator
///
/// A comprehensive toolkit for generating JSON UI definitions compatible with
/// MCP UI DSL v1.0/v1.1 specification and flutter_mcp_ui_runtime.
///
/// This package provides:
/// - JSON generation for applications, pages, and widgets
/// - Fluent API builder for programmatic UI construction
/// - Support for all action types (tool, state, navigation, resource, batch, conditional)
/// - v1.1 client actions, permissions, and bidirectional channels
/// - Helper methods for common patterns
library;

// Export main components
export 'src/json_generator.dart';
export 'src/templates.dart';
export 'src/ui_builder.dart';
// Note: app_generator.dart is not exported as it uses dart:io
// which would limit platform compatibility

// v1.2 Bundle serving exports
export 'src/bundle/bundle_ui_write_adapter.dart';

// Multi-language code generation (spec §5.3)
export 'src/codegen/python_generator.dart';
export 'src/codegen/typescript_generator.dart';
export 'src/codegen/javascript_generator.dart';
export 'src/codegen/go_generator.dart';
