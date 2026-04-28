import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-041: stateAction — set
  group('TC-041: stateAction — set', () {
    test('Normal: produces set action', () {
      final a = MCPUIJsonGenerator.stateAction(
        action: 'set',
        binding: 'counter',
        value: 0,
      );

      expect(a['type'], equals('state'));
      expect(a['action'], equals('set'));
      expect(a['binding'], equals('counter'));
      expect(a['value'], equals(0));
    });

    test('Boundary: value null for set action', () {
      final a = MCPUIJsonGenerator.stateAction(
        action: 'set',
        binding: 'val',
        value: null,
      );

      expect(a['action'], equals('set'));
    });
  });

  // TC-042: stateAction — all operations
  group('TC-042: stateAction — all operations', () {
    test('Normal: increment', () {
      final a = MCPUIJsonGenerator.stateAction(
        action: 'increment',
        binding: 'counter',
        value: 1,
      );

      expect(a['action'], equals('increment'));
    });

    test('Normal: toggle', () {
      final a = MCPUIJsonGenerator.stateAction(
        action: 'toggle',
        binding: 'visible',
      );

      expect(a['action'], equals('toggle'));
    });

    test('Normal: append', () {
      final a = MCPUIJsonGenerator.stateAction(
        action: 'append',
        binding: 'items',
        value: 'new',
      );

      expect(a['action'], equals('append'));
    });

    test('Normal: remove', () {
      final a = MCPUIJsonGenerator.stateAction(
        action: 'remove',
        binding: 'items',
        value: 'old',
      );

      expect(a['action'], equals('remove'));
    });

    test('Boundary: increment without amount', () {
      final a = MCPUIJsonGenerator.stateAction(
        action: 'increment',
        binding: 'counter',
      );

      expect(a['action'], equals('increment'));
    });
  });

  // TC-043: toolAction
  group('TC-043: toolAction', () {
    test('Normal: with params', () {
      final a = MCPUIJsonGenerator.toolAction(
        'fetchData',
        params: {'key': 'value'},
      );

      expect(a['type'], equals('tool'));
      expect(a['tool'], equals('fetchData'));
      expect(a['params'], isA<Map>());
    });

    test('Normal: with onSuccess and onError', () {
      final a = MCPUIJsonGenerator.toolAction(
        'submit',
        params: {'data': 'test'},
        onSuccess: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'status',
          value: 'done',
        ),
        onError: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'error',
          value: 'failed',
        ),
      );

      expect(a['onSuccess'], isA<Map>());
      expect(a['onError'], isA<Map>());
    });

    test('Boundary: no params', () {
      final a = MCPUIJsonGenerator.toolAction('simple');

      expect(a['type'], equals('tool'));
      expect(a['tool'], equals('simple'));
    });
  });

  // TC-044: navigationAction
  group('TC-044: navigationAction', () {
    test('Normal: push with route', () {
      final a = MCPUIJsonGenerator.navigationAction(
        action: 'push',
        route: '/details',
      );

      expect(a['type'], equals('navigation'));
      expect(a['action'], equals('push'));
      expect(a['route'], equals('/details'));
    });

    test('Normal: pop without route', () {
      final a = MCPUIJsonGenerator.navigationAction(action: 'pop');

      expect(a['type'], equals('navigation'));
      expect(a['action'], equals('pop'));
    });

    test('Normal: replace with route and params', () {
      final a = MCPUIJsonGenerator.navigationAction(
        action: 'replace',
        route: '/new',
        params: {'id': '123'},
      );

      expect(a['action'], equals('replace'));
      expect(a['route'], equals('/new'));
      expect(a['params'], isA<Map>());
    });

    test('Boundary: pop with no route', () {
      final a = MCPUIJsonGenerator.navigationAction(action: 'pop');

      expect(a['action'], equals('pop'));
    });
  });

  // TC-045: resourceAction
  group('TC-045: resourceAction', () {
    test('Normal: with uri and binding', () {
      final a = MCPUIJsonGenerator.resourceAction(
        uri: 'data://temp',
        binding: 'temperature',
      );

      expect(a['type'], equals('resource'));
      expect(a['uri'], equals('data://temp'));
      expect(a['binding'], equals('temperature'));
    });

    test('Normal: with optional params', () {
      final a = MCPUIJsonGenerator.resourceAction(
        uri: 'data://status',
        binding: 'status',
        refreshInterval: const Duration(seconds: 5),
      );

      expect(a['refreshInterval'], equals(5000));
    });
  });

  // TC-046: batchAction
  group('TC-046: batchAction', () {
    test('Normal: multiple actions with sequential flag', () {
      final a = MCPUIJsonGenerator.batchAction(
        actions: [
          MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'loading',
            value: true,
          ),
          MCPUIJsonGenerator.toolAction('loadData'),
        ],
        sequential: true,
      );

      expect(a['type'], equals('batch'));
      expect(a['actions'], isA<List>());
      expect((a['actions'] as List).length, equals(2));
      expect(a['sequential'], isTrue);
    });

    test('Boundary: single action in list', () {
      final a = MCPUIJsonGenerator.batchAction(
        actions: [MCPUIJsonGenerator.toolAction('only')],
      );

      expect((a['actions'] as List).length, equals(1));
    });
  });

  // TC-047: conditionalAction
  group('TC-047: conditionalAction', () {
    test('Normal: with then and orElse', () {
      final a = MCPUIJsonGenerator.conditionalAction(
        condition: '{{isLoggedIn}}',
        then: MCPUIJsonGenerator.navigationAction(action: 'push', route: '/home'),
        orElse: MCPUIJsonGenerator.navigationAction(action: 'push', route: '/login'),
      );

      expect(a['type'], equals('conditional'));
      expect(a['condition'], equals('{{isLoggedIn}}'));
      expect(a['then'], isA<Map>());
      expect(a['else'], isA<Map>());
    });

    test('Boundary: without orElse', () {
      final a = MCPUIJsonGenerator.conditionalAction(
        condition: '{{isReady}}',
        then: MCPUIJsonGenerator.toolAction('proceed'),
      );

      expect(a['type'], equals('conditional'));
      expect(a['condition'], equals('{{isReady}}'));
      expect(a['then'], isA<Map>());
    });
  });

  // TC-108: stateAction — compute operation
  group('TC-108: stateAction all six operations', () {
    test('Normal: compute action', () {
      final a = MCPUIJsonGenerator.stateAction(
        action: 'compute',
        binding: 'total',
        value: '{{price * quantity}}',
      );

      expect(a['action'], equals('compute'));
    });
  });

  // TC-110: navigationAction with index
  group('TC-110: navigationAction with index', () {
    test('Normal: setIndex action', () {
      final a = MCPUIJsonGenerator.navigationAction(
        action: 'setIndex',
        index: 2,
      );

      expect(a['action'], equals('setIndex'));
      expect(a['index'], equals(2));
    });
  });
}
