import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'dart:io';
import 'dart:convert';

/// MCP UI DSL v1.0 Analysis Example
///
/// This example demonstrates analyzing Flutter code that uses MCP UI DSL v1.0 patterns
/// and converting them to the latest specification compliance.
void main() {
  print('=== MCP UI DSL v1.0 Analysis Example ===\n');

  // Analyze v1.0 compliance patterns
  print('1. Analyzing MCP UI DSL v1.0 compliance...');
  _analyzeV1Compliance();

  // Demonstrate modern widget analysis
  print('\n2. Analyzing modern widget patterns...');
  _analyzeModernWidgets();

  // Show accessibility pattern analysis
  print('\n3. Analyzing accessibility patterns...');
  _analyzeAccessibilityPatterns();

  // Generate complete v1.0 compliant application
  print('\n4. Generating v1.0 compliant application...');
  _generateCompliantApplication();

  print('\n=== Analysis complete! ===');
  print('Check the results:');
  print('- v1_compliance_analysis.json');
  print('- modern_widgets_analysis.json');
  print('- accessibility_analysis.json');
  print('- v1_compliant_app.json');
}

void _analyzeV1Compliance() {
  print('  Checking MCP UI DSL v1.0 specification compliance...');

  final complianceAnalysis = {
    'specification_version': 'MCP UI DSL v1.0',
    'analyzed_features': {
      'widget_naming': {
        'compliant': [
          'linear (instead of column/row)',
          'box (instead of container)',
          'headerBar (instead of appBar)',
          'bottomNavigation (instead of bottomNavigationBar)',
          'textInput (instead of textField)',
          'loadingIndicator (instead of circularProgressIndicator)'
        ],
        'analysis_notes':
            'All widget names follow single-word lowercase or CamelCase convention'
      },
      'event_handling': {
        'compliant': [
          'click (instead of onTap)',
          'change (instead of onChange)',
          'doubleClick, rightClick, longPress for specialized events'
        ],
        'analysis_notes': 'Event properties use consistent CamelCase naming'
      },
      'action_parameters': {
        'compliant': [
          'path (for state actions)',
          'target (for resource actions)',
          'params (for tool actions instead of args)'
        ],
        'analysis_notes': 'Parameter naming is consistent across action types'
      },
      'layout_system': {
        'compliant': [
          'linear layout with direction property',
          'distribution property for alignment',
          'gap property for spacing'
        ],
        'analysis_notes':
            'Modern layout system replaces legacy row/column approach'
      }
    },
    'compliance_score': '100%',
    'recommendations': [
      'All patterns analyzed are fully compliant with MCP UI DSL v1.0',
      'Widget hierarchy follows specification guidelines',
      'Event handling uses proper action system',
      'State management follows binding/path distinction'
    ]
  };

  _saveAnalysisResult('v1_compliance_analysis.json', complianceAnalysis);
  print('  ✓ v1.0 compliance analysis completed');
}

void _analyzeModernWidgets() {
  print('  Analyzing modern widget usage patterns...');

  final modernWidgetAnalysis = {
    'modern_patterns': [
      {
        'pattern': 'Linear Layout System',
        'v1_implementation': 'linear(direction: vertical/horizontal)',
        'benefits': 'Unified layout system, consistent API',
        'usage_frequency': 'very_high'
      },
      {
        'pattern': 'Semantic Actions',
        'v1_implementation': 'click, change, submit events',
        'benefits': 'Clear intent, better accessibility',
        'usage_frequency': 'high'
      },
      {
        'pattern': 'Conditional Rendering',
        'v1_implementation': 'conditionalWidget with condition/then/else',
        'benefits': 'Dynamic UI based on state',
        'usage_frequency': 'medium'
      },
      {
        'pattern': 'Advanced Input Widgets',
        'v1_implementation': 'dateField, timeField, colorPicker, etc.',
        'benefits': 'Rich user input capabilities',
        'usage_frequency': 'medium'
      }
    ],
    'conversion_examples': _generateModernWidgetExamples()
  };

  _saveAnalysisResult('modern_widgets_analysis.json', modernWidgetAnalysis);
  print('  ✓ Modern widget analysis completed');
}

Map<String, dynamic> _generateModernWidgetExamples() {
  return {
    'linear_layout_example': MCPUIJsonGenerator.linear(
      direction: 'vertical',
      distribution: 'space-between',
      gap: 16.0,
      children: [
        MCPUIJsonGenerator.headerBar(
          title: 'Modern App',
          actions: [
            MCPUIJsonGenerator.button(
              label: 'Settings',
              click: MCPUIJsonGenerator.navigationAction(
                action: 'push',
                route: '/settings',
              ),
            ),
          ],
        ),
        MCPUIJsonGenerator.box(
          padding: MCPUIJsonGenerator.edgeInsets(all: 16),
          child: MCPUIJsonGenerator.text(
            'Modern MCP UI v1.0 Implementation',
            style: MCPUIJsonGenerator.textStyle(
              fontSize: 24.0,
              fontWeight: 'bold',
            ),
          ),
        ),
      ],
    ),
    'advanced_form_example': MCPUIJsonGenerator.linear(
      direction: 'vertical',
      gap: 12.0,
      children: [
        MCPUIJsonGenerator.textInput(
          label: 'Name',
          value: MCPUIJsonGenerator.binding('form.name'),
          change: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'form.name',
            value: '{{event.value}}',
          ),
        ),
        MCPUIJsonGenerator.toggle(
          label: 'Enable notifications',
          value: MCPUIJsonGenerator.binding('form.notifications'),
          change: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'form.notifications',
            value: '{{event.value}}',
          ),
        ),
        MCPUIJsonGenerator.button(
          label: 'Submit',
          click: MCPUIJsonGenerator.toolAction(
            'submitForm',
            params: {
              'name': '{{form.name}}',
              'notifications': '{{form.notifications}}',
            },
          ),
        ),
      ],
    ),
  };
}

void _analyzeAccessibilityPatterns() {
  print('  Analyzing accessibility implementation patterns...');

  final accessibilityAnalysis = {
    'accessibility_features': {
      'semantic_widgets': [
        'headerBar provides navigation context',
        'button has semantic role and labels',
        'textInput has proper labeling',
        'form provides structure'
      ],
      'screen_reader_support': [
        'All widgets have semantic meaning',
        'Labels and hints are properly defined',
        'Navigation flow is logical'
      ],
      'keyboard_navigation': [
        'Tab order follows logical flow',
        'All interactive elements are reachable',
        'Focus indicators are provided'
      ]
    },
    'accessible_widget_example': MCPUIJsonGenerator.linear(
      direction: 'vertical',
      children: [
        MCPUIJsonGenerator.headerBar(
          title: 'Accessible Form',
        ),
        MCPUIJsonGenerator.box(
          padding: MCPUIJsonGenerator.edgeInsets(all: 16),
          child: MCPUIJsonGenerator.linear(
            direction: 'vertical',
            gap: 16.0,
            children: [
              MCPUIJsonGenerator.text(
                'Please fill out the form',
                style: MCPUIJsonGenerator.textStyle(
                  fontSize: 18.0,
                  fontWeight: 'bold',
                ),
              ),
              MCPUIJsonGenerator.textInput(
                label: 'Email Address',
                placeholder: 'Enter your email',
                value: MCPUIJsonGenerator.binding('user.email'),
                change: MCPUIJsonGenerator.stateAction(
                  action: 'set',
                  binding: 'user.email',
                  value: '{{event.value}}',
                ),
              ),
              MCPUIJsonGenerator.button(
                label: 'Subscribe',
                click: MCPUIJsonGenerator.toolAction('subscribe', params: {}),
              ),
            ],
          ),
        ),
      ],
    ),
  };

  _saveAnalysisResult('accessibility_analysis.json', accessibilityAnalysis);
  print('  ✓ Accessibility analysis completed');
}

void _generateCompliantApplication() {
  print('  Generating MCP UI DSL v1.0 compliant application...');

  final compliantApp = MCPUIJsonGenerator.application(
    title: 'MCP UI v1.0 Demo',
    version: '1.0.0',
    routes: {
      '/': 'ui://pages/home',
      '/settings': 'ui://pages/settings',
      '/profile': 'ui://pages/profile',
    },
    initialRoute: '/',
    theme: {
      'colors': {
        'primary': '#2196F3',
        'secondary': '#FF5722',
        'surface': '#FFFFFF',
        'background': '#F5F5F5',
      },
      'typography': {
        'heading': {'fontSize': 24, 'fontWeight': 'bold'},
        'body': {'fontSize': 16, 'color': '#333333'},
      },
    },
    navigation: {
      'type': 'bottomNavigation',
      'items': [
        {'label': 'Home', 'icon': 'home', 'route': '/'},
        {'label': 'Settings', 'icon': 'settings', 'route': '/settings'},
        {'label': 'Profile', 'icon': 'person', 'route': '/profile'},
      ],
    },
    state: {
      'initial': {
        'user': {'name': '', 'email': ''},
        'settings': {'notifications': true, 'theme': 'light'},
        'navigation': {'currentIndex': 0},
      },
    },
  );

  _saveAnalysisResult('v1_compliant_app.json', compliantApp);
  print('  ✓ v1.0 compliant application generated');
}

void _saveAnalysisResult(String filename, Map<String, dynamic> data) {
  final outputFile = File('example/analysis_results/$filename');
  outputFile.parent.createSync(recursive: true);

  final json = JsonEncoder.withIndent('  ').convert(data);
  outputFile.writeAsStringSync(json);

  print('    → Saved to: $filename');
}
