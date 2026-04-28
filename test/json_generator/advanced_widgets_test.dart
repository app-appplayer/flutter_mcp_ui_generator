import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-101: MCPUIJsonGenerator.chart
  group('TC-101: MCPUIJsonGenerator.chart', () {
    test('Normal: produces chart with type, data, options', () {
      final w = MCPUIJsonGenerator.chart(
        chartType: 'line',
        data: [
          {'x': 1, 'y': 10},
          {'x': 2, 'y': 20},
        ],
        options: {'showGrid': true},
      );

      expect(w['type'], equals('chart'));
      expect(w['chartType'], equals('line'));
      expect(w['data'], isA<List>());
      expect(w['options'], isA<Map>());
    });

    test('Boundary: chartType and data only', () {
      final w = MCPUIJsonGenerator.chart(
        chartType: 'bar',
        data: [],
      );

      expect(w['type'], equals('chart'));
      expect(w['chartType'], equals('bar'));
    });
  });

  // TC-102: MCPUIJsonGenerator.map
  group('TC-102: MCPUIJsonGenerator.map', () {
    test('Normal: produces map with all params', () {
      final w = MCPUIJsonGenerator.map(
        latitude: 37.5,
        longitude: 127.0,
        zoom: 10,
        markers: [
          {'lat': 37.5, 'lng': 127.0, 'label': 'Seoul'},
        ],
        interactive: true,
        width: 400,
        height: 300,
      );

      expect(w['type'], equals('map'));
      expect(w['latitude'], equals(37.5));
      expect(w['longitude'], equals(127.0));
      expect(w['zoom'], equals(10));
      expect(w['markers'], isA<List>());
    });

    test('Boundary: latitude and longitude only', () {
      final w = MCPUIJsonGenerator.map(
        latitude: 37.5,
        longitude: 127.0,
      );

      expect(w['type'], equals('map'));
    });
  });

  // TC-103: MCPUIJsonGenerator.mediaPlayer
  group('TC-103: MCPUIJsonGenerator.mediaPlayer', () {
    test('Normal: produces media player', () {
      final w = MCPUIJsonGenerator.mediaPlayer(
        source: 'https://example.com/video.mp4',
        autoplay: false,
        controls: true,
      );

      expect(w['type'], equals('mediaPlayer'));
      expect(w['source'], equals('https://example.com/video.mp4'));
    });

    test('Boundary: source only', () {
      final w = MCPUIJsonGenerator.mediaPlayer(
        source: 'audio.mp3',
      );

      expect(w['type'], equals('mediaPlayer'));
      expect(w['source'], equals('audio.mp3'));
    });
  });

  // TC-104: MCPUIJsonGenerator.calendar
  group('TC-104: MCPUIJsonGenerator.calendar', () {
    test('Normal: produces calendar with all params', () {
      final w = MCPUIJsonGenerator.calendar(
        view: 'month',
        selectedDate: '2026-01-01',
        events: [
          {'date': '2026-01-15', 'title': 'Meeting'},
        ],
        showHeader: true,
        width: 400,
        height: 300,
      );

      expect(w['type'], equals('calendar'));
      expect(w['view'], equals('month'));
      expect(w['selectedDate'], equals('2026-01-01'));
      expect(w['events'], isA<List>());
    });

    test('Boundary: no params (defaults)', () {
      final w = MCPUIJsonGenerator.calendar();

      expect(w['type'], equals('calendar'));
    });
  });

  // TC-105: MCPUIJsonGenerator.tree
  group('TC-105: MCPUIJsonGenerator.tree', () {
    test('Normal: produces tree view', () {
      final w = MCPUIJsonGenerator.tree(
        data: [
          {
            'label': 'Root',
            'children': [
              {'label': 'Child'},
            ],
          },
        ],
        expandAll: true,
        showLines: true,
      );

      expect(w['type'], equals('tree'));
      expect(w['data'], isA<List>());
      expect(w['expandAll'], isTrue);
      expect(w['showLines'], isTrue);
    });

    test('Boundary: data only', () {
      final w = MCPUIJsonGenerator.tree(data: []);

      expect(w['type'], equals('tree'));
    });
  });

  // TC-106: MCPUIJsonGenerator.draggable
  group('TC-106: MCPUIJsonGenerator.draggable', () {
    test('Normal: produces draggable wrapper', () {
      final w = MCPUIJsonGenerator.draggable(
        child: MCPUIJsonGenerator.text('Drag me'),
        feedback: MCPUIJsonGenerator.text('Dragging'),
        data: 'item1',
      );

      expect(w['type'], equals('draggable'));
      expect(w['child'], isA<Map>());
      expect(w['feedback'], isA<Map>());
      expect(w['data'], equals('item1'));
    });

    test('Boundary: child and feedback only', () {
      final w = MCPUIJsonGenerator.draggable(
        child: MCPUIJsonGenerator.text('D'),
        feedback: MCPUIJsonGenerator.text('F'),
      );

      expect(w['type'], equals('draggable'));
    });
  });

  // TC-107: MCPUIJsonGenerator.dragTarget
  group('TC-107: MCPUIJsonGenerator.dragTarget', () {
    test('Normal: produces drag target', () {
      final w = MCPUIJsonGenerator.dragTarget(
        builder: MCPUIJsonGenerator.box(color: '#EEEEEE'),
        drop: MCPUIJsonGenerator.toolAction('handleDrop'),
      );

      expect(w['type'], equals('dragTarget'));
      expect(w['builder'], isA<Map>());
      expect(w['onDrop'], isA<Map>());
    });

    test('Boundary: builder and drop only', () {
      final w = MCPUIJsonGenerator.dragTarget(
        builder: MCPUIJsonGenerator.text('Drop here'),
        drop: MCPUIJsonGenerator.toolAction('drop'),
      );

      expect(w['type'], equals('dragTarget'));
    });
  });
}
