import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'dart:convert';

void main() {
  print('Testing MCP UI Generator with Runtime Structure...\n');

  // Test 1: Simple text widget
  final text = MCPUIJsonGenerator.text(
    'Hello World',
    style: MCPUIJsonGenerator.textStyle(
      fontSize: 20,
      fontWeight: 'bold',
      color: '#2196F3',
    ),
  );
  print('Text widget:');
  print(jsonEncode(text));
  print('');

  // Test 2: Container with padding
  final container = MCPUIJsonGenerator.container(
    padding: MCPUIJsonGenerator.edgeInsets(all: 16),
    decoration: MCPUIJsonGenerator.decoration(
      color: '#F5F5F5',
      borderRadius: 8,
    ),
    child: MCPUIJsonGenerator.text('Content'),
  );
  print('Container widget:');
  print(jsonEncode(container));
  print('');

  // Test 3: Button with tool action
  final button = MCPUIJsonGenerator.button(
    label: 'Click Me',
    onTap: MCPUIJsonGenerator.toolAction(
      'myTool',
      args: {'param': 'value'},
    ),
  );
  print('Button widget:');
  print(jsonEncode(button));
  print('');

  // Test 4: Resource subscription action
  final resourceAction = MCPUIJsonGenerator.resourceAction(
    action: 'subscribe',
    uri: 'data://temperature',
    binding: 'temperature',
  );
  print('Resource action:');
  print(jsonEncode(resourceAction));
  print('');

  // Test 5: Complete page structure
  final page = MCPUIJsonGenerator.page(
    title: 'Test Page',
    content: MCPUIJsonGenerator.center(
      child: MCPUIJsonGenerator.column(
        children: [
          MCPUIJsonGenerator.text(
            'Welcome',
            style: MCPUIJsonGenerator.textStyle(fontSize: 24),
          ),
          MCPUIJsonGenerator.sizedBox(height: 20),
          MCPUIJsonGenerator.text('Counter: {{counter}}'),
          MCPUIJsonGenerator.button(
            label: 'Increment',
            onTap: MCPUIJsonGenerator.stateAction(
              action: 'increment',
              binding: 'counter',
            ),
          ),
        ],
      ),
    ),
    state: {
      'initial': {'counter': 0},
    },
  );
  print('Complete page:');
  print(MCPUIJsonGenerator.toPrettyJson(page));
}