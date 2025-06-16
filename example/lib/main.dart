import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'dart:io';
import 'dart:convert';

/// Flutter MCP UI Generator Example
/// 
/// This example demonstrates various ways to use the Flutter MCP UI Generator
/// to create UI definitions programmatically.
void main() {
  print('Flutter MCP UI Generator Examples');
  print('=' * 50);
  print('');
  
  // Show available examples
  print('Available examples:');
  print('1. Basic Widgets - widgets_showcase.dart');
  print('2. Forms & Input - login_form.dart, user_profile_form.dart, dynamic_form.dart');
  print('3. Navigation - multi_page_app.dart');
  print('4. State Management - todo_list.dart');
  print('5. Real World Apps - weather_app.dart');
  print('');
  print('Generated JSON files can be found in example/json_examples/');
  print('');
  
  // Simple demonstration
  _runSimpleExample();
}

void _runSimpleExample() {
  print('Running simple example...\n');
  
  // Create a simple UI using the JSON generator directly
  final ui = MCPUIJsonGenerator.page(
    title: 'Example Page',
    content: MCPUIJsonGenerator.column(
      children: [
        MCPUIJsonGenerator.appBar(title: 'Hello MCP UI'),
        MCPUIJsonGenerator.padding(
          padding: {'all': 16.0},
          child: MCPUIJsonGenerator.column(
            children: [
              MCPUIJsonGenerator.text(
                'Welcome to Flutter MCP UI Generator!',
                style: {'fontSize': 24.0, 'fontWeight': 'bold'},
              ),
              MCPUIJsonGenerator.sizedBox(height: 16),
              MCPUIJsonGenerator.text(
                'This package helps you generate UI definitions programmatically.',
              ),
              MCPUIJsonGenerator.sizedBox(height: 32),
              MCPUIJsonGenerator.button(
                label: 'Get Started',
                onTap: MCPUIJsonGenerator.toolAction(
                  'showMessage',
                  args: {'message': 'Hello from MCP UI!'},
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  
  // Output the generated JSON
  final json = JsonEncoder.withIndent('  ').convert(ui);
  print('Generated UI JSON:');
  print(json);
  
  // Save to file
  final outputFile = File('example/json_examples/simple_example.json');
  outputFile.writeAsStringSync(json);
  print('\nJSON saved to: ${outputFile.path}');
}