import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-089: MCPUIJsonGenerator.list
  group('TC-089: MCPUIJsonGenerator.list', () {
    test('Normal: produces list with all params', () {
      final w = MCPUIJsonGenerator.list(
        items: '{{state.items}}',
        itemTemplate: MCPUIJsonGenerator.listTile(title: '{{item.name}}'),
        spacing: 8,
      );

      expect(w['type'], equals('list'));
      expect(w['items'], equals('{{state.items}}'));
      expect(w['itemTemplate'], isA<Map>());
      expect(w['spacing'], equals(8));
    });

    test('Boundary: items and itemTemplate only', () {
      final w = MCPUIJsonGenerator.list(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.text('item'),
      );

      expect(w['type'], equals('list'));
    });
  });

  // TC-090: MCPUIJsonGenerator.grid
  group('TC-090: MCPUIJsonGenerator.grid', () {
    test('Normal: produces grid with columns and spacing', () {
      final w = MCPUIJsonGenerator.grid(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.card(
          child: MCPUIJsonGenerator.text('{{item.name}}'),
        ),
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      );

      expect(w['type'], equals('grid'));
      expect(w['crossAxisCount'], equals(3));
      expect(w['mainAxisSpacing'], equals(8));
      expect(w['crossAxisSpacing'], equals(8));
    });

    test('Boundary: minimal params', () {
      final w = MCPUIJsonGenerator.grid(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.text('item'),
      );

      expect(w['type'], equals('grid'));
    });
  });

  // TC-091: MCPUIJsonGenerator.listTile
  group('TC-091: MCPUIJsonGenerator.listTile', () {
    test('Normal: produces list tile with all params', () {
      final w = MCPUIJsonGenerator.listTile(
        title: '{{item.title}}',
        subtitle: '{{item.description}}',
        leading: MCPUIJsonGenerator.icon(icon: 'star'),
        trailing: MCPUIJsonGenerator.icon(icon: 'chevron_right'),
      );

      // listTile() delegates to canonical listItem() per spec §17.5.2
      expect(w['type'], equals('listItem'));
      expect(w['title'], equals('{{item.title}}'));
      expect(w['subtitle'], equals('{{item.description}}'));
      expect(w['leading'], isA<Map>());
      expect(w['trailing'], isA<Map>());
    });

    test('Boundary: title only', () {
      final w = MCPUIJsonGenerator.listTile(title: '{{item.name}}');

      // listTile() delegates to canonical listItem() per spec §17.5.2
      expect(w['type'], equals('listItem'));
      expect(w['title'], equals('{{item.name}}'));
    });
  });
}
