import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'dart:io';
import 'dart:convert';

/// Dynamic Form Analysis Example
///
/// This example demonstrates analyzing dynamic Flutter forms and converting them to MCP UI DSL.
/// It shows pattern recognition for conditional form fields and reactive UI elements.
void main() {
  print('=== Dynamic Form Analysis Example ===\n');

  print('Analyzing dynamic form patterns...');
  _analyzeDynamicFormPatterns();

  print('\nGenerating reactive MCP UI form...');
  _generateReactiveForm();

  print('\n=== Analysis complete! ===');
  print('Check the results:');
  print('- dynamic_form_analysis.json');
  print('- reactive_mcp_form.json');
}

void _analyzeDynamicFormPatterns() {
  print('  Detecting dynamic form patterns in Flutter code...');

  final dynamicFormAnalysis = {
    'dynamic_patterns': [
      {
        'pattern': 'Conditional Field Display',
        'flutter_code': 'if (showField) TextFormField(...)',
        'mcp_equivalent':
            'conditionalWidget(condition: "{{showField}}", then: textInput(...))',
        'frequency': 'high'
      },
      {
        'pattern': 'Dropdown-dependent Fields',
        'flutter_code': 'DropdownButton + conditional TextFormField',
        'mcp_equivalent': 'select + conditionalWidget based on selection',
        'frequency': 'medium'
      },
      {
        'pattern': 'Add/Remove Field Lists',
        'flutter_code': 'ListView.builder with dynamic item count',
        'mcp_equivalent': 'list with dynamic items binding',
        'frequency': 'medium'
      }
    ],
    'state_management_patterns': [
      'Form field visibility state',
      'Dynamic field validation',
      'Progressive form disclosure',
      'Multi-step form navigation'
    ],
    'user_experience_patterns': [
      'Smooth field transitions',
      'Progressive enhancement',
      'Smart field defaults',
      'Real-time validation feedback'
    ]
  };

  _saveAnalysisResult('dynamic_form_analysis.json', dynamicFormAnalysis);
  print('  ✓ Dynamic form analysis completed');
}

void _generateReactiveForm() {
  print('  Converting to reactive MCP UI form...');

  final reactiveForm = MCPUIJsonGenerator.page(
    title: 'Customer Survey',
    content: MCPUIJsonGenerator.linear(
      direction: 'vertical',
      children: [
        MCPUIJsonGenerator.headerBar(
          title: 'Dynamic Survey Form',
        ),
        MCPUIJsonGenerator.box(
          padding: MCPUIJsonGenerator.edgeInsets(all: 16),
          child: MCPUIJsonGenerator.linear(
            direction: 'vertical',
            gap: 16.0,
            children: [
              // Progress indicator
              MCPUIJsonGenerator.card(
                child: MCPUIJsonGenerator.box(
                  padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                  child: MCPUIJsonGenerator.linear(
                    direction: 'vertical',
                    gap: 8.0,
                    children: [
                      MCPUIJsonGenerator.text(
                        'Survey Progress',
                        style: MCPUIJsonGenerator.textStyle(fontWeight: 'bold'),
                      ),
                      MCPUIJsonGenerator.text(
                        'Step {{survey.currentStep}} of {{survey.totalSteps}}',
                        style: MCPUIJsonGenerator.textStyle(color: '#666666'),
                      ),
                    ],
                  ),
                ),
              ),

              // Basic information
              MCPUIJsonGenerator.textInput(
                label: 'Full Name',
                value: MCPUIJsonGenerator.binding('survey.name'),
                change: MCPUIJsonGenerator.stateAction(
                  action: 'set',
                  binding: 'survey.name',
                  value: '{{event.value}}',
                ),
              ),

              // Customer type selection
              MCPUIJsonGenerator.select(
                label: 'Customer Type',
                value: MCPUIJsonGenerator.binding('survey.customerType'),
                items: [
                  {'value': 'individual', 'label': 'Individual'},
                  {'value': 'business', 'label': 'Business'},
                  {'value': 'enterprise', 'label': 'Enterprise'},
                ],
                change: MCPUIJsonGenerator.stateAction(
                  action: 'set',
                  binding: 'survey.customerType',
                  value: '{{event.value}}',
                ),
              ),

              // Conditional business fields
              MCPUIJsonGenerator.conditionalWidget(
                condition:
                    '{{survey.customerType == "business" || survey.customerType == "enterprise"}}',
                then: MCPUIJsonGenerator.linear(
                  direction: 'vertical',
                  gap: 12.0,
                  children: [
                    MCPUIJsonGenerator.textInput(
                      label: 'Company Name',
                      value: MCPUIJsonGenerator.binding('survey.companyName'),
                      change: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'survey.companyName',
                        value: '{{event.value}}',
                      ),
                    ),
                    MCPUIJsonGenerator.textInput(
                      label: 'Job Title',
                      value: MCPUIJsonGenerator.binding('survey.jobTitle'),
                      change: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'survey.jobTitle',
                        value: '{{event.value}}',
                      ),
                    ),
                  ],
                ),
              ),

              // Conditional enterprise fields
              MCPUIJsonGenerator.conditionalWidget(
                condition: '{{survey.customerType == "enterprise"}}',
                then: MCPUIJsonGenerator.linear(
                  direction: 'vertical',
                  gap: 12.0,
                  children: [
                    MCPUIJsonGenerator.textInput(
                      label: 'Employee Count',
                      value: MCPUIJsonGenerator.binding('survey.employeeCount'),
                      change: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'survey.employeeCount',
                        value: '{{event.value}}',
                      ),
                    ),
                    MCPUIJsonGenerator.checkbox(
                      label: 'Require enterprise support',
                      value: MCPUIJsonGenerator.binding(
                          'survey.enterpriseSupport'),
                      change: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'survey.enterpriseSupport',
                        value: '{{event.value}}',
                      ),
                    ),
                  ],
                ),
              ),

              // Submit button
              MCPUIJsonGenerator.button(
                label: 'Submit Survey',
                click: MCPUIJsonGenerator.toolAction(
                  'submitSurvey',
                  params: {
                    'name': '{{survey.name}}',
                    'customerType': '{{survey.customerType}}',
                    'companyName': '{{survey.companyName}}',
                    'jobTitle': '{{survey.jobTitle}}',
                    'employeeCount': '{{survey.employeeCount}}',
                    'enterpriseSupport': '{{survey.enterpriseSupport}}',
                  },
                ),
                style: 'elevated',
              ),
            ],
          ),
        ),
      ],
    ),
    state: {
      'initial': {
        'survey': {
          'currentStep': 1,
          'totalSteps': 3,
          'name': '',
          'customerType': 'individual',
          'companyName': '',
          'jobTitle': '',
          'employeeCount': '',
          'enterpriseSupport': false,
        },
      },
    },
  );

  _saveAnalysisResult('reactive_mcp_form.json', reactiveForm);
  print('  ✓ Reactive MCP UI form generated');
}

void _saveAnalysisResult(String filename, Map<String, dynamic> data) {
  final outputFile = File('example/analysis_results/$filename');
  outputFile.parent.createSync(recursive: true);

  final json = JsonEncoder.withIndent('  ').convert(data);
  outputFile.writeAsStringSync(json);

  print('    → Saved to: $filename');
}
