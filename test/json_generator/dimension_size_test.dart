import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-118: MCPUIJsonGenerator.dimension
  group('TC-118: MCPUIJsonGenerator.dimension', () {
    test('Normal: produces dimension with value and unit', () {
      final d = MCPUIJsonGenerator.dimension(100, 'px');

      expect(d['value'], equals(100));
      expect(d['unit'], equals('px'));
    });

    test('Boundary: zero value', () {
      final d = MCPUIJsonGenerator.dimension(0, 'px');

      expect(d['value'], equals(0));
      expect(d['unit'], equals('px'));
    });
  });

  // TC-119: MCPUIJsonGenerator.toDimension
  group('TC-119: MCPUIJsonGenerator.toDimension', () {
    test('Normal: converts to dimension format with unit', () {
      final d = MCPUIJsonGenerator.toDimension(100, useMCPFormat: true);

      expect(d, isA<Map>());
      expect((d as Map)['value'], equals(100));
    });

    test('Boundary: raw number passthrough', () {
      final d = MCPUIJsonGenerator.toDimension(50);

      expect(d, equals(50));
    });

    test('Boundary: null returns null', () {
      final d = MCPUIJsonGenerator.toDimension(null);

      expect(d, isNull);
    });
  });

  // TC-120: MCPUIJsonGenerator.percent
  group('TC-120: MCPUIJsonGenerator.percent', () {
    test('Normal: produces percentage string', () {
      final p = MCPUIJsonGenerator.percent(50);

      expect(p, equals('50.0%'));
    });

    test('Boundary: zero percent', () {
      final p = MCPUIJsonGenerator.percent(0);

      expect(p, equals('0.0%'));
    });
  });

  // TC-121: MCPUIJsonGenerator.vw and vh
  group('TC-121: MCPUIJsonGenerator.vw and vh', () {
    test('Normal: vw produces viewport width string', () {
      final v = MCPUIJsonGenerator.vw(100);

      expect(v, equals('100.0vw'));
    });

    test('Normal: vh produces viewport height string', () {
      final v = MCPUIJsonGenerator.vh(50);

      expect(v, equals('50.0vh'));
    });

    test('Boundary: vw(0) and vh(0)', () {
      expect(MCPUIJsonGenerator.vw(0), equals('0.0vw'));
      expect(MCPUIJsonGenerator.vh(0), equals('0.0vh'));
    });
  });

  // TC-122: MCPUIJsonGenerator.size
  group('TC-122: MCPUIJsonGenerator.size', () {
    test('Normal: size with unit', () {
      final s = MCPUIJsonGenerator.size(200, unit: '%');

      expect(s, isA<String>());
    });

    test('Boundary: no unit specified returns raw number', () {
      final s = MCPUIJsonGenerator.size(200);

      expect(s, equals(200));
    });
  });
}
