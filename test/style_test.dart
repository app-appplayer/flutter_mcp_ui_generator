import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  group('Styles', () {
    test('textStyle', () {
      final style = MCPUIJsonGenerator.textStyle(
        fontSize: 16.0,
        fontWeight: 'bold',
        color: '#ff0000',
      );

      expect(style['fontSize'], equals(16.0));
      expect(style['fontWeight'], equals('bold'));
      expect(style['color'], equals('#ff0000'));
    });

    test('edgeInsets all', () {
      final padding = MCPUIJsonGenerator.edgeInsets(all: 16);
      expect(padding, equals({'all': 16}));
    });

    test('edgeInsets symmetric', () {
      final padding = MCPUIJsonGenerator.edgeInsets(
        horizontal: 20,
        vertical: 10,
      );
      expect(padding['horizontal'], equals(20));
      expect(padding['vertical'], equals(10));
    });

    test('edgeInsets individual', () {
      final padding = MCPUIJsonGenerator.edgeInsets(
        left: 10,
        top: 20,
        right: 30,
        bottom: 40,
      );
      expect(padding['left'], equals(10));
      expect(padding['top'], equals(20));
      expect(padding['right'], equals(30));
      expect(padding['bottom'], equals(40));
    });

    test('decoration', () {
      final decoration = MCPUIJsonGenerator.decoration(
        color: '#ffffff',
        borderRadius: 8.0,
        border: MCPUIJsonGenerator.border(
          color: '#000000',
          width: 2.0,
        ),
      );

      expect(decoration['color'], equals('#ffffff'));
      expect(decoration['borderRadius'], equals(8.0));
      expect(decoration['border'], isA<Map>());
    });

    test('border', () {
      final border = MCPUIJsonGenerator.border(
        color: '#000000',
        width: 2.0,
        style: 'solid',
      );

      expect(border['color'], equals('#000000'));
      expect(border['width'], equals(2.0));
      expect(border['style'], equals('solid'));
    });
  });
}
