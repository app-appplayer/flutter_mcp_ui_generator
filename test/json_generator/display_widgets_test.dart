import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-068: MCPUIJsonGenerator.text
  group('TC-068: MCPUIJsonGenerator.text', () {
    test('Normal: produces text widget', () {
      final w = MCPUIJsonGenerator.text('Hello');

      expect(w['type'], equals('text'));
      expect(w['content'], equals('Hello'));
    });

    test('Normal: with style and optional params', () {
      final w = MCPUIJsonGenerator.text(
        'Hello',
        style: MCPUIJsonGenerator.textStyle(fontSize: 16),
        maxLines: 2,
        overflow: 'ellipsis',
        textAlign: 'center',
      );

      expect(w['style'], isA<Map>());
      expect(w['maxLines'], equals(2));
      expect(w['overflow'], equals('ellipsis'));
      expect(w['textAlign'], equals('center'));
    });

    test('Boundary: empty string content', () {
      final w = MCPUIJsonGenerator.text('');

      expect(w['type'], equals('text'));
      expect(w['content'], equals(''));
    });
  });

  // TC-069: MCPUIJsonGenerator.image
  group('TC-069: MCPUIJsonGenerator.image', () {
    test('Normal: produces image with all params', () {
      final w = MCPUIJsonGenerator.image(
        src: 'https://example.com/img.png',
        fit: 'cover',
        width: 200,
        height: 100,
      );

      expect(w['type'], equals('image'));
      expect(w['src'], equals('https://example.com/img.png'));
      expect(w['fit'], equals('cover'));
      expect(w['width'], equals(200));
      expect(w['height'], equals(100));
    });

    test('Boundary: src only', () {
      final w = MCPUIJsonGenerator.image(src: 'img.png');

      expect(w['type'], equals('image'));
      expect(w['src'], equals('img.png'));
    });
  });

  // TC-070: MCPUIJsonGenerator.icon
  group('TC-070: MCPUIJsonGenerator.icon', () {
    test('Normal: produces icon with name, size, color', () {
      final w = MCPUIJsonGenerator.icon(
        icon: 'home',
        size: 24.0,
        color: '#FF0000',
      );

      expect(w['type'], equals('icon'));
      expect(w['icon'], equals('home'));
      expect(w['size'], equals(24.0));
      expect(w['color'], equals('#FF0000'));
    });

    test('Boundary: name only', () {
      final w = MCPUIJsonGenerator.icon(icon: 'settings');

      expect(w['type'], equals('icon'));
      expect(w['icon'], equals('settings'));
    });
  });

  // TC-071: MCPUIJsonGenerator.divider
  group('TC-071: MCPUIJsonGenerator.divider', () {
    test('Normal: produces divider with params', () {
      final w = MCPUIJsonGenerator.divider(
        thickness: 2.0,
        color: '#CCCCCC',
        indent: 16.0,
      );

      expect(w['type'], equals('divider'));
      expect(w['thickness'], equals(2.0));
      expect(w['color'], equals('#CCCCCC'));
      expect(w['indent'], equals(16.0));
    });

    test('Boundary: no params (default divider)', () {
      final w = MCPUIJsonGenerator.divider();

      expect(w['type'], equals('divider'));
    });
  });

  // TC-072: MCPUIJsonGenerator.card (static method)
  group('TC-072: MCPUIJsonGenerator.card (static method)', () {
    test('Normal: produces card with all params', () {
      final w = MCPUIJsonGenerator.card(
        child: MCPUIJsonGenerator.text('Card'),
        elevation: 4.0,
        margin: MCPUIJsonGenerator.edgeInsets(all: 8),
      );

      expect(w['type'], equals('card'));
      expect(w['child'], isA<Map>());
      expect(w['elevation'], equals(4.0));
      expect(w['margin'], isA<Map>());
    });

    test('Boundary: child only', () {
      final w = MCPUIJsonGenerator.card(
        child: MCPUIJsonGenerator.text('Only'),
      );

      expect(w['type'], equals('card'));
      expect(w['child'], isA<Map>());
    });
  });

  // TC-073: MCPUIJsonGenerator.loadingIndicator
  group('TC-073: MCPUIJsonGenerator.loadingIndicator', () {
    test('Normal: produces loading indicator', () {
      final w = MCPUIJsonGenerator.loadingIndicator(indicatorType: 'circular');

      // loadingIndicator() delegates to canonical progressBar() per spec §17.5.2
      expect(w['type'], equals('progressBar'));
      expect(w['indicatorType'], equals('circular'));
    });

    test('Boundary: default type', () {
      final w = MCPUIJsonGenerator.loadingIndicator();

      expect(w['type'], equals('progressBar'));
    });
  });
}
