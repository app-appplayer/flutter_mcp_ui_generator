# Flutter MCP UI Generator Examples

This folder contains various usage examples of Flutter MCP UI Generator.

## 📁 Example Structure

### 1. Basic Widgets Examples
- `01_basic_widgets/` - Demo of all basic widget usage
  - `widgets_showcase.dart` - Layout, display, and input widgets showcase
  - `styling_examples.dart` - Text styles, decorations, and theme examples

### 2. Forms & Input Examples
- `02_forms_input/` - Form composition and input widget utilization
  - `login_form.dart` - Login form example
  - `user_profile_form.dart` - User profile edit form
  - `dynamic_form.dart` - Dynamic form creation example

### 3. Navigation Examples
- `03_navigation/` - Page routing and navigation
  - `multi_page_app.dart` - Multi-page app structure
  - `bottom_navigation.dart` - Bottom navigation example
  - `drawer_navigation.dart` - Drawer navigation example

### 4. State Management Examples
- `04_state_management/` - State management and data binding
  - `counter_app.dart` - Simple counter app
  - `todo_list.dart` - Todo list app
  - `shopping_cart.dart` - Shopping cart state management

### 5. Real-world Application Examples
- `05_real_world/` - Real usage scenarios
  - `weather_app/` - Weather app example
  - `e_commerce/` - E-commerce app example
  - `dashboard/` - Dashboard UI example

### 6. Integration Examples
- `06_integration/` - MCP server integration
  - `mcp_server_demo.dart` - MCP server connection demo
  - `tool_integration.dart` - Tool call example
  - `resource_subscription.dart` - Resource subscription example

## 🚀 How to Run Examples

Each example consists of independently executable Dart files:

```bash
# Run JSON generation example
dart run example/01_basic_widgets/widgets_showcase.dart

# Check generated JSON file
cat widgets_showcase.json
```

## 📝 Example Usage Tips

1. **Learning Order**: It is recommended to learn sequentially starting from 01
2. **JSON Output**: Each example generates corresponding JSON files
3. **Code Modification**: Experiment with various options by modifying the example code
4. **Practical Application**: Test the generated JSON in MCP UI Runtime

## 🔧 Developer Guide

When adding new examples:
1. Place in appropriate category folder
2. Add clear comments and explanations
3. Match JSON output filename with example name
4. Update README.md

## 📚 Additional Resources

- [MCP UI DSL v1.0 Specification](https://github.com/modelcontextprotocol/typescript-sdk)
- [Flutter MCP UI Runtime](https://github.com/flutter-mcp-ui/runtime)
- [MCP Server Development Guide](https://docs.anthropic.com/mcp)