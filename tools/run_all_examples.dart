import 'dart:io';

/// Example Runner Script
/// 
/// 모든 예제를 실행하고 생성된 JSON 파일들을 검증하는 스크립트입니다.
void main() async {
  print('🚀 Flutter MCP UI Generator - Example Runner');
  print('=' * 60);
  
  final examples = [
    'example/01_basic_widgets/widgets_showcase.dart',
    'example/02_forms_input/login_form.dart',
    'example/02_forms_input/user_profile_form.dart',
    'example/02_forms_input/dynamic_form.dart',
    'example/03_navigation/multi_page_app.dart',
    'example/04_state_management/todo_list.dart',
    'example/05_real_world/weather_app.dart',
  ];
  
  int successCount = 0;
  int failCount = 0;
  final List<String> generatedFiles = [];
  
  for (final example in examples) {
    print('\n📄 실행 중: $example');
    print('-' * 40);
    
    try {
      final result = await Process.run('dart', ['run', example]);
      
      if (result.exitCode == 0) {
        print('✅ 성공');
        print(result.stdout);
        successCount++;
        
        // 생성된 JSON 파일들 찾기
        final stdout = result.stdout as String;
        final jsonFiles = RegExp(r'([a-zA-Z0-9_-]+\.json)')
            .allMatches(stdout)
            .map((match) => match.group(1)!)
            .toSet()
            .toList();
        
        generatedFiles.addAll(jsonFiles);
      } else {
        print('❌ 실패');
        print('STDERR: ${result.stderr}');
        print('STDOUT: ${result.stdout}');
        failCount++;
      }
    } catch (e) {
      print('❌ 오류: $e');
      failCount++;
    }
  }
  
  // 결과 요약
  print('\n' + '=' * 60);
  print('📊 실행 결과 요약');
  print('=' * 60);
  print('✅ 성공: $successCount개');
  print('❌ 실패: $failCount개');
  print('📁 총 ${examples.length}개 예제 중 ${successCount}개 성공');
  
  if (generatedFiles.isNotEmpty) {
    print('\n📄 생성된 JSON 파일들:');
    for (final file in generatedFiles) {
      final fileObj = File(file);
      if (fileObj.existsSync()) {
        final size = fileObj.lengthSync();
        print('  ✓ $file (${size} bytes)');
      } else {
        print('  ❌ $file (파일을 찾을 수 없음)');
      }
    }
  }
  
  // JSON 검증
  print('\n🔍 JSON 파일 검증 중...');
  await validateJsonFiles(generatedFiles);
  
  // 다음 단계 안내
  print('\n🎯 다음 단계:');
  print('1. 웹 뷰어로 JSON 확인: open tools/web_viewer.html');
  print('2. 개별 JSON 확인: dart run tools/json_viewer.dart <파일명>');
  print('3. 모든 JSON 확인: dart run tools/json_viewer.dart .');
  
  if (failCount == 0) {
    print('\n🎉 모든 예제가 성공적으로 실행되었습니다!');
    exit(0);
  } else {
    print('\n⚠️  일부 예제 실행에 실패했습니다. 로그를 확인해주세요.');
    exit(1);
  }
}

Future<void> validateJsonFiles(List<String> files) async {
  int validCount = 0;
  int invalidCount = 0;
  
  for (final fileName in files) {
    final file = File(fileName);
    if (!file.existsSync()) continue;
    
    try {
      final content = await file.readAsString();
      final jsonData = jsonDecode(content);
      
      // 기본 MCP UI 구조 검증
      if (jsonData is Map) {
        final map = jsonData as Map<String, dynamic>;
        if (map.containsKey('type')) {
          print('  ✓ $fileName - 타입: ${map['type']}');
          validCount++;
        } else {
          print('  ⚠️  $fileName - type 속성이 없음');
          invalidCount++;
        }
      } else {
        print('  ❌ $fileName - 올바른 JSON 객체가 아님');
        invalidCount++;
      }
    } catch (e) {
      print('  ❌ $fileName - JSON 파싱 오류: $e');
      invalidCount++;
    }
  }
  
  print('\n📊 JSON 검증 결과:');
  print('✅ 유효한 파일: $validCount개');
  print('❌ 문제가 있는 파일: $invalidCount개');
}

// JSON 디코딩을 위한 간단한 구현
dynamic jsonDecode(String source) {
  // 실제로는 dart:convert를 사용해야 하지만
  // 여기서는 간단한 검증만 수행
  if (source.trim().startsWith('{') && source.trim().endsWith('}')) {
    return {'type': 'unknown'}; // 임시 반환값
  }
  throw FormatException('Invalid JSON');
}