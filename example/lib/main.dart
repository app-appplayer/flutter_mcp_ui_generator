import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'dart:io';
import 'dart:convert';

/// Flutter MCP UI Analysis Tool Example
///
/// This example demonstrates how to use the Flutter MCP UI Analysis Tool
/// to extract UI definitions from existing Flutter widgets and convert them to MCP UI DSL.
void main() {
  print('Flutter MCP UI Analysis Tool Examples');
  print('=' * 50);
  print('');

  // Show available analysis examples
  print('Available analysis examples:');
  print('1. Widget Analysis - analyze existing Flutter widgets');
  print('2. Layout Pattern Analysis - extract common layout patterns');
  print('3. Form Structure Analysis - analyze form implementations');
  print('4. Navigation Pattern Analysis - extract navigation structures');
  print('5. State Management Analysis - analyze state patterns');
  print('');
  print('Analysis results saved to example/analysis_results/');
  print('');

  // Simple analysis demonstration
  _runAnalysisExample();
}

void _runAnalysisExample() {
  print('Running analysis example...\n');

  // Simulate analyzing an existing Flutter widget structure
  print('Analyzing existing Flutter widget...');

  // Example: Analyze a typical Flutter Column with various widgets
  final analyzedStructure = _analyzeFlutterWidget();

  // Convert analysis to MCP UI DSL
  final mcpUiDefinition = _convertToMcpUi(analyzedStructure);

  // Output the analyzed and converted JSON
  final json = JsonEncoder.withIndent('  ').convert(mcpUiDefinition);
  print('Analyzed and converted to MCP UI DSL:');
  print(json);

  // Save analysis result
  final outputFile = File('example/analysis_results/simple_analysis.json');
  outputFile.parent.createSync(recursive: true);
  outputFile.writeAsStringSync(json);
  print('\nAnalysis result saved to: ${outputFile.path}');
}

/// Simulates analyzing an existing Flutter widget structure
Map<String, dynamic> _analyzeFlutterWidget() {
  print('  - Detected: Column widget');
  print('  - Detected: AppBar widget');
  print('  - Detected: Padding widget');
  print('  - Detected: Text widgets with styles');
  print('  - Detected: SizedBox for spacing');
  print('  - Detected: Button with onPressed callback');

  return {
    'type': 'flutter_widget_analysis',
    'root_widget': 'Column',
    'children': [
      {'type': 'AppBar', 'title': 'Hello MCP UI'},
      {
        'type': 'Padding',
        'padding': {'all': 16.0},
        'child': {
          'type': 'Column',
          'children': [
            {
              'type': 'Text',
              'content': 'Welcome to Flutter MCP UI Generator!',
              'style': {'fontSize': 24.0, 'fontWeight': 'bold'}
            },
            {'type': 'SizedBox', 'height': 16},
            {
              'type': 'Text',
              'content':
                  'This package helps you generate UI definitions programmatically.'
            },
            {'type': 'SizedBox', 'height': 32},
            {
              'type': 'ElevatedButton',
              'label': 'Get Started',
              'onPressed': 'showMessage'
            }
          ]
        }
      }
    ]
  };
}

/// Converts analyzed Flutter structure to MCP UI DSL
Map<String, dynamic> _convertToMcpUi(Map<String, dynamic> analysis) {
  print('  - Converting to MCP UI DSL v1.0...');
  print('  - Mapping Flutter widgets to MCP UI components');
  print('  - Converting event handlers to MCP actions');

  return MCPUIJsonGenerator.page(
    title: 'Converted from Flutter Analysis',
    content: MCPUIJsonGenerator.linear(
      direction: 'vertical',
      children: [
        MCPUIJsonGenerator.headerBar(title: 'Hello MCP UI'),
        MCPUIJsonGenerator.padding(
          padding: MCPUIJsonGenerator.edgeInsets(all: 16),
          child: MCPUIJsonGenerator.linear(
            direction: 'vertical',
            children: [
              MCPUIJsonGenerator.text(
                'Welcome to Flutter MCP UI Generator!',
                style: MCPUIJsonGenerator.textStyle(
                  fontSize: 24.0,
                  fontWeight: 'bold',
                ),
              ),
              MCPUIJsonGenerator.sizedBox(height: 16),
              MCPUIJsonGenerator.text(
                'This package helps you generate UI definitions programmatically.',
              ),
              MCPUIJsonGenerator.sizedBox(height: 32),
              MCPUIJsonGenerator.button(
                label: 'Get Started',
                click: MCPUIJsonGenerator.toolAction(
                  'showMessage',
                  params: {'message': 'Hello from MCP UI!'},
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
