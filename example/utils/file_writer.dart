import 'dart:io';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

/// Utility for writing JSON files in examples
/// 
/// This is not part of the main package, only for example usage
class ExampleFileWriter {
  /// Write a JSON definition to a file
  static void writeJsonFile(Map<String, dynamic> definition, String filename) {
    final jsonString = MCPUIJsonGenerator.toPrettyJson(definition);
    File(filename).writeAsStringSync(jsonString);
    print('Generated: $filename');
  }
}