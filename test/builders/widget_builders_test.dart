import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-021: LinearBuilder — add and addAll
  group('TC-021: LinearBuilder — add and addAll', () {
    test('Normal: add single child', () {
      final layout = MCPUIBuilder.linear()
          .add(MCPUIJsonGenerator.text('Item'))
          .build();

      expect((layout['children'] as List).length, equals(1));
    });

    test('Normal: addAll multiple children', () {
      final layout = MCPUIBuilder.linear()
          .addAll([
            MCPUIJsonGenerator.text('A'),
            MCPUIJsonGenerator.text('B'),
          ])
          .build();

      expect((layout['children'] as List).length, equals(2));
    });

    test('Boundary: empty children list (no add calls)', () {
      final layout = MCPUIBuilder.linear().build();

      expect((layout['children'] as List), isEmpty);
    });
  });

  // TC-022: LinearBuilder — direction
  group('TC-022: LinearBuilder — direction', () {
    test('Normal: direction sets value', () {
      final layout = MCPUIBuilder.linear().direction('vertical').build();

      expect(layout['direction'], equals('vertical'));
    });

    test('Normal: vertical() shortcut', () {
      final layout = MCPUIBuilder.linear().vertical().build();

      expect(layout['direction'], equals('vertical'));
    });

    test('Normal: horizontal() shortcut', () {
      final layout = MCPUIBuilder.linear().horizontal().build();

      expect(layout['direction'], equals('horizontal'));
    });

    test('Boundary: default direction', () {
      final layout = MCPUIBuilder.linear().build();

      expect(layout['direction'], equals('vertical'));
    });
  });

  // TC-023: LinearBuilder — distribution and alignment
  group('TC-023: LinearBuilder — distribution and alignment', () {
    test('Normal: distribution sets value', () {
      final layout =
          MCPUIBuilder.linear().distribution('space-between').build();

      expect(layout['distribution'], equals('space-between'));
    });

    test('Normal: alignment sets value', () {
      final layout = MCPUIBuilder.linear().alignment('center').build();

      expect(layout['alignment'], equals('center'));
    });

    test('Boundary: both set together', () {
      final layout = MCPUIBuilder.linear()
          .distribution('center')
          .alignment('start')
          .build();

      expect(layout['distribution'], equals('center'));
      expect(layout['alignment'], equals('start'));
    });
  });

  // TC-024: LinearBuilder — gap and wrap
  group('TC-024: LinearBuilder — gap and wrap', () {
    test('Normal: gap sets spacing', () {
      final layout = MCPUIBuilder.linear().gap(8.0).build();

      expect(layout['spacing'], equals(8.0));
    });

    test('Normal: wrap enables wrap mode', () {
      final layout = MCPUIBuilder.linear().wrap(true).build();

      expect(layout['wrap'], isTrue);
    });

    test('Boundary: gap(0) — no spacing', () {
      final layout = MCPUIBuilder.linear().gap(0).build();

      expect(layout['spacing'], equals(0));
    });
  });

  // TC-025: LinearBuilder — build output
  group('TC-025: LinearBuilder — build output', () {
    test('Normal: complete build', () {
      final layout = MCPUIBuilder.linear()
          .add(MCPUIJsonGenerator.text('Child'))
          .direction('horizontal')
          .distribution('center')
          .alignment('start')
          .gap(16.0)
          .wrap(true)
          .build();

      expect(layout['type'], equals('linear'));
      expect(layout['direction'], equals('horizontal'));
      expect(layout['distribution'], equals('center'));
      expect(layout['alignment'], equals('start'));
      expect(layout['spacing'], equals(16.0));
      expect(layout['wrap'], isTrue);
      expect((layout['children'] as List).length, equals(1));
    });

    test('Boundary: minimal build produces defaults', () {
      final layout = MCPUIBuilder.linear().build();

      expect(layout['type'], equals('linear'));
      expect(layout['direction'], equals('vertical'));
      expect(layout['children'], isA<List>());
    });
  });

  // TC-026: BoxBuilder — child
  group('TC-026: BoxBuilder — child', () {
    test('Normal: sets child widget', () {
      final box =
          MCPUIBuilder.box().child(MCPUIJsonGenerator.text('Content')).build();

      expect(box['child'], isA<Map>());
    });

    test('Boundary: no child set', () {
      final box = MCPUIBuilder.box().build();

      expect(box.containsKey('child'), isFalse);
    });
  });

  // TC-027: BoxBuilder — width and height
  group('TC-027: BoxBuilder — width and height', () {
    test('Normal: sets dimensions', () {
      final box = MCPUIBuilder.box().width(100).height(200).build();

      expect(box['width'], equals(100));
      expect(box['height'], equals(200));
    });

    test('Boundary: only width set', () {
      final box = MCPUIBuilder.box().width(150).build();

      expect(box['width'], equals(150));
      expect(box.containsKey('height'), isFalse);
    });
  });

  // TC-028: BoxBuilder — color, padding, margin, decoration
  group('TC-028: BoxBuilder — color, padding, margin, decoration', () {
    test('Normal: color sets background', () {
      final box = MCPUIBuilder.box().color('#FF0000').build();

      expect(box['color'], equals('#FF0000'));
    });

    test('Normal: padding sets padding', () {
      final box =
          MCPUIBuilder.box().padding(MCPUIJsonGenerator.edgeInsets(all: 16)).build();

      expect(box['padding'], isA<Map>());
    });

    test('Normal: margin sets margin', () {
      final box =
          MCPUIBuilder.box().margin(MCPUIJsonGenerator.edgeInsets(all: 8)).build();

      expect(box['margin'], isA<Map>());
    });

    test('Normal: decoration sets decoration', () {
      final box = MCPUIBuilder.box()
          .decoration(MCPUIJsonGenerator.decoration(color: '#FFF'))
          .build();

      expect(box['decoration'], isA<Map>());
    });

    test('Boundary: all styling set together', () {
      final box = MCPUIBuilder.box()
          .color('#FF0000')
          .padding(MCPUIJsonGenerator.edgeInsets(all: 16))
          .margin(MCPUIJsonGenerator.edgeInsets(all: 8))
          .decoration(MCPUIJsonGenerator.decoration(borderRadius: 8))
          .build();

      expect(box['color'], isNotNull);
      expect(box['padding'], isNotNull);
      expect(box['margin'], isNotNull);
      expect(box['decoration'], isNotNull);
    });
  });

  // TC-029: BoxBuilder — build output
  group('TC-029: BoxBuilder — build output', () {
    test('Normal: complete build', () {
      final box = MCPUIBuilder.box()
          .child(MCPUIJsonGenerator.text('Content'))
          .width(100)
          .height(200)
          .color('#FF0000')
          .build();

      expect(box['type'], equals('box'));
      expect(box['child'], isA<Map>());
      expect(box['width'], equals(100));
    });

    test('Boundary: minimal build', () {
      final box = MCPUIBuilder.box().build();

      expect(box['type'], equals('box'));
    });
  });

  // TC-030: StackBuilder — add and addAll
  group('TC-030: StackBuilder — add and addAll', () {
    test('Normal: add child', () {
      final stack =
          MCPUIBuilder.stack().add(MCPUIJsonGenerator.text('Layer')).build();

      expect((stack['children'] as List).length, equals(1));
    });

    test('Normal: addAll children', () {
      final stack = MCPUIBuilder.stack()
          .addAll([
            MCPUIJsonGenerator.box(color: '#FF0000'),
            MCPUIJsonGenerator.text('Overlay'),
          ])
          .build();

      expect((stack['children'] as List).length, equals(2));
    });

    test('Boundary: empty children', () {
      final stack = MCPUIBuilder.stack().build();

      expect((stack['children'] as List), isEmpty);
    });
  });

  // TC-031: StackBuilder — alignment and fit
  group('TC-031: StackBuilder — alignment and fit', () {
    test('Normal: alignment sets value', () {
      final stack = MCPUIBuilder.stack().alignment('center').build();

      expect(stack['alignment'], equals('center'));
    });

    test('Normal: fit sets value', () {
      final stack = MCPUIBuilder.stack().fit('expand').build();

      expect(stack['fit'], equals('expand'));
    });

    test('Boundary: defaults when not set', () {
      final stack = MCPUIBuilder.stack().build();

      expect(stack.containsKey('alignment'), isFalse);
      expect(stack.containsKey('fit'), isFalse);
    });
  });

  // TC-032: StackBuilder — build output
  group('TC-032: StackBuilder — build output', () {
    test('Normal: complete build', () {
      final stack = MCPUIBuilder.stack()
          .add(MCPUIJsonGenerator.box(color: '#FF0000'))
          .add(MCPUIJsonGenerator.text('Top'))
          .alignment('center')
          .fit('expand')
          .build();

      expect(stack['type'], equals('stack'));
      expect((stack['children'] as List).length, equals(2));
      expect(stack['alignment'], equals('center'));
      expect(stack['fit'], equals('expand'));
    });

    test('Boundary: minimal build', () {
      final stack = MCPUIBuilder.stack().build();

      expect(stack['type'], equals('stack'));
      expect(stack['children'], isA<List>());
    });
  });

  // TC-033: CenterBuilder — child
  group('TC-033: CenterBuilder — child', () {
    test('Normal: sets child widget', () {
      final center = MCPUIBuilder.center()
          .child(MCPUIJsonGenerator.text('Centered'))
          .build();

      expect(center['child'], isA<Map>());
    });

    test('Boundary: no child set', () {
      final center = MCPUIBuilder.center().build();

      expect(center.containsKey('child'), isFalse);
    });
  });

  // TC-034: CenterBuilder — build output
  group('TC-034: CenterBuilder — build output', () {
    test('Normal: produces center map', () {
      final center = MCPUIBuilder.center()
          .child(MCPUIJsonGenerator.text('Content'))
          .build();

      expect(center['type'], equals('center'));
      expect(center['child'], isA<Map>());
    });

    test('Boundary: build without child', () {
      final center = MCPUIBuilder.center().build();

      expect(center['type'], equals('center'));
    });
  });

  // TC-035: CardBuilder — child, elevation, margin, shape
  group('TC-035: CardBuilder — child, elevation, margin, shape', () {
    test('Normal: child sets card content', () {
      final card = MCPUIBuilder.card()
          .child(MCPUIJsonGenerator.text('Card'))
          .build();

      expect(card['child'], isA<Map>());
    });

    test('Normal: elevation sets elevation', () {
      final card = MCPUIBuilder.card().elevation(4.0).build();

      expect(card['elevation'], equals(4.0));
    });

    test('Normal: margin sets margin', () {
      final card = MCPUIBuilder.card()
          .margin(MCPUIJsonGenerator.edgeInsets(all: 8))
          .build();

      expect(card['margin'], isA<Map>());
    });

    test('Normal: shape sets shape', () {
      final card = MCPUIBuilder.card()
          .shape(MCPUIJsonGenerator.decoration(borderRadius: 8))
          .build();

      expect(card['shape'], isA<Map>());
    });

    test('Boundary: default elevation when not set', () {
      final card = MCPUIBuilder.card().build();

      expect(card.containsKey('elevation'), isFalse);
    });
  });

  // TC-036: CardBuilder — build output
  group('TC-036: CardBuilder — build output', () {
    test('Normal: complete build', () {
      final card = MCPUIBuilder.card()
          .child(MCPUIJsonGenerator.text('Content'))
          .elevation(4.0)
          .margin(MCPUIJsonGenerator.edgeInsets(all: 8))
          .shape(MCPUIJsonGenerator.decoration(borderRadius: 8))
          .build();

      expect(card['type'], equals('card'));
      expect(card['child'], isA<Map>());
      expect(card['elevation'], equals(4.0));
      expect(card['margin'], isA<Map>());
      expect(card['shape'], isA<Map>());
    });

    test('Boundary: minimal build (child only)', () {
      final card = MCPUIBuilder.card()
          .child(MCPUIJsonGenerator.text('Only'))
          .build();

      expect(card['type'], equals('card'));
      expect(card['child'], isA<Map>());
    });
  });

  // TC-037: ListViewBuilder — constructor and methods
  group('TC-037: ListViewBuilder — constructor and methods', () {
    test('Normal: constructor with items and itemTemplate', () {
      final listView = MCPUIBuilder.listView(
        items: '{{state.items}}',
        itemTemplate: MCPUIJsonGenerator.listTile(title: '{{item.name}}'),
      ).build();

      expect(listView['type'], equals('list'));
      expect(listView['items'], equals('{{state.items}}'));
      expect(listView['itemTemplate'], isA<Map>());
    });

    test('Normal: spacing sets spacing', () {
      final listView = MCPUIBuilder.listView(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.text('item'),
      ).spacing(8.0).build();

      expect(listView['spacing'], equals(8.0));
    });

    test('Normal: shrinkWrap enables', () {
      final listView = MCPUIBuilder.listView(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.text('item'),
      ).shrinkWrap(true).build();

      expect(listView['shrinkWrap'], isTrue);
    });

    test('Normal: orientation sets direction', () {
      final listView = MCPUIBuilder.listView(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.text('item'),
      ).orientation('horizontal').build();

      expect(listView['orientation'], equals('horizontal'));
    });
  });

  // TC-038: ListViewBuilder — build output
  group('TC-038: ListViewBuilder — build output', () {
    test('Normal: complete build', () {
      final listView = MCPUIBuilder.listView(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.listTile(title: '{{item.name}}'),
      )
          .spacing(8)
          .shrinkWrap(true)
          .orientation('vertical')
          .build();

      expect(listView['type'], equals('list'));
      expect(listView['items'], equals('{{items}}'));
      expect(listView['itemTemplate'], isA<Map>());
      expect(listView['spacing'], equals(8));
      expect(listView['shrinkWrap'], isTrue);
      expect(listView['orientation'], equals('vertical'));
    });

    test('Boundary: constructor params only', () {
      final listView = MCPUIBuilder.listView(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.text('item'),
      ).build();

      expect(listView['type'], equals('list'));
      expect(listView['items'], isNotNull);
      expect(listView['itemTemplate'], isNotNull);
    });
  });

  // TC-039: GridViewBuilder — constructor and methods
  group('TC-039: GridViewBuilder — constructor and methods', () {
    test('Normal: constructor with items and itemTemplate', () {
      final grid = MCPUIBuilder.gridView(
        items: '{{state.items}}',
        itemTemplate: MCPUIJsonGenerator.card(
          child: MCPUIJsonGenerator.text('{{item.name}}'),
        ),
      ).build();

      expect(grid['type'], equals('grid'));
      expect(grid['items'], equals('{{state.items}}'));
    });

    test('Normal: crossAxisCount sets columns', () {
      final grid = MCPUIBuilder.gridView(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.text('item'),
      ).crossAxisCount(3).build();

      expect(grid['crossAxisCount'], equals(3));
    });

    test('Normal: spacing methods', () {
      final grid = MCPUIBuilder.gridView(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.text('item'),
      ).mainAxisSpacing(8).crossAxisSpacing(8).build();

      expect(grid['mainAxisSpacing'], equals(8));
      expect(grid['crossAxisSpacing'], equals(8));
    });

    test('Normal: childAspectRatio', () {
      final grid = MCPUIBuilder.gridView(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.text('item'),
      ).childAspectRatio(1.5).build();

      expect(grid['childAspectRatio'], equals(1.5));
    });
  });

  // TC-040: GridViewBuilder — build output
  group('TC-040: GridViewBuilder — build output', () {
    test('Normal: complete build', () {
      final grid = MCPUIBuilder.gridView(
        items: '{{products}}',
        itemTemplate: MCPUIJsonGenerator.text('item'),
      )
          .crossAxisCount(2)
          .mainAxisSpacing(8.0)
          .crossAxisSpacing(8.0)
          .childAspectRatio(1.5)
          .build();

      expect(grid['type'], equals('grid'));
      expect(grid['crossAxisCount'], equals(2));
      expect(grid['mainAxisSpacing'], equals(8.0));
      expect(grid['crossAxisSpacing'], equals(8.0));
      expect(grid['childAspectRatio'], equals(1.5));
    });

    test('Boundary: constructor params only', () {
      final grid = MCPUIBuilder.gridView(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.text('item'),
      ).build();

      expect(grid['type'], equals('grid'));
      expect(grid['items'], isNotNull);
      expect(grid['itemTemplate'], isNotNull);
    });
  });
}
