import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  group('Sub-action helpers added in 0.4.0', () {
    test('parallelAction', () {
      final a = MCPUIJsonGenerator.parallelAction(actions: [
        MCPUIJsonGenerator.toolAction('a'),
        MCPUIJsonGenerator.toolAction('b'),
      ]);

      expect(a['type'], equals('parallel'));
      expect((a['actions'] as List).length, equals(2));
    });

    test('sequenceAction', () {
      final a = MCPUIJsonGenerator.sequenceAction(actions: [
        MCPUIJsonGenerator.toolAction('first'),
      ]);
      expect(a['type'], equals('sequence'));
      expect((a['actions'] as List).length, equals(1));
    });

    test('cancelAction', () {
      final a = MCPUIJsonGenerator.cancelAction(actionId: 'tx-42');
      expect(a, equals({'type': 'cancel', 'actionId': 'tx-42'}));
    });

    test('notificationAction with optional fields', () {
      final a = MCPUIJsonGenerator.notificationAction(
        message: 'Saved',
        severity: 'success',
        durationMs: 2000,
      );

      expect(a['type'], equals('notification'));
      expect(a['severity'], equals('success'));
      expect(a['duration'], equals(2000));
    });

    test('notificationAction omits unspecified optionals', () {
      final a = MCPUIJsonGenerator.notificationAction(message: 'x');
      expect(a.containsKey('severity'), isFalse);
      expect(a.containsKey('duration'), isFalse);
    });

    test('animationAction', () {
      final a = MCPUIJsonGenerator.animationAction(
        target: 'card',
        animation: 'fadeOut',
        durationMs: 250,
      );

      expect(a['type'], equals('animation'));
      expect(a['target'], equals('card'));
      expect(a['animation'], equals('fadeOut'));
    });

    test('dialogAction wraps the inner dialog map', () {
      final a = MCPUIJsonGenerator.dialogAction(
        dialog: {'type': 'alertDialog', 'title': 'Hi'},
      );

      expect(a['type'], equals('dialog'));
      expect((a['dialog'] as Map)['type'], equals('alertDialog'));
    });

    test('permissionRevokeAction', () {
      final a = MCPUIJsonGenerator.permissionRevokeAction(
        permission: 'camera',
      );
      expect(a, equals({'type': 'permission.revoke', 'permission': 'camera'}));
    });
  });

  group('Client action helpers added in 0.4.0', () {
    test('clientClipboardAction', () {
      expect(
        MCPUIJsonGenerator.clientClipboardAction(operation: 'read'),
        equals({'type': 'client.clipboard', 'operation': 'read'}),
      );
      expect(
        MCPUIJsonGenerator.clientClipboardAction(
            operation: 'write', value: 'hello'),
        equals({
          'type': 'client.clipboard',
          'operation': 'write',
          'value': 'hello',
        }),
      );
    });

    test('clientNotificationAction', () {
      final a = MCPUIJsonGenerator.clientNotificationAction(
        title: 'Reminder',
        body: 'Stand up',
        icon: 'bell',
      );
      expect(a['type'], equals('client.notification'));
      expect(a['title'], equals('Reminder'));
    });

    test('clientStorageGet/Set/Remove', () {
      expect(
        MCPUIJsonGenerator.clientStorageGetAction(key: 'k', binding: 'k'),
        equals({'type': 'client.storage.get', 'key': 'k', 'binding': 'k'}),
      );
      expect(
        MCPUIJsonGenerator.clientStorageSetAction(key: 'k', value: 1),
        equals({'type': 'client.storage.set', 'key': 'k', 'value': 1}),
      );
      expect(
        MCPUIJsonGenerator.clientStorageRemoveAction(key: 'k'),
        equals({'type': 'client.storage.remove', 'key': 'k'}),
      );
    });
  });

  group('websocketChannel (5th channel type)', () {
    test('emits client.websocket with url', () {
      final ch = MCPUIJsonGenerator.websocketChannel(
        url: 'wss://example.com/data',
      );
      expect(ch['type'], equals('client.websocket'));
      expect(ch['url'], equals('wss://example.com/data'));
      expect(ch.containsKey('params'), isFalse);
    });

    test('packs protocols / headers under params', () {
      final ch = MCPUIJsonGenerator.websocketChannel(
        url: 'wss://x/y',
        protocols: ['json-v1'],
        headers: {'Authorization': 'Bearer xyz'},
      );

      expect(ch['params']['protocols'], equals(['json-v1']));
      expect((ch['params']['headers'] as Map)['Authorization'],
          equals('Bearer xyz'));
    });
  });

  group('ApplicationBuilder fluent setters added in 0.4.0', () {
    test('i18n — emits canonical block', () {
      final app = MCPUIBuilder.application(title: 'X', version: '1.0')
          .i18n(
            defaultLocale: 'en',
            locales: ['en', 'ko'],
            text: {
              'en': {'hi': 'Hello'},
              'ko': {'hi': '안녕'},
            },
          )
          .build();

      final i18n = app['i18n'] as Map;
      expect(i18n['defaultLocale'], equals('en'));
      expect(i18n['locales'], equals(['en', 'ko']));
      expect(i18n['text'], isA<Map>());
    });

    test('services — passes through map', () {
      final app = MCPUIBuilder.application(title: 'X', version: '1.0')
          .services({
            'tick': {'kind': 'polling', 'tool': 'now', 'interval': 1000},
          })
          .build();

      expect((app['services'] as Map)['tick'], isA<Map>());
    });

    test('templateLibraries — list of refs', () {
      final app = MCPUIBuilder.application(title: 'X', version: '1.0')
          .templateLibraries([
            {'uri': 'https://lib/a.json', 'integrity': 'sha256-…'},
          ])
          .build();

      final libs = app['templateLibraries'] as List;
      expect(libs.length, equals(1));
      expect((libs[0] as Map)['uri'], equals('https://lib/a.json'));
    });
  });
}
