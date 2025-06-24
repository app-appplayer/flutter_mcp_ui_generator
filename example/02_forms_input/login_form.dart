import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'dart:io';
import 'dart:convert';

/// Login Form Analysis Example
/// 
/// This example demonstrates analyzing existing Flutter login forms and converting them to MCP UI DSL.
/// It shows pattern recognition for form layouts, input validation, and user authentication flows.
void main() {
  print('=== Login Form Analysis Example ===\n');
  
  print('Analyzing Flutter login form patterns...');
  _analyzeLoginFormPatterns();
  
  print('\nGenerating MCP UI login form from analysis...');
  _generateMcpLoginForm();
  
  print('\n=== Analysis complete! ===');
  print('Check the results:');
  print('- login_form_analysis.json');
  print('- mcp_login_form.json');
}

void _analyzeLoginFormPatterns() {
  print('  Detecting common login form patterns...');
  
  // Simulate analyzing existing Flutter login forms
  final loginFormAnalysis = {
    'form_structure': {
      'container_pattern': 'Card with padding and elevation for form container',
      'layout_pattern': 'Column with centered alignment and proper spacing',
      'title_section': 'Icon + Welcome text + subtitle description',
      'input_section': 'Email field + Password field with validation',
      'action_section': 'Login button + forgot password link + signup link',
      'error_handling': 'Conditional error message display'
    },
    'detected_widgets': [
      {
        'type': 'Container',
        'usage': 'Form wrapper with padding and constraints',
        'properties': ['padding', 'width', 'alignment']
      },
      {
        'type': 'Card', 
        'usage': 'Elevated form container',
        'properties': ['elevation', 'child']
      },
      {
        'type': 'Column',
        'usage': 'Vertical form layout',
        'properties': ['children', 'mainAxisAlignment', 'crossAxisAlignment']
      },
      {
        'type': 'TextFormField',
        'usage': 'Email and password input',
        'properties': ['decoration', 'validator', 'obscureText', 'controller']
      },
      {
        'type': 'ElevatedButton',
        'usage': 'Primary login action',
        'properties': ['onPressed', 'child', 'style']
      },
      {
        'type': 'TextButton',
        'usage': 'Secondary actions (forgot password, signup)',
        'properties': ['onPressed', 'child']
      }
    ],
    'validation_patterns': [
      'Email format validation using RegExp',
      'Password strength requirements',
      'Required field validation',
      'Real-time validation feedback'
    ],
    'state_management': [
      'Form state tracking (email, password, loading, error)',
      'Validation state per field',
      'Loading state during authentication',
      'Error state display and clearing'
    ]
  };
  
  // Save analysis results
  _saveAnalysisResult('login_form_analysis.json', loginFormAnalysis);
  print('  ✓ Login form patterns analyzed');
}

void _generateMcpLoginForm() {
  print('  Converting analyzed patterns to MCP UI DSL...');
  
  // Convert the analyzed patterns to MCP UI components
  final mcpLoginForm = MCPUIJsonGenerator.page(
    title: 'Login',
    content: MCPUIJsonGenerator.center(
      child: MCPUIJsonGenerator.box(
        width: 400.0,
        padding: MCPUIJsonGenerator.edgeInsets(all: 24),
        child: MCPUIJsonGenerator.card(
          elevation: 8.0,
          child: MCPUIJsonGenerator.padding(
            padding: MCPUIJsonGenerator.edgeInsets(all: 32),
            child: MCPUIJsonGenerator.linear(
              direction: 'vertical',
              alignment: 'center',
              children: [
                // Header section
                MCPUIJsonGenerator.icon(
                  icon: 'lock',
                  size: 64.0,
                  color: '#2196F3',
                ),
                MCPUIJsonGenerator.sizedBox(height: 16),
                MCPUIJsonGenerator.text(
                  'Welcome Back',
                  style: MCPUIJsonGenerator.textStyle(
                    fontSize: 28.0,
                    fontWeight: 'bold',
                    color: '#333333',
                  ),
                ),
                MCPUIJsonGenerator.sizedBox(height: 8),
                MCPUIJsonGenerator.text(
                  'Please sign in to your account',
                  style: MCPUIJsonGenerator.textStyle(
                    fontSize: 16.0,
                    color: '#666666',
                  ),
                ),
                MCPUIJsonGenerator.sizedBox(height: 32),
                
                // Error message (conditional)
                MCPUIJsonGenerator.conditionalWidget(
                  condition: '{{loginForm.error != null}}',
                  then: MCPUIJsonGenerator.box(
                    padding: MCPUIJsonGenerator.edgeInsets(all: 12),
                    decoration: MCPUIJsonGenerator.decoration(
                      color: '#FFEBEE',
                      borderRadius: 4.0,
                      border: MCPUIJsonGenerator.border(color: '#F44336', width: 1),
                    ),
                    child: MCPUIJsonGenerator.text(
                      MCPUIJsonGenerator.binding('loginForm.error'),
                      style: MCPUIJsonGenerator.textStyle(color: '#D32F2F'),
                    ),
                  ),
                  orElse: MCPUIJsonGenerator.sizedBox(height: 0),
                ),
                MCPUIJsonGenerator.sizedBox(height: 16),
                
                // Email field
                MCPUIJsonGenerator.textInput(
                  label: 'Email',
                  placeholder: 'Enter your email address',
                  value: MCPUIJsonGenerator.binding('loginForm.email'),
                  change: MCPUIJsonGenerator.stateAction(
                    action: 'set',
                    path: 'loginForm.email',
                    value: '{{event.value}}',
                  ),
                ),
                MCPUIJsonGenerator.sizedBox(height: 16),
                
                // Password field
                MCPUIJsonGenerator.textInput(
                  label: 'Password',
                  placeholder: 'Enter your password',
                  value: MCPUIJsonGenerator.binding('loginForm.password'),
                  change: MCPUIJsonGenerator.stateAction(
                    action: 'set',
                    path: 'loginForm.password',
                    value: '{{event.value}}',
                  ),
                  obscureText: true,
                ),
                MCPUIJsonGenerator.sizedBox(height: 24),
                
                // Login button
                MCPUIJsonGenerator.button(
                  label: MCPUIJsonGenerator.conditional(
                    '{{loginForm.loading}}',
                    'Signing in...',
                    'Sign In',
                  ),
                  click: MCPUIJsonGenerator.toolAction(
                    'authenticateUser',
                    params: {
                      'email': '{{loginForm.email}}',
                      'password': '{{loginForm.password}}',
                    },
                  ),
                  disabled: false,
                  style: 'elevated',
                ),
                MCPUIJsonGenerator.sizedBox(height: 16),
                
                // Forgot password link
                MCPUIJsonGenerator.button(
                  label: 'Forgot Password?',
                  click: MCPUIJsonGenerator.navigationAction(action: 'push', route: '/forgot-password'),
                  style: 'text',
                ),
                MCPUIJsonGenerator.sizedBox(height: 8),
                
                // Signup link
                MCPUIJsonGenerator.linear(
                  direction: 'horizontal',
                  alignment: 'center',
                  children: [
                    MCPUIJsonGenerator.text(
                      "Don't have an account? ",
                      style: MCPUIJsonGenerator.textStyle(color: '#666666'),
                    ),
                    MCPUIJsonGenerator.button(
                      label: 'Sign Up',
                      click: MCPUIJsonGenerator.navigationAction(action: 'push', route: '/signup'),
                      style: 'text',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    state: {
      'initial': {
        'loginForm': {
          'email': '',
          'password': '',
          'loading': false,
          'error': null,
        },
      },
    },
    lifecycle: {
      'onInit': [
        MCPUIJsonGenerator.stateAction(
          action: 'set',
          path: 'loginForm.error',
          value: null,
        ),
      ],
    },
  );
  
  // Save the generated MCP UI form
  _saveAnalysisResult('mcp_login_form.json', mcpLoginForm);
  print('  ✓ MCP UI login form generated');
}

void _saveAnalysisResult(String filename, Map<String, dynamic> data) {
  final outputFile = File('example/analysis_results/$filename');
  outputFile.parent.createSync(recursive: true);
  
  final json = JsonEncoder.withIndent('  ').convert(data);
  outputFile.writeAsStringSync(json);
  
  print('    → Saved to: $filename');
}