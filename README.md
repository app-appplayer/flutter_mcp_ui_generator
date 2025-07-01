# Flutter MCP UI Generator

## 🙌 Support This Project

If you find this package useful, consider supporting ongoing development on PayPal.

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/ncp/payment/F7G56QD9LSJ92)  
Support makemind via [PayPal](https://www.paypal.com/ncp/payment/F7G56QD9LSJ92)

---

### 🔗 MCP Dart Package Family

- [`mcp_server`](https://pub.dev/packages/mcp_server): Exposes tools, resources, and prompts to LLMs. Acts as the AI server.
- [`mcp_client`](https://pub.dev/packages/mcp_client): Connects Flutter/Dart apps to MCP servers. Acts as the client interface.
- [`mcp_llm`](https://pub.dev/packages/mcp_llm): Bridges LLMs (Claude, OpenAI, etc.) to MCP clients/servers. Acts as the LLM brain.
- [`flutter_mcp`](https://pub.dev/packages/flutter_mcp): Complete Flutter plugin for MCP integration with platform features.
- [`flutter_mcp_ui_core`](https://pub.dev/packages/flutter_mcp_ui_core): Core models, constants, and utilities for Flutter MCP UI system. 
- [`flutter_mcp_ui_runtime`](https://pub.dev/packages/flutter_mcp_ui_runtime): Comprehensive runtime for building dynamic, reactive UIs through JSON specifications. 
- [`flutter_mcp_ui_generator`](https://pub.dev/packages/flutter_mcp_ui_generator): JSON generation toolkit for creating UI definitions with templates and fluent API. 

---

JSON generation tools for Flutter MCP UI Runtime. Create UI definitions programmatically with templates and fluent API. Based on the [MCP UI DSL v1.0 Specification](./doc/specification/MCP_UI_DSL_v1.0_Specification.md).

## Features

- 🏗️ **Widget Templates** - Pre-built templates for all 77+ supported widgets
- 🔧 **Fluent Builder API** - Programmatic UI construction with type-safe methods
- 📝 **JSON Generation** - Generate clean MCP UI JSON definitions
- 🎨 **Theme System** - Complete theme generation with light/dark mode support
- 📦 **Pre-built Patterns** - Common UI patterns (forms, dashboards, lists)
- 🚀 **Application Generator** - Create complete multi-page applications
- ✨ **Type-safe Properties** - Compile-time validation of widget properties

## Installation

```yaml
dependencies:
  flutter_mcp_ui_generator: ^0.2.1
```

## Quick Start

### Analyzing Existing Flutter Widgets

```dart
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

// Analyze a Flutter widget tree
void analyzeExistingApp() {
  print('Analyzing Flutter app structure...');
  
  // Simulate analyzing a typical Flutter login form
  final loginFormAnalysis = _analyzeFlutterWidget();
  
  // Convert the analysis to MCP UI DSL
  final mcpDefinition = _convertToMcpUi(loginFormAnalysis);
  
  // Export the results
  final json = MCPUIJsonGenerator.toPrettyJson(mcpDefinition);
  print('Converted MCP UI Definition:');
  print(json);
}

// Example: Analyze common Flutter patterns
Map<String, dynamic> _analyzeFlutterWidget() {
  return {
    'detected_widgets': [
      {'type': 'Scaffold', 'has_app_bar': true, 'has_body': true},
      {'type': 'AppBar', 'title': 'Login', 'has_actions': false},
      {'type': 'Column', 'children_count': 4, 'main_axis': 'center'},
      {'type': 'TextFormField', 'label': 'Email', 'has_validation': true},
      {'type': 'TextFormField', 'label': 'Password', 'obscure_text': true},
      {'type': 'ElevatedButton', 'label': 'Login', 'has_on_pressed': true},
    ],
    'layout_patterns': ['vertical_form', 'centered_content'],
    'state_usage': ['form_data', 'validation_errors', 'loading_state'],
  };
}

// Convert analyzed structure to MCP UI
Map<String, dynamic> _convertToMcpUi(Map<String, dynamic> analysis) {
  return {
    'type': 'page',
    'title': 'Login',
    'content': {
      'type': 'linear',
      'direction': 'vertical',
      'alignment': 'center',
      'padding': {'all': 20},
      'children': [
        {
          'type': 'textField',
          'label': 'Email',
          'value': '{{form.email}}',
          'change': {
            'type': 'state',
            'action': 'set',
            'binding': 'form.email',
            'value': '{{event.value}}'
          }
        },
        {'type': 'box', 'height': 16},
        {
          'type': 'textField',
          'label': 'Password',
          'value': '{{form.password}}',
          'obscureText': true,
          'change': {
            'type': 'state',
            'action': 'set',
            'binding': 'form.password',
            'value': '{{event.value}}'
          }
        },
        {'type': 'box', 'height': 24},
        {
          'type': 'button',
          'label': 'Login',
          'variant': 'elevated',
          'click': {
            'type': 'tool',
            'tool': 'authenticate',
            'params': {
              'email': '{{form.email}}',
              'password': '{{form.password}}'
            }
          }
        }
      ]
    },
    'state': {
      'initial': {
        'form': {'email': '', 'password': ''}
      }
    }
  };
}
```

### Batch Analysis of Flutter Projects

```dart
void analyzeFlutterProject() {
  print('=== Flutter Project Analysis ===');
  
  // 1. Analyze layout patterns
  final layoutPatterns = analyzeLayoutPatterns();
  print('Found layout patterns: ${layoutPatterns.length}');
  
  // 2. Analyze form structures
  final formPatterns = analyzeFormPatterns();
  print('Found form patterns: ${formPatterns.length}');
  
  // 3. Analyze navigation flows
  final navigationPatterns = analyzeNavigationPatterns();
  print('Found navigation patterns: ${navigationPatterns.length}');
  
  // 4. Convert all patterns to MCP UI
  final mcpComponents = convertPatternsToMcpUi([
    ...layoutPatterns,
    ...formPatterns,
    ...navigationPatterns,
  ]);
  
  // 5. Generate complete MCP UI application
  final mcpApp = generateMcpUiApplication(mcpComponents);
  
  // 6. Export results
  saveAnalysisResults('flutter_to_mcp_analysis.json', {
    'original_patterns': {
      'layouts': layoutPatterns,
      'forms': formPatterns,
      'navigation': navigationPatterns,
    },
    'mcp_ui_app': mcpApp,
    'conversion_summary': {
      'total_widgets_analyzed': layoutPatterns.length + formPatterns.length + navigationPatterns.length,
      'mcp_components_generated': mcpComponents.length,
      'migration_recommendations': generateMigrationRecommendations(mcpComponents),
    },
  });
}

// Helper functions for pattern analysis
List<Map<String, dynamic>> analyzeLayoutPatterns() {
  return [
    {
      'pattern': 'Column with Padding',
      'frequency': 'high',
      'flutter_code': 'Column(children: [Padding(...), Text(...)])',
      'mcp_equivalent': 'linear(direction: vertical, children: [padding(...), label(...)])',
    },
    {
      'pattern': 'Row with Expanded',
      'frequency': 'medium',
      'flutter_code': 'Row(children: [Expanded(child: Text(...)), Icon(...)])',
      'mcp_equivalent': 'linear(direction: horizontal, children: [expanded(...), icon(...)])',
    },
  ];
}

List<Map<String, dynamic>> analyzeFormPatterns() {
  return [
    {
      'pattern': 'TextFormField with Validation',
      'frequency': 'very_high',
      'flutter_code': 'TextFormField(validator: (value) => ...)',
      'mcp_equivalent': 'textInput(label: ..., change: stateAction(...))',
    },
  ];
}
```

### Theme Extraction and Conversion

```dart
// Extract theme from existing Flutter app
Map<String, dynamic> extractFlutterTheme() {
  return {
    'theme_analysis': {
      'primary_color': '#2196F3',
      'accent_color': '#FF5722',
      'text_styles': {
        'headline1': {'fontSize': 32, 'fontWeight': 'bold'},
        'bodyText1': {'fontSize': 16, 'color': '#333333'},
      },
      'usage_patterns': {
        'primary_color_usage': ['AppBar', 'FloatingActionButton', 'ElevatedButton'],
        'text_style_usage': ['Text widgets', 'AppBar titles', 'Form labels'],
      },
    },
  };
}

// Convert to MCP UI theme
Map<String, dynamic> convertToMcpTheme(Map<String, dynamic> flutterTheme) {
  return MCPUIJsonGenerator.application(
    title: 'Converted App',
    version: '1.0.0',
    theme: {
      'colors': {
        'primary': flutterTheme['theme_analysis']['primary_color'],
        'secondary': flutterTheme['theme_analysis']['accent_color'],
      },
      'typography': flutterTheme['theme_analysis']['text_styles'],
    },
    routes: {'/': {'uri': 'ui://pages/home'}},
  );
}

// Use theme bindings in widgets
final themedText = MCPUIJsonGenerator.text(
  'Hello World',
  style: MCPUIJsonGenerator.textStyle(
    color: MCPUIJsonGenerator.themeColor('primary'),
    fontSize: 24,
  ),
);

// Dark/Light mode support
final dualTheme = MCPUIJsonGenerator.theme(
  mode: MCPUIJsonGenerator.binding('app.themeMode'),
  light: {'colors': {'background': '#FFFFFF'}},
  dark: {'colors': {'background': '#121212'}},
);
```

## Widget Templates

Access templates for all 77+ supported widgets:

```dart
// Get all widget categories
final categories = WidgetTemplates.categories;
// {layout: [...], display: [...], input: [...], ...}

// Get specific template
final containerTemplate = WidgetTemplates.getTemplate('container');

// Use template with customization
final customContainer = MCPUIJsonGenerator.fromTemplate('container',
  properties: {
    'padding': {'all': 20},
    'color': '#E3F2FD',
  },
  children: [/* ... */],
);
```

## Builder API Reference

### Basic Structure

```dart
MCPUIBuilder()
  .widget('type')           // Start with widget type
  .properties({...})        // Add properties
  .children()              // Start children
    .child('type')         // Add child widget
    .end()                 // End child
  .end()                   // End parent
  .build();                // Get final JSON
```

### Common Methods

- **Layout**: `linear()`, `box()`, `padding()`, `center()`, `conditionalWidget()`, `scrollView()`
- **Display**: `label()`, `icon()`, `image()`, `card()`
- **Input**: `textField()`, `button()`, `checkbox()`, `slider()`, `numberField()`, `colorPicker()`, `radioGroup()`, `checkboxGroup()`, `segmentedControl()`
- **Date/Time**: `dateField()`, `timeField()`, `dateRangePicker()`
- **Drag & Drop**: `draggable()`, `dragTarget()`
- **Properties**: `width()`, `height()`, `color()`, `margin()`, `elevation()`
- **Actions**: `click()`, `clickTool()`, `clickState()`, `bindTo()`

### Extensions

```dart
builder
  .list(
    items: '{{products}}',
    itemTemplate: {...},
  )
  .appBar('My App', backgroundColor: '#2196F3')
  .textFormField(
    label: 'Email',
    bindTo: 'email',
    validator: 'email',
  );
```

## Complete Example

```dart
void main() {
  // Build a complete form using the builder
  final formUI = MCPUIBuilder()
    .linear()
    .property('direction', 'vertical')
    .children()
      .appBar('User Registration')
      .end()
      .expanded()
      .children()
        .child('singlechildscrollview')
        .children()
          .padding(all: 16)
          .children()
            .form()
            .children()
              .textFormField(
                label: 'Full Name',
                bindTo: 'form.name',
                validator: 'required',
              )
              .end()
              .sizedBox(height: 16)
              .end()
              .textFormField(
                label: 'Email',
                bindTo: 'form.email',
                validator: 'email',
              )
              .end()
              .sizedBox(height: 16)
              .end()
              .slider(
                bindTo: 'form.age',
                min: 18,
                max: 100,
              )
              .end()
              .sizedBox(height: 16)
              .end()
              .checkbox(
                bindTo: 'form.terms',
                label: 'I agree to terms',
              )
              .end()
              .sizedBox(height: 24)
              .end()
              .button('Submit')
              .clickTool('submitForm', {'data': '{{form}}'})
              .end()
            .end()
          .end()
        .end()
      .end()
    .end()
    .build();
  
  // Save to file
  final json = const JsonEncoder.withIndent('  ').convert(formUI);
  File('registration_form.json').writeAsStringSync(json);
}
```

## Pattern Library

### Available Patterns

- **Forms**: `loginForm()`, `registrationForm()`
- **Layouts**: `dashboard()`, `settingsPage()`
- **Components**: `statCard()`, `emptyState()`, `searchableList()`
- **Items**: `settingsItem()`

### Custom Patterns

```dart
// Create your own reusable patterns
Map<String, dynamic> myCustomPattern({
  required String title,
  required List<String> items,
}) {
  return MCPUIJsonGenerator.linear(
    direction: 'vertical',
    children: [
      MCPUIJsonGenerator.label(title, fontSize: 20),
      ...items.map((item) => MCPUIJsonGenerator.widget('listtile',
        properties: {'title': item},
      )),
    ],
  );
}
```

## Best Practices

1. **Use Templates**: Start with widget templates for correct structure
2. **Leverage Patterns**: Use pre-built patterns for common UI layouts
3. **Type Safety**: Use the builder API to avoid JSON structure errors
4. **Modular**: Break complex UIs into smaller, reusable functions
5. **State Planning**: Define your initial state structure upfront

## Documentation

- [MCP UI DSL v1.0 Specification](./doc/specification/MCP_UI_DSL_v1.0_Specification.md) - Complete specification for Model Context Protocol UI Definition Language
- [API Reference](./doc/api/) - Detailed API documentation
- [Architecture Overview](./doc/architecture/overview.md) - System architecture and design
- [Getting Started Guide](./doc/guides/getting-started.md) - Quick start guide
- [Examples](./doc/examples/) - Sample implementations
- [Widget Reference](./doc/api/widget-reference.md) - Complete widget property reference

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.