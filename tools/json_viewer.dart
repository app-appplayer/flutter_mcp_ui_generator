import 'dart:io';
import 'dart:convert';

/// JSON Viewer Utility
/// 
/// A tool that reads generated JSON files and displays them in a structured format.
/// It can validate and preview JSON output from each example.
class JsonViewer {
  static void main(List<String> args) {
    print('🔍 Flutter MCP UI Generator - JSON Viewer');
    print('=' * 50);
    
    if (args.isEmpty) {
      print('Usage: dart run tools/json_viewer.dart [file path or directory]');
      print('Example: dart run tools/json_viewer.dart widgets_showcase_complete.json');
      print('Example: dart run tools/json_viewer.dart example/');
      return;
    }
    
    final path = args[0];
    final file = File(path);
    final directory = Directory(path);
    
    if (file.existsSync()) {
      viewJsonFile(file);
    } else if (directory.existsSync()) {
      viewJsonDirectory(directory);
    } else {
      print('❌ File or directory not found: $path');
    }
  }
  
  /// View single JSON file
  static void viewJsonFile(File file) {
    try {
      final content = file.readAsStringSync();
      final jsonData = jsonDecode(content);
      
      print('📄 File: ${file.path}');
      print('─' * 50);
      
      analyzeJsonStructure(jsonData);
      print('\n💾 Original JSON:');
      print('─' * 20);
      print(JsonEncoder.withIndent('  ').convert(jsonData));
      
    } catch (e) {
      print('❌ Failed to read JSON file: $e');
    }
  }
  
  /// View all JSON files in directory
  static void viewJsonDirectory(Directory directory) {
    final jsonFiles = directory
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.json'))
        .toList();
    
    if (jsonFiles.isEmpty) {
      print('❌ No JSON files found.');
      return;
    }
    
    print('📁 Directory: ${directory.path}');
    print('Found JSON files: ${jsonFiles.length}');
    print('=' * 50);
    
    for (final file in jsonFiles) {
      print('\n' + '=' * 80);
      viewJsonFile(file);
    }
  }
  
  /// Analyze JSON structure
  static void analyzeJsonStructure(dynamic json, [String prefix = '']) {
    if (json is Map) {
      final map = json as Map<String, dynamic>;
      
      // Check type
      if (map.containsKey('type')) {
        print('${prefix}🏷️  Type: ${map['type']}');
      }
      
      // Display main properties
      final importantKeys = [
        'title', 'version', 'routes', 'content', 'children', 'items',
        'label', 'value', 'onTap', 'onChange', 'style', 'state'
      ];
      
      for (final key in importantKeys) {
        if (map.containsKey(key)) {
          final value = map[key];
          if (value is String) {
            print('${prefix}📝 $key: "$value"');
          } else if (value is List) {
            print('${prefix}📋 $key: [${value.length} items]');
          } else if (value is Map) {
            print('${prefix}📦 $key: {${value.keys.length} properties}');
          } else {
            print('${prefix}⚡ $key: $value');
          }
        }
      }
      
      // Analyze child elements
      if (map.containsKey('children') && map['children'] is List) {
        final children = map['children'] as List;
        print('${prefix}👶 Child elements: ${children.length}');
        for (int i = 0; i < children.length && i < 3; i++) {
          print('${prefix}  [$i] ${_getTypeInfo(children[i])}');
        }
        if (children.length > 3) {
          print('${prefix}  ... and ${children.length - 3} more');
        }
      }
      
      if (map.containsKey('content')) {
        print('${prefix}📄 Content: ${_getTypeInfo(map['content'])}');
      }
      
    } else if (json is List) {
      print('${prefix}📋 Array: ${json.length} items');
      for (int i = 0; i < json.length && i < 3; i++) {
        print('${prefix}  [$i] ${_getTypeInfo(json[i])}');
      }
      if (json.length > 3) {
        print('${prefix}  ... and ${json.length - 3} more');
      }
    }
  }
  
  /// Extract type information
  static String _getTypeInfo(dynamic item) {
    if (item is Map) {
      final map = item as Map<String, dynamic>;
      if (map.containsKey('type')) {
        return '${map['type']}';
      } else {
        return '{${map.keys.length} properties}';
      }
    } else if (item is List) {
      return '[${item.length} items]';
    } else if (item is String) {
      return '"${item.length > 30 ? item.substring(0, 30) + '...' : item}"';
    } else {
      return '$item';
    }
  }
}

void main(List<String> args) {
  JsonViewer.main(args);
}