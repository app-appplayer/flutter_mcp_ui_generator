import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'dart:io';
import 'dart:convert';

/// Widget Analysis Showcase
/// 
/// This example demonstrates analyzing existing Flutter widgets and converting them to MCP UI DSL.
/// It shows how to analyze layout, display, input, list, and navigation widget patterns.
void main() {
  print('=== Flutter MCP UI Analysis Tool - Widget Analysis Showcase ===\n');

  // 1. Analyze layout widget patterns
  print('1. Analyzing Layout Widget Patterns');
  _analyzeLayoutPatterns();
  
  // 2. Analyze display widget patterns
  print('\n2. Analyzing Display Widget Patterns');
  _analyzeDisplayPatterns();
  
  // 3. Analyze input widget patterns
  print('\n3. Analyzing Input Widget Patterns');
  _analyzeInputPatterns();
  
  // 4. Analyze list widget patterns
  print('\n4. Analyzing List Widget Patterns');
  _analyzeListPatterns();
  
  // 5. Analyze navigation widget patterns
  print('\n5. Analyzing Navigation Widget Patterns');
  _analyzeNavigationPatterns();
  
  // 6. Complete app analysis example
  print('\n6. Complete App Analysis Example');
  _analyzeCompleteApp();
  
  print('\n=== All analysis examples completed! ===');
  print('Check the analysis results:');
  print('- layout_patterns_analysis.json');
  print('- display_patterns_analysis.json');
  print('- input_patterns_analysis.json');
  print('- list_patterns_analysis.json');
  print('- navigation_patterns_analysis.json');
  print('- complete_app_analysis.json');
}

/// Analyze layout patterns in existing Flutter code
void _analyzeLayoutPatterns() {
  print('  Analyzing common Flutter layout patterns...');
  
  // Simulate analyzing different layout patterns
  final layoutAnalysis = {
    'analyzed_patterns': [
      {
        'pattern_type': 'container_with_child',
        'flutter_code': 'Container(width: 200, height: 100, child: Text("Hello"))',
        'frequency': 'high',
        'usage_context': 'card layouts, buttons, containers'
      },
      {
        'pattern_type': 'column_with_spacing',
        'flutter_code': 'Column(children: [Text("A"), SizedBox(height: 8), Text("B")])',
        'frequency': 'very_high',
        'usage_context': 'forms, lists, vertical layouts'
      },
      {
        'pattern_type': 'row_with_flex',
        'flutter_code': 'Row(children: [Expanded(child: Text("A")), Text("B")])',
        'frequency': 'high',
        'usage_context': 'headers, toolbars, horizontal layouts'
      }
    ]
  };
  
  // Convert patterns to MCP UI DSL
  final mcpLayouts = _convertLayoutPatternsToMcp(layoutAnalysis);
  
  // Save analysis results
  _saveAnalysisResult('layout_patterns_analysis.json', {
    'original_analysis': layoutAnalysis,
    'mcp_ui_conversion': mcpLayouts,
    'conversion_notes': 'Container → box, Column → linear(vertical), Row → linear(horizontal)'
  });
  
  print('  ✓ Layout patterns analyzed and converted');
}

/// Analyze display widget patterns
void _analyzeDisplayPatterns() {
  print('  Analyzing display widget patterns...');
  
  final displayAnalysis = {
    'analyzed_patterns': [
      {
        'pattern_type': 'styled_text',
        'flutter_code': 'Text("Hello", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))',
        'frequency': 'very_high',
        'style_properties': ['fontSize', 'fontWeight', 'color']
      },
      {
        'pattern_type': 'network_image',
        'flutter_code': 'Image.network("https://example.com/image.png")',
        'frequency': 'high',
        'common_properties': ['url', 'fit', 'placeholder']
      },
      {
        'pattern_type': 'icon_with_size',
        'flutter_code': 'Icon(Icons.home, size: 24, color: Colors.blue)',
        'frequency': 'high',
        'common_properties': ['icon', 'size', 'color']
      }
    ]
  };
  
  final mcpDisplays = _convertDisplayPatternsToMcp(displayAnalysis);
  
  _saveAnalysisResult('display_patterns_analysis.json', {
    'original_analysis': displayAnalysis,
    'mcp_ui_conversion': mcpDisplays,
    'conversion_notes': 'Text → text with style, Image → image, Icon → icon'
  });
  
  print('  ✓ Display patterns analyzed and converted');
}

/// Analyze input widget patterns
void _analyzeInputPatterns() {
  print('  Analyzing input widget patterns...');
  
  final inputAnalysis = {
    'analyzed_patterns': [
      {
        'pattern_type': 'text_form_field',
        'flutter_code': 'TextFormField(decoration: InputDecoration(labelText: "Name"))',
        'frequency': 'very_high',
        'common_properties': ['labelText', 'hintText', 'validator']
      },
      {
        'pattern_type': 'elevated_button',
        'flutter_code': 'ElevatedButton(onPressed: () {}, child: Text("Submit"))',
        'frequency': 'very_high',
        'event_properties': ['onPressed', 'onLongPress']
      },
      {
        'pattern_type': 'checkbox_with_state',
        'flutter_code': 'Checkbox(value: isChecked, onChanged: (value) => setState(...))',
        'frequency': 'medium',
        'state_properties': ['value', 'onChanged']
      }
    ]
  };
  
  final mcpInputs = _convertInputPatternsToMcp(inputAnalysis);
  
  _saveAnalysisResult('input_patterns_analysis.json', {
    'original_analysis': inputAnalysis,
    'mcp_ui_conversion': mcpInputs,
    'conversion_notes': 'TextFormField → textInput, ElevatedButton → button, Checkbox → checkbox'
  });
  
  print('  ✓ Input patterns analyzed and converted');
}

/// Analyze list widget patterns  
void _analyzeListPatterns() {
  print('  Analyzing list widget patterns...');
  
  final listAnalysis = {
    'analyzed_patterns': [
      {
        'pattern_type': 'listview_builder',
        'flutter_code': 'ListView.builder(itemCount: items.length, itemBuilder: (context, index) => ListTile(...))',
        'frequency': 'very_high',
        'data_binding': 'dynamic item list'
      },
      {
        'pattern_type': 'gridview_count',
        'flutter_code': 'GridView.count(crossAxisCount: 2, children: widgets)',
        'frequency': 'medium',
        'layout_properties': ['crossAxisCount', 'childAspectRatio']
      }
    ]
  };
  
  final mcpLists = _convertListPatternsToMcp(listAnalysis);
  
  _saveAnalysisResult('list_patterns_analysis.json', {
    'original_analysis': listAnalysis,
    'mcp_ui_conversion': mcpLists,
    'conversion_notes': 'ListView → list with items binding, GridView → grid'
  });
  
  print('  ✓ List patterns analyzed and converted');
}

/// Analyze navigation widget patterns
void _analyzeNavigationPatterns() {
  print('  Analyzing navigation widget patterns...');
  
  final navAnalysis = {
    'analyzed_patterns': [
      {
        'pattern_type': 'app_bar_with_actions',
        'flutter_code': 'AppBar(title: Text("Home"), actions: [IconButton(...)])',
        'frequency': 'very_high',
        'common_elements': ['title', 'actions', 'leading']
      },
      {
        'pattern_type': 'bottom_navigation',
        'flutter_code': 'BottomNavigationBar(items: [...], onTap: (index) => ...)',
        'frequency': 'high',
        'navigation_properties': ['items', 'currentIndex', 'onTap']
      }
    ]
  };
  
  final mcpNavigation = _convertNavigationPatternsToMcp(navAnalysis);
  
  _saveAnalysisResult('navigation_patterns_analysis.json', {
    'original_analysis': navAnalysis,
    'mcp_ui_conversion': mcpNavigation,
    'conversion_notes': 'AppBar → headerBar, BottomNavigationBar → bottomNavigation'
  });
  
  print('  ✓ Navigation patterns analyzed and converted');
}

/// Analyze complete app structure
void _analyzeCompleteApp() {
  print('  Analyzing complete Flutter app structure...');
  
  final appAnalysis = {
    'app_structure': {
      'main_widget': 'MaterialApp',
      'home_page': 'Scaffold with AppBar and body',
      'navigation': 'BottomNavigationBar with 3 tabs',
      'state_management': 'StatefulWidget with setState'
    },
    'page_breakdown': {
      'home_page': ['AppBar', 'ListView', 'FloatingActionButton'],
      'profile_page': ['AppBar', 'Column with form fields', 'Save button'],
      'settings_page': ['AppBar', 'List of settings items', 'Switch widgets']
    }
  };
  
  // Convert to complete MCP UI application
  final mcpApp = _convertCompleteAppToMcp(appAnalysis);
  
  _saveAnalysisResult('complete_app_analysis.json', {
    'original_analysis': appAnalysis,
    'mcp_ui_application': mcpApp,
    'migration_strategy': 'Convert MaterialApp to application, Scaffold pages to page components'
  });
  
  print('  ✓ Complete app structure analyzed and converted');
}

/// Helper functions for conversion

Map<String, dynamic> _convertLayoutPatternsToMcp(Map<String, dynamic> analysis) {
  return {
    'box_pattern': MCPUIJsonGenerator.box(
      width: 200.0,
      height: 100.0,
      child: MCPUIJsonGenerator.text('Hello'),
    ),
    'linear_column_pattern': MCPUIJsonGenerator.linear(
      direction: 'vertical',
      children: [
        MCPUIJsonGenerator.text('A'),
        MCPUIJsonGenerator.sizedBox(height: 8),
        MCPUIJsonGenerator.text('B'),
      ],
    ),
    'linear_row_pattern': MCPUIJsonGenerator.linear(
      direction: 'horizontal',
      children: [
        MCPUIJsonGenerator.expanded(
          child: MCPUIJsonGenerator.text('A'),
        ),
        MCPUIJsonGenerator.text('B'),
      ],
    ),
  };
}

Map<String, dynamic> _convertDisplayPatternsToMcp(Map<String, dynamic> analysis) {
  return {
    'styled_text_pattern': MCPUIJsonGenerator.text(
      'Hello',
      style: MCPUIJsonGenerator.textStyle(
        fontSize: 18.0,
        fontWeight: 'bold',
      ),
    ),
    'image_pattern': MCPUIJsonGenerator.image(
      src: 'https://example.com/image.png',
      fit: 'cover',
    ),
    'icon_pattern': MCPUIJsonGenerator.icon(
      icon: 'home',
      size: 24.0,
      color: '#2196F3',
    ),
  };
}

Map<String, dynamic> _convertInputPatternsToMcp(Map<String, dynamic> analysis) {
  return {
    'text_input_pattern': MCPUIJsonGenerator.textInput(
      label: 'Name',
      value: MCPUIJsonGenerator.binding('user.name'),
      change: MCPUIJsonGenerator.stateAction(
        action: 'set',
        path: 'user.name',
        value: '{{event.value}}',
      ),
    ),
    'button_pattern': MCPUIJsonGenerator.button(
      label: 'Submit',
      click: MCPUIJsonGenerator.toolAction('submit', params: {}),
    ),
    'checkbox_pattern': MCPUIJsonGenerator.checkbox(
      label: 'Agree to terms',
      value: MCPUIJsonGenerator.binding('form.agreed'),
      change: MCPUIJsonGenerator.stateAction(
        action: 'set',
        path: 'form.agreed',
        value: '{{event.value}}',
      ),
    ),
  };
}

Map<String, dynamic> _convertListPatternsToMcp(Map<String, dynamic> analysis) {
  return {
    'list_pattern': MCPUIJsonGenerator.list(
      items: MCPUIJsonGenerator.binding('items'),
      template: MCPUIJsonGenerator.listTile(
        title: MCPUIJsonGenerator.binding('item.title'),
        subtitle: MCPUIJsonGenerator.binding('item.subtitle'),
      ),
    ),
    'grid_pattern': MCPUIJsonGenerator.grid(
      items: MCPUIJsonGenerator.binding('products'),
      crossAxisCount: 2,
      template: MCPUIJsonGenerator.card(
        child: MCPUIJsonGenerator.text(MCPUIJsonGenerator.binding('item.name')),
      ),
    ),
  };
}

Map<String, dynamic> _convertNavigationPatternsToMcp(Map<String, dynamic> analysis) {
  return {
    'header_bar_pattern': MCPUIJsonGenerator.headerBar(
      title: 'Home',
      actions: [
        MCPUIJsonGenerator.button(
          label: 'Action',
          click: MCPUIJsonGenerator.toolAction('headerAction', params: {}),
        ),
      ],
    ),
    'bottom_navigation_pattern': MCPUIJsonGenerator.bottomNavigation(
      items: [
        {'label': 'Home', 'icon': 'home'},
        {'label': 'Profile', 'icon': 'person'},
        {'label': 'Settings', 'icon': 'settings'},
      ],
      currentIndex: 0,
      click: MCPUIJsonGenerator.stateAction(
        action: 'set',
        path: 'navigation.currentIndex',
        value: '{{event.index}}',
      ),
    ),
  };
}

Map<String, dynamic> _convertCompleteAppToMcp(Map<String, dynamic> analysis) {
  return MCPUIJsonGenerator.application(
    title: 'Analyzed Flutter App',
    version: '1.0.0',
    routes: {
      '/': {'uri': 'ui://pages/home'},
      '/profile': {'uri': 'ui://pages/profile'},
      '/settings': {'uri': 'ui://pages/settings'},
    },
    initialRoute: '/',
    navigation: {
      'type': 'bottomNavigation',
      'items': [
        {'label': 'Home', 'icon': 'home', 'route': '/'},
        {'label': 'Profile', 'icon': 'person', 'route': '/profile'},
        {'label': 'Settings', 'icon': 'settings', 'route': '/settings'},
      ],
    },
    state: {
      'initial': {
        'navigation': {'currentIndex': 0},
        'user': {'name': '', 'email': ''},
        'settings': {'darkMode': false},
      },
    },
  );
}

void _saveAnalysisResult(String filename, Map<String, dynamic> data) {
  final outputFile = File('example/analysis_results/$filename');
  outputFile.parent.createSync(recursive: true);
  
  final json = JsonEncoder.withIndent('  ').convert(data);
  outputFile.writeAsStringSync(json);
  
  print('    → Saved to: $filename');
}