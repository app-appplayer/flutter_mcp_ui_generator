# Flutter MCP UI Generator

## 🙌 Support This Project

If you find this package useful, consider supporting ongoing development on Patreon.

[![Support on Patreon](https://c5.patreon.com/external/logo/become_a_patron_button.png)](https://www.patreon.com/mcpdevstudio)

### 🔗 MCP Dart Package Family

- [`mcp_server`](https://pub.dev/packages/mcp_server): Exposes tools, resources, and prompts to LLMs. Acts as the AI server.
- [`mcp_client`](https://pub.dev/packages/mcp_client): Connects Flutter/Dart apps to MCP servers. Acts as the client interface.
- [`mcp_llm`](https://pub.dev/packages/mcp_llm): Bridges LLMs (Claude, OpenAI, etc.) to MCP clients/servers. Acts as the LLM brain.
- [`flutter_mcp`](https://pub.dev/packages/flutter_mcp): Complete Flutter plugin for MCP integration with platform features.
- [`flutter_mcp_ui_core`](https://pub.dev/packages/flutter_mcp_ui_core): Core models, constants, and utilities for Flutter MCP UI system. 
- [`flutter_mcp_ui_runtime`](https://pub.dev/packages/flutter_mcp_ui_runtime): Comprehensive runtime for building dynamic, reactive UIs through JSON specifications. 
- [`flutter_mcp_ui_generator`](https://pub.dev/packages/flutter_mcp_ui_generator): JSON generation toolkit for creating UI definitions with templates and fluent API. 

---

JSON generation toolkit for creating UI definitions compatible with Flutter MCP UI Runtime. Based on the [MCP UI DSL v1.0 Specification](./doc/specification/MCP_UI_DSL_v1.0_Specification.md).

## Features

- 📝 **Widget Templates** - Pre-configured templates for all 77+ supported widgets
- 🔨 **Fluent Builder API** - Chainable API for programmatic UI construction  
- 🎨 **UI Patterns** - Common patterns like forms, dashboards, lists
- 🎭 **Theme System** - Complete theme support with light/dark modes and binding expressions
- 📄 **JSON Generation** - Export to formatted JSON files
- 🎯 **Type-safe** - Avoid common JSON structure mistakes
- 🆕 **New Widgets** - Support for advanced input, date/time, conditional, scrolling, and drag & drop widgets

## Installation

```yaml
dependencies:
  flutter_mcp_ui_generator: ^0.1.0
```

## Quick Start

### Using Widget Templates

```dart
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

// Create from template
final button = MCPUIJsonGenerator.fromTemplate('button', 
  properties: {
    'label': 'Click Me',
    'variant': 'elevated',
    'onTap': MCPUIJsonGenerator.toolAction('handleClick'),
  },
);

// Quick builders
final text = MCPUIJsonGenerator.text('Hello World', 
  fontSize: 24, 
  fontWeight: 'bold'
);

// Generate complete UI
final ui = MCPUIJsonGenerator.createUIDefinition(
  layout: MCPUIJsonGenerator.column(children: [
    text,
    MCPUIJsonGenerator.widget('sizedbox', properties: {'height': 20}),
    button,
  ]),
  initialState: {'clicks': 0},
);

// Save to file
MCPUIJsonGenerator.generateJsonFile(ui, 'my_ui.json');
```

### Using Fluent Builder

```dart
final ui = MCPUIBuilder()
  .column()
  .properties({'padding': {'all': 16}})
  .children()
    .text('Welcome')
    .fontSize(28)
    .fontWeight('bold')
    .end()
    .sizedBox(height: 20)
    .end()
    .textField('Username')
    .bindTo('username')
    .end()
    .sizedBox(height: 16)
    .end()
    .button('Login')
    .onTapTool('login', {'username': '{{username}}'})
    .end()
  .end()
  .build();

// Convert to JSON string
print(MCPUIBuilder.toJson(ui));
```

### Using Theme System

```dart
// Create a complete theme
final myTheme = MCPUIJsonGenerator.theme(
  mode: 'light',
  colors: MCPUIJsonGenerator.themeColors(
    primary: '#4CAF50',
    secondary: '#FF9800',
  ),
  typography: MCPUIJsonGenerator.themeTypography(
    h1: {'fontSize': 36, 'fontWeight': 'bold'},
  ),
  spacing: MCPUIJsonGenerator.themeSpacing(md: 20),
);

// Use theme in application
final app = MCPUIJsonGenerator.application(
  title: 'Themed App',
  version: '1.0.0',
  theme: myTheme,
  routes: {'/home': {'uri': 'ui://pages/home'}},
);

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

- **Layout**: `column()`, `row()`, `container()`, `padding()`, `center()`, `conditionalWidget()`, `scrollView()`
- **Display**: `text()`, `icon()`, `image()`, `card()`
- **Input**: `textField()`, `button()`, `checkbox()`, `slider()`, `numberField()`, `colorPicker()`, `radioGroup()`, `checkboxGroup()`, `segmentedControl()`
- **Date/Time**: `dateField()`, `timeField()`, `dateRangePicker()`
- **Drag & Drop**: `draggable()`, `dragTarget()`
- **Properties**: `width()`, `height()`, `color()`, `margin()`, `elevation()`
- **Actions**: `onTap()`, `onTapTool()`, `onTapState()`, `bindTo()`

### Extensions

```dart
builder
  .listView(
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
    .column()
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
              .onTapTool('submitForm', {'data': '{{form}}'})
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
  return MCPUIJsonGenerator.column(
    children: [
      MCPUIJsonGenerator.text(title, fontSize: 20),
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