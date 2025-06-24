import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  group('Actions', () {
    test('toolAction', () {
      final action = MCPUIJsonGenerator.toolAction(
        'submitForm',
        params: {'data': 'test'},
      );

      expect(action['type'], equals('tool'));
      expect(action['name'], equals('submitForm'));
      expect(action['params'], isA<Map>());
    });

    test('stateAction', () {
      final action = MCPUIJsonGenerator.stateAction(
        action: 'set',
        path: 'user.name',
        value: 'John',
      );

      expect(action['type'], equals('state'));
      expect(action['action'], equals('set'));
      expect(action['path'], equals('user.name'));
      expect(action['value'], equals('John'));
    });

    test('navigationAction', () {
      final action = MCPUIJsonGenerator.navigationAction(
        action: 'push',
        route: '/details',
        params: {'id': '123'},
      );

      expect(action['type'], equals('navigation'));
      expect(action['action'], equals('push'));
      expect(action['route'], equals('/details'));
      expect(action['params'], isA<Map>());
    });

    test('resourceAction', () {
      final action = MCPUIJsonGenerator.resourceAction(
        action: 'subscribe',
        uri: 'data://temperature',
        target: 'currentTemp',
      );

      expect(action['type'], equals('resource'));
      expect(action['action'], equals('subscribe'));
      expect(action['uri'], equals('data://temperature'));
      expect(action['target'], equals('currentTemp'));
    });

    test('batchAction', () {
      final action = MCPUIJsonGenerator.batchAction(
        actions: [
          MCPUIJsonGenerator.stateAction(
            action: 'set',
            path: 'loading',
            value: true,
          ),
          MCPUIJsonGenerator.toolAction('loadData'),
        ],
      );

      expect(action['type'], equals('batch'));
      expect(action['actions'], isA<List>());
      expect(action['actions'].length, equals(2));
    });

    test('conditionalAction', () {
      final action = MCPUIJsonGenerator.conditionalAction(
        condition: '{{isLoggedIn}}',
        then: MCPUIJsonGenerator.navigationAction(
          action: 'push',
          route: '/home',
        ),
        orElse: MCPUIJsonGenerator.navigationAction(
          action: 'push',
          route: '/login',
        ),
      );

      expect(action['type'], equals('conditional'));
      expect(action['condition'], equals('{{isLoggedIn}}'));
      expect(action['then'], isA<Map>());
      expect(action['else'], isA<Map>());
    });
  });
}