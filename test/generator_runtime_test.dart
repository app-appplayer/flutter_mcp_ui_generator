import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'dart:convert';

void main() {
  group('MCP UI Generator Runtime Structure', () {
    test('generates valid text widget with style', () {
      final text = MCPUIJsonGenerator.text(
        'Hello World',
        style: MCPUIJsonGenerator.textStyle(
          fontSize: 20,
          fontWeight: 'bold',
          color: '#2196F3',
        ),
      );

      expect(text['type'], equals('text'));
      expect(text['content'], equals('Hello World'));
      expect(text['style'], isA<Map>());
      expect(text['style']['fontSize'], equals(20));
    });

    test('generates valid box widget with decoration', () {
      final box = MCPUIJsonGenerator.box(
        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
        decoration: MCPUIJsonGenerator.decoration(
          color: '#F5F5F5',
          borderRadius: 8,
        ),
        child: MCPUIJsonGenerator.text('Content'),
      );

      expect(box['type'], equals('box'));
      expect(box['padding'], isA<Map>());
      expect(box['decoration'], isA<Map>());
      expect(box['child'], isA<Map>());
    });

    test('generates valid button with tool action', () {
      final button = MCPUIJsonGenerator.button(
        label: 'Click Me',
        click: MCPUIJsonGenerator.toolAction(
          'myTool',
          params: {'param': 'value'},
        ),
      );

      expect(button['type'], equals('button'));
      expect(button['label'], equals('Click Me'));
      expect(button['onTap'], isA<Map>());
      expect(button['onTap']['type'], equals('tool'));
      expect(button['onTap']['tool'], equals('myTool'));
    });

    test('generates valid resource action', () {
      final resourceAction = MCPUIJsonGenerator.resourceAction(
        uri: 'data://temperature',
        binding: 'temperature',
      );

      expect(resourceAction['type'], equals('resource'));
      expect(resourceAction['uri'], equals('data://temperature'));
      expect(resourceAction['binding'], equals('temperature'));
    });

    test('generates valid complete page structure', () {
      final page = MCPUIJsonGenerator.page(
        title: 'Test Page',
        content: MCPUIJsonGenerator.center(
          child: MCPUIJsonGenerator.linear(
            direction: 'vertical',
            children: [
              MCPUIJsonGenerator.text(
                'Welcome',
                style: MCPUIJsonGenerator.textStyle(fontSize: 24),
              ),
              MCPUIJsonGenerator.sizedBox(height: 20),
              MCPUIJsonGenerator.text('Counter: {{counter}}'),
              MCPUIJsonGenerator.button(
                label: 'Increment',
                click: MCPUIJsonGenerator.stateAction(
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

      expect(page['type'], equals('page'));
      expect(page['title'], equals('Test Page'));
      expect(page['content'], isA<Map>());
      expect(page['state'], isA<Map>());

      // Verify JSON serialization works
      final json = MCPUIJsonGenerator.toPrettyJson(page);
      expect(json, isNotEmpty);
      final decoded = jsonDecode(json);
      expect(decoded['type'], equals('page'));
    });
  });
}
