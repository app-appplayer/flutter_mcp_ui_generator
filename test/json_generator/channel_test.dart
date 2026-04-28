import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-172: MCPUIJsonGenerator.channels
  group('TC-172: MCPUIJsonGenerator.channels', () {
    test('Normal: produces channels declaration map', () {
      final c = MCPUIJsonGenerator.channels({
        'fileWatch': MCPUIJsonGenerator.watchFileChannel(path: './config.json'),
        'monitor': MCPUIJsonGenerator.systemMonitorChannel(
          metrics: ['cpu', 'memory'],
        ),
      });

      expect(c['channels'], isA<Map>());
      final channels = c['channels'] as Map;
      expect(channels['fileWatch'], isA<Map>());
      expect(channels['monitor'], isA<Map>());
    });

    test('Boundary: single channel', () {
      final c = MCPUIJsonGenerator.channels({
        'watch': MCPUIJsonGenerator.watchFileChannel(path: './data.json'),
      });

      final channels = c['channels'] as Map;
      expect(channels.length, equals(1));
    });
  });

  // TC-173: MCPUIJsonGenerator.watchFileChannel
  group('TC-173: MCPUIJsonGenerator.watchFileChannel', () {
    test('Normal: produces client.watchFile channel map', () {
      final ch = MCPUIJsonGenerator.watchFileChannel(
        path: './config.json',
        events: ['change', 'rename', 'delete'],
      );

      expect(ch['type'], equals('client.watchFile'));
      expect(ch['path'], equals('./config.json'));
      expect(ch['events'], isA<List>());
      expect((ch['events'] as List).length, equals(3));
    });

    test('Boundary: path only', () {
      final ch = MCPUIJsonGenerator.watchFileChannel(path: './data.json');

      expect(ch['type'], equals('client.watchFile'));
      expect(ch['path'], equals('./data.json'));
      expect(ch.containsKey('events'), isFalse);
    });
  });

  // TC-174: MCPUIJsonGenerator.watchDirectoryChannel
  group('TC-174: MCPUIJsonGenerator.watchDirectoryChannel', () {
    test('Normal: produces client.watchDirectory channel map', () {
      final ch = MCPUIJsonGenerator.watchDirectoryChannel(
        path: '{{currentDir}}',
        recursive: false,
      );

      expect(ch['type'], equals('client.watchDirectory'));
      expect(ch['path'], equals('{{currentDir}}'));
      expect(ch['recursive'], isFalse);
    });

    test('Boundary: path only', () {
      final ch = MCPUIJsonGenerator.watchDirectoryChannel(path: './');

      expect(ch['type'], equals('client.watchDirectory'));
    });
  });

  // TC-175: MCPUIJsonGenerator.systemMonitorChannel
  group('TC-175: MCPUIJsonGenerator.systemMonitorChannel', () {
    test('Normal: produces client.systemMonitor channel map', () {
      final ch = MCPUIJsonGenerator.systemMonitorChannel(
        metrics: ['cpu', 'memory'],
        interval: 1000,
      );

      expect(ch['type'], equals('client.systemMonitor'));
      expect(ch['metrics'], isA<List>());
      expect(ch['interval'], equals(1000));
    });

    test('Boundary: single metric', () {
      final ch = MCPUIJsonGenerator.systemMonitorChannel(
        metrics: ['cpu'],
      );

      expect((ch['metrics'] as List).length, equals(1));
    });
  });

  // TC-176: MCPUIJsonGenerator.pollChannel
  group('TC-176: MCPUIJsonGenerator.pollChannel', () {
    test('Normal: produces client.poll channel map', () {
      final ch = MCPUIJsonGenerator.pollChannel(
        action: MCPUIJsonGenerator.clientHttpRequest(
          url: 'https://api.example.com/status',
        ),
        interval: 5000,
        binding: 'apiStatus',
      );

      expect(ch['type'], equals('client.poll'));
      expect(ch['action'], isA<Map>());
      expect(ch['interval'], equals(5000));
      expect(ch['binding'], equals('apiStatus'));
    });

    test('Boundary: action and interval only', () {
      final ch = MCPUIJsonGenerator.pollChannel(
        action: MCPUIJsonGenerator.toolAction('check'),
        interval: 3000,
      );

      expect(ch['type'], equals('client.poll'));
      expect(ch.containsKey('binding'), isFalse);
    });
  });

  // TC-177: MCPUIJsonGenerator.channelAction
  group('TC-177: MCPUIJsonGenerator.channelAction', () {
    test('Normal: start action', () {
      final a = MCPUIJsonGenerator.channelAction(
        channel: 'systemMonitor',
        action: 'start',
      );

      expect(a['type'], equals('channel.start'));
      expect(a['channel'], equals('systemMonitor'));
    });

    test('Normal: stop action', () {
      final a = MCPUIJsonGenerator.channelAction(
        channel: 'fileWatch',
        action: 'stop',
      );

      expect(a['type'], equals('channel.stop'));
    });

    test('Normal: toggle action', () {
      final a = MCPUIJsonGenerator.channelAction(
        channel: 'monitor',
        action: 'toggle',
      );

      expect(a['type'], equals('channel.toggle'));
    });
  });
}
