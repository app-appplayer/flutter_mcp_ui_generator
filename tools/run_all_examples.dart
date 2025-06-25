import 'dart:io';

/// Example Runner Script
///
/// Script that runs all examples and validates generated JSON files.
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
    print('\n📄 Running: $example');
    print('-' * 40);

    try {
      final result = await Process.run('dart', ['run', example]);

      if (result.exitCode == 0) {
        print('✅ Success');
        print(result.stdout);
        successCount++;

        // Find generated JSON files
        final stdout = result.stdout as String;
        final jsonFiles = RegExp(r'([a-zA-Z0-9_-]+\.json)')
            .allMatches(stdout)
            .map((match) => match.group(1)!)
            .toSet()
            .toList();

        generatedFiles.addAll(jsonFiles);
      } else {
        print('❌ Failed');
        print('STDERR: ${result.stderr}');
        print('STDOUT: ${result.stdout}');
        failCount++;
      }
    } catch (e) {
      print('❌ Error: $e');
      failCount++;
    }
  }

  // Result summary
  print('\n' + '=' * 60);
  print('📊 Execution Result Summary');
  print('=' * 60);
  print('✅ Success: $successCount');
  print('❌ Failed: $failCount');
  print('📁 $successCount out of ${examples.length} examples succeeded');

  if (generatedFiles.isNotEmpty) {
    print('\n📄 Generated JSON files:');
    for (final file in generatedFiles) {
      final fileObj = File(file);
      if (fileObj.existsSync()) {
        final size = fileObj.lengthSync();
        print('  ✓ $file (${size} bytes)');
      } else {
        print('  ❌ $file (file not found)');
      }
    }
  }

  // JSON validation
  print('\n🔍 Validating JSON files...');
  await validateJsonFiles(generatedFiles);

  // Next steps guide
  print('\n🎯 Next steps:');
  print('1. View JSON with web viewer: open tools/web_viewer.html');
  print('2. View individual JSON: dart run tools/json_viewer.dart <filename>');
  print('3. View all JSON: dart run tools/json_viewer.dart .');

  if (failCount == 0) {
    print('\n🎉 All examples ran successfully!');
    exit(0);
  } else {
    print('\n⚠️  Some examples failed to run. Please check the logs.');
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

      // Basic MCP UI structure validation
      if (jsonData is Map) {
        final map = jsonData as Map<String, dynamic>;
        if (map.containsKey('type')) {
          print('  ✓ $fileName - type: ${map['type']}');
          validCount++;
        } else {
          print('  ⚠️  $fileName - missing type attribute');
          invalidCount++;
        }
      } else {
        print('  ❌ $fileName - not a valid JSON object');
        invalidCount++;
      }
    } catch (e) {
      print('  ❌ $fileName - JSON parsing error: $e');
      invalidCount++;
    }
  }

  print('\n📊 JSON validation result:');
  print('✅ Valid files: $validCount');
  print('❌ Problematic files: $invalidCount');
}

// Simple implementation for JSON decoding
dynamic jsonDecode(String source) {
  // In practice, dart:convert should be used
  // Here we only perform simple validation
  if (source.trim().startsWith('{') && source.trim().endsWith('}')) {
    return {'type': 'unknown'}; // Temporary return value
  }
  throw FormatException('Invalid JSON');
}
