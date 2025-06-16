import 'dart:io';
import 'dart:convert';

/// JSON Viewer Utility
/// 
/// 생성된 JSON 파일들을 읽어서 구조화된 형태로 보여주는 도구입니다.
/// 각 예제의 JSON 출력을 검증하고 미리보기할 수 있습니다.
class JsonViewer {
  static void main(List<String> args) {
    print('🔍 Flutter MCP UI Generator - JSON Viewer');
    print('=' * 50);
    
    if (args.isEmpty) {
      print('사용법: dart run tools/json_viewer.dart [파일경로 또는 디렉토리]');
      print('예시: dart run tools/json_viewer.dart widgets_showcase_complete.json');
      print('예시: dart run tools/json_viewer.dart example/');
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
      print('❌ 파일이나 디렉토리를 찾을 수 없습니다: $path');
    }
  }
  
  /// 단일 JSON 파일 보기
  static void viewJsonFile(File file) {
    try {
      final content = file.readAsStringSync();
      final jsonData = jsonDecode(content);
      
      print('📄 파일: ${file.path}');
      print('─' * 50);
      
      analyzeJsonStructure(jsonData);
      print('\n💾 원본 JSON:');
      print('─' * 20);
      print(JsonEncoder.withIndent('  ').convert(jsonData));
      
    } catch (e) {
      print('❌ JSON 파일 읽기 실패: $e');
    }
  }
  
  /// 디렉토리 내 모든 JSON 파일 보기
  static void viewJsonDirectory(Directory directory) {
    final jsonFiles = directory
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.json'))
        .toList();
    
    if (jsonFiles.isEmpty) {
      print('❌ JSON 파일을 찾을 수 없습니다.');
      return;
    }
    
    print('📁 디렉토리: ${directory.path}');
    print('발견된 JSON 파일: ${jsonFiles.length}개');
    print('=' * 50);
    
    for (final file in jsonFiles) {
      print('\n' + '=' * 80);
      viewJsonFile(file);
    }
  }
  
  /// JSON 구조 분석
  static void analyzeJsonStructure(dynamic json, [String prefix = '']) {
    if (json is Map) {
      final map = json as Map<String, dynamic>;
      
      // 타입 확인
      if (map.containsKey('type')) {
        print('${prefix}🏷️  타입: ${map['type']}');
      }
      
      // 주요 속성들 표시
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
      
      // 자식 요소들 분석
      if (map.containsKey('children') && map['children'] is List) {
        final children = map['children'] as List;
        print('${prefix}👶 자식 요소: ${children.length}개');
        for (int i = 0; i < children.length && i < 3; i++) {
          print('${prefix}  [$i] ${_getTypeInfo(children[i])}');
        }
        if (children.length > 3) {
          print('${prefix}  ... 외 ${children.length - 3}개');
        }
      }
      
      if (map.containsKey('content')) {
        print('${prefix}📄 콘텐츠: ${_getTypeInfo(map['content'])}');
      }
      
    } else if (json is List) {
      print('${prefix}📋 배열: ${json.length}개 항목');
      for (int i = 0; i < json.length && i < 3; i++) {
        print('${prefix}  [$i] ${_getTypeInfo(json[i])}');
      }
      if (json.length > 3) {
        print('${prefix}  ... 외 ${json.length - 3}개');
      }
    }
  }
  
  /// 타입 정보 추출
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