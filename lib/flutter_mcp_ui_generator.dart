/// Flutter MCP UI Generator
///
/// A comprehensive toolkit for generating JSON UI definitions compatible with
/// MCP UI DSL v1.0 specification and flutter_mcp_ui_runtime.
///
/// This package provides:
/// - JSON generation for applications, pages, and widgets
/// - Fluent API builder for programmatic UI construction
/// - Support for all action types (tool, state, navigation, resource, batch, conditional)
/// - Helper methods for common patterns
library;

// Export main components
export 'src/json_generator.dart';
export 'src/ui_builder.dart';
// Note: app_generator.dart is not exported as it uses dart:io
// which would limit platform compatibility
