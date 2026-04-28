import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-140: MCPUIJsonGenerator.route
  group('TC-140: MCPUIJsonGenerator.route', () {
    test('Normal: produces route definition with all params', () {
      final r = MCPUIJsonGenerator.route(
        path: '/users/:id',
        page: MCPUIJsonGenerator.page(
          title: 'User',
          content: MCPUIJsonGenerator.text('User'),
        ),
        params: ['id'],
        guards: {'auth': true},
      );

      expect(r['path'], equals('/users/:id'));
      expect(r['page'], isA<Map>());
      expect(r['params'], isA<List>());
      expect(r['guards'], isA<Map>());
    });

    test('Boundary: path and page only', () {
      final r = MCPUIJsonGenerator.route(
        path: '/home',
        page: MCPUIJsonGenerator.page(
          title: 'Home',
          content: MCPUIJsonGenerator.text('Home'),
        ),
      );

      expect(r['path'], equals('/home'));
      expect(r['page'], isA<Map>());
      expect(r.containsKey('params'), isFalse);
    });
  });

  // TC-141: MCPUIJsonGenerator.routeParam and routeQuery
  group('TC-141: MCPUIJsonGenerator.routeParam and routeQuery', () {
    test('Normal: routeParam returns binding string', () {
      expect(
        MCPUIJsonGenerator.routeParam('id'),
        equals('{{route.params.id}}'),
      );
    });

    test('Normal: routeQuery returns binding string', () {
      expect(
        MCPUIJsonGenerator.routeQuery('page'),
        equals('{{route.query.page}}'),
      );
    });
  });

  // TC-142: MCPUIJsonGenerator.lifecycle
  group('TC-142: MCPUIJsonGenerator.lifecycle', () {
    test('Normal: produces complete lifecycle map', () {
      final l = MCPUIJsonGenerator.lifecycle(
        onInit: [MCPUIJsonGenerator.toolAction('init')],
        onDestroy: [MCPUIJsonGenerator.toolAction('cleanup')],
        onResume: [MCPUIJsonGenerator.toolAction('resume')],
        onPause: [MCPUIJsonGenerator.toolAction('pause')],
      );

      expect(l['onInit'], isA<List>());
      expect(l['onDestroy'], isA<List>());
      expect(l['onResume'], isA<List>());
      expect(l['onPause'], isA<List>());
    });

    test('Boundary: empty lifecycle', () {
      final l = MCPUIJsonGenerator.lifecycle();

      expect(l.containsKey('onInit'), isFalse);
      expect(l.containsKey('onDestroy'), isFalse);
    });
  });

  // TC-143: MCPUIJsonGenerator.onInit and onDestroy
  group('TC-143: MCPUIJsonGenerator.onInit and onDestroy', () {
    test('Normal: onInit produces init hook map', () {
      final h = MCPUIJsonGenerator.onInit([
        MCPUIJsonGenerator.toolAction('loadData'),
        MCPUIJsonGenerator.stateAction(action: 'set', binding: 'ready', value: true),
      ]);

      expect(h['onInit'], isA<List>());
      expect((h['onInit'] as List).length, equals(2));
    });

    test('Normal: onDestroy produces destroy hook map', () {
      final h = MCPUIJsonGenerator.onDestroy([
        MCPUIJsonGenerator.toolAction('cleanup'),
      ]);

      expect(h['onDestroy'], isA<List>());
    });

    test('Boundary: empty actions list', () {
      final h = MCPUIJsonGenerator.onInit([]);

      expect(h['onInit'], isA<List>());
      expect((h['onInit'] as List).length, equals(0));
    });
  });

  // TC-144: MCPUIJsonGenerator.onResume and onPause
  group('TC-144: MCPUIJsonGenerator.onResume and onPause', () {
    test('Normal: onResume produces resume hook map', () {
      final h = MCPUIJsonGenerator.onResume([
        MCPUIJsonGenerator.toolAction('refresh'),
      ]);

      expect(h['onResume'], isA<List>());
    });

    test('Normal: onPause produces pause hook map', () {
      final h = MCPUIJsonGenerator.onPause([
        MCPUIJsonGenerator.toolAction('save'),
      ]);

      expect(h['onPause'], isA<List>());
    });

    test('Boundary: empty actions list', () {
      final h = MCPUIJsonGenerator.onResume([]);

      expect(h['onResume'], isA<List>());
      expect((h['onResume'] as List).length, equals(0));
    });
  });
}
