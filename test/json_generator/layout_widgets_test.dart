import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-056: MCPUIJsonGenerator.linear
  group('TC-056: MCPUIJsonGenerator.linear', () {
    test('Normal: produces linear layout with all params', () {
      final w = MCPUIJsonGenerator.linear(
        children: [MCPUIJsonGenerator.text('A'), MCPUIJsonGenerator.text('B')],
        direction: 'vertical',
        distribution: 'start',
        alignment: 'center',
        spacing: 8.0,
      );

      expect(w['type'], equals('linear'));
      expect((w['children'] as List).length, equals(2));
      expect(w['direction'], equals('vertical'));
      expect(w['distribution'], equals('start'));
      expect(w['alignment'], equals('center'));
      expect(w['spacing'], equals(8.0));
    });

    test('Boundary: no children', () {
      final w = MCPUIJsonGenerator.linear(children: []);

      expect(w['type'], equals('linear'));
      expect(w['children'], isEmpty);
    });
  });

  // TC-057: MCPUIJsonGenerator.box
  group('TC-057: MCPUIJsonGenerator.box', () {
    test('Normal: produces box with all params', () {
      final w = MCPUIJsonGenerator.box(
        child: MCPUIJsonGenerator.text('Content'),
        width: 100.0,
        height: 200.0,
        color: '#FF0000',
        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
        margin: MCPUIJsonGenerator.edgeInsets(all: 8),
        decoration: MCPUIJsonGenerator.decoration(borderRadius: 8),
      );

      expect(w['type'], equals('box'));
      expect(w['child'], isA<Map>());
      expect(w['width'], equals(100.0));
      expect(w['height'], equals(200.0));
      expect(w['color'], equals('#FF0000'));
    });

    test('Boundary: no optional params', () {
      final w = MCPUIJsonGenerator.box();

      expect(w['type'], equals('box'));
    });
  });

  // TC-058: MCPUIJsonGenerator.stack
  group('TC-058: MCPUIJsonGenerator.stack', () {
    test('Normal: produces stack with children', () {
      final w = MCPUIJsonGenerator.stack(
        children: [MCPUIJsonGenerator.box(), MCPUIJsonGenerator.text('Top')],
        alignment: 'center',
        fit: 'expand',
      );

      expect(w['type'], equals('stack'));
      expect((w['children'] as List).length, equals(2));
      expect(w['alignment'], equals('center'));
      expect(w['fit'], equals('expand'));
    });

    test('Boundary: empty children', () {
      final w = MCPUIJsonGenerator.stack(children: []);

      expect(w['type'], equals('stack'));
      expect(w['children'], isEmpty);
    });
  });

  // TC-059: MCPUIJsonGenerator.center
  group('TC-059: MCPUIJsonGenerator.center', () {
    test('Normal: produces center with child', () {
      final w = MCPUIJsonGenerator.center(
        child: MCPUIJsonGenerator.text('Centered'),
      );

      expect(w['type'], equals('center'));
      expect(w['child'], isA<Map>());
    });
  });

  // TC-060: MCPUIJsonGenerator.padding
  group('TC-060: MCPUIJsonGenerator.padding', () {
    test('Normal: wraps child with edge insets', () {
      final w = MCPUIJsonGenerator.padding(
        child: MCPUIJsonGenerator.text('Content'),
        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
      );

      expect(w['type'], equals('padding'));
      expect(w['child'], isA<Map>());
      expect(w['padding'], isA<Map>());
    });
  });

  // TC-061: MCPUIJsonGenerator.sizedBox
  group('TC-061: MCPUIJsonGenerator.sizedBox', () {
    test('Normal: produces sizedBox with width and height', () {
      final w = MCPUIJsonGenerator.sizedBox(width: 100, height: 50);

      expect(w['type'], equals('sizedBox'));
      expect(w['width'], equals(100));
      expect(w['height'], equals(50));
    });

    test('Boundary: only width set', () {
      final w = MCPUIJsonGenerator.sizedBox(width: 100);

      expect(w['type'], equals('sizedBox'));
      expect(w['width'], equals(100));
    });
  });

  // TC-062: MCPUIJsonGenerator.expanded
  group('TC-062: MCPUIJsonGenerator.expanded', () {
    test('Normal: wraps child with flex', () {
      final w = MCPUIJsonGenerator.expanded(
        child: MCPUIJsonGenerator.text('Content'),
        flex: 2,
      );

      expect(w['type'], equals('expanded'));
      expect(w['child'], isA<Map>());
      expect(w['flex'], equals(2));
    });

    test('Boundary: default flex value', () {
      final w = MCPUIJsonGenerator.expanded(
        child: MCPUIJsonGenerator.text('Content'),
      );

      expect(w['type'], equals('expanded'));
    });
  });

  // TC-063: MCPUIJsonGenerator.flexible
  group('TC-063: MCPUIJsonGenerator.flexible', () {
    test('Normal: produces flexible with child and flex', () {
      final w = MCPUIJsonGenerator.flexible(
        child: MCPUIJsonGenerator.text('Content'),
        flex: 3,
        fit: 'tight',
      );

      expect(w['type'], equals('flexible'));
      expect(w['child'], isA<Map>());
      expect(w['flex'], equals(3));
      expect(w['fit'], equals('tight'));
    });

    test('Boundary: default flex and fit', () {
      final w = MCPUIJsonGenerator.flexible(
        child: MCPUIJsonGenerator.text('Content'),
      );

      expect(w['type'], equals('flexible'));
    });
  });

  // TC-064: MCPUIJsonGenerator.scrollView
  group('TC-064: MCPUIJsonGenerator.scrollView', () {
    test('Normal: produces scrollable container', () {
      final w = MCPUIJsonGenerator.scrollView(
        child: MCPUIJsonGenerator.linear(children: []),
      );

      expect(w['type'], equals('scrollView'));
      expect(w['child'], isA<Map>());
    });
  });

  // TC-065: MCPUIJsonGenerator.conditionalWidget
  group('TC-065: MCPUIJsonGenerator.conditionalWidget', () {
    test('Normal: produces conditional widget', () {
      final w = MCPUIJsonGenerator.conditionalWidget(
        condition: 'isVisible',
        then: MCPUIJsonGenerator.text('Visible'),
        orElse: MCPUIJsonGenerator.text('Hidden'),
      );

      expect(w['type'], equals('conditional'));
      expect(w['condition'], equals('isVisible'));
      expect(w['then'], isA<Map>());
      expect(w['else'], isA<Map>());
    });

    test('Boundary: without else widget', () {
      final w = MCPUIJsonGenerator.conditionalWidget(
        condition: 'isShown',
        then: MCPUIJsonGenerator.text('Shown'),
      );

      expect(w['type'], equals('conditional'));
      expect(w['condition'], equals('isShown'));
      expect(w['then'], isA<Map>());
    });
  });

  // TC-066: MCPUIJsonGenerator.mediaQuery
  group('TC-066: MCPUIJsonGenerator.mediaQuery', () {
    test('Normal: produces media query map', () {
      final w = MCPUIJsonGenerator.mediaQuery(
        condition: 'minWidth: 600',
        then: MCPUIJsonGenerator.text('Wide'),
        orElse: MCPUIJsonGenerator.text('Narrow'),
      );

      expect(w['type'], equals('mediaQuery'));
      expect(w['condition'], equals('minWidth: 600'));
      expect(w['then'], isA<Map>());
      expect(w['else'], isA<Map>());
    });

    test('Boundary: without orElse widget', () {
      final w = MCPUIJsonGenerator.mediaQuery(
        condition: 'minWidth: 600',
        then: MCPUIJsonGenerator.text('Wide'),
      );

      expect(w['type'], equals('mediaQuery'));
    });
  });

  // TC-067: MCPUIJsonGenerator.column, row, container (aliases)
  group('TC-067: MCPUIJsonGenerator.column, row, container (aliases)', () {
    test('Normal: column produces vertical linear', () {
      final w = MCPUIJsonGenerator.column(
        children: [MCPUIJsonGenerator.text('A')],
      );

      expect(w['type'], equals('linear'));
      expect(w['direction'], equals('vertical'));
    });

    test('Normal: row produces horizontal linear', () {
      final w = MCPUIJsonGenerator.row(
        children: [MCPUIJsonGenerator.text('A')],
      );

      expect(w['type'], equals('linear'));
      expect(w['direction'], equals('horizontal'));
    });

    test('Normal: container produces box output', () {
      final w = MCPUIJsonGenerator.container(
        child: MCPUIJsonGenerator.text('Content'),
      );

      expect(w['type'], equals('box'));
    });

    test('Boundary: minimal arguments for each alias', () {
      final col = MCPUIJsonGenerator.column(children: []);
      final row = MCPUIJsonGenerator.row(children: []);
      final cont = MCPUIJsonGenerator.container();

      expect(col['type'], equals('linear'));
      expect(row['type'], equals('linear'));
      expect(cont['type'], equals('box'));
    });
  });
}
