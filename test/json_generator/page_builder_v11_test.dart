import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-186: PageBuilder.version
  group('TC-186: PageBuilder.version', () {
    test('Normal: sets DSL version in output', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .version('1.1')
          .content(MCPUIJsonGenerator.text('Hello'))
          .build();

      expect(page['version'], equals('1.1'));
    });

    test('Boundary: version 1.0', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .version('1.0')
          .content(MCPUIJsonGenerator.text('Hello'))
          .build();

      expect(page['version'], equals('1.0'));
    });
  });

  // TC-187: PageBuilder.permissions
  group('TC-187: PageBuilder.permissions', () {
    test('Normal: declares permissions in page output', () {
      final perms = MCPUIJsonGenerator.permissions(
        file: MCPUIJsonGenerator.filePermissions(
          read: {'paths': ['./config']},
        ),
      );

      final page = MCPUIBuilder.page(title: 'File Manager')
          .permissions(perms)
          .content(MCPUIJsonGenerator.text('Files'))
          .build();

      expect(page['permissions'], isA<Map>());
    });

    test('Boundary: empty permissions map', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .permissions({})
          .content(MCPUIJsonGenerator.text('Test'))
          .build();

      // Empty map or permissions key present
      expect(page.containsKey('permissions'), isTrue);
    });
  });

  // TC-188: PageBuilder.channels
  group('TC-188: PageBuilder.channels', () {
    test('Normal: declares channels in page output', () {
      final channelDefs = MCPUIJsonGenerator.channels({
        'fileWatch': MCPUIJsonGenerator.watchFileChannel(path: './data.json'),
      });

      final page = MCPUIBuilder.page(title: 'Monitor')
          .channels(channelDefs)
          .content(MCPUIJsonGenerator.text('Monitoring'))
          .build();

      expect(page['channels'], isA<Map>());
    });

    test('Boundary: empty channels map', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .channels({})
          .content(MCPUIJsonGenerator.text('Test'))
          .build();

      expect(page.containsKey('channels'), isTrue);
    });
  });

  // TC-189: PageBuilder v1.1 — complete build
  group('TC-189: PageBuilder v1.1 — complete build', () {
    test('Normal: complete v1.1 page with all extensions', () {
      final perms = MCPUIJsonGenerator.permissions(
        file: MCPUIJsonGenerator.filePermissions(
          read: {'paths': ['./']},
          write: {'paths': ['./output']},
        ),
        network: MCPUIJsonGenerator.networkPermissions(
          http: {'domains': ['api.example.com']},
        ),
      );

      final channelDefs = MCPUIJsonGenerator.channels({
        'fileWatch': MCPUIJsonGenerator.watchFileChannel(
          path: './config.json',
          events: ['change'],
        ),
        'monitor': MCPUIJsonGenerator.systemMonitorChannel(
          metrics: ['cpu'],
        ),
      });

      final page = MCPUIBuilder.page(title: 'File Manager')
          .version('1.1')
          .permissions(perms)
          .channels(channelDefs)
          .content(MCPUIJsonGenerator.text('File Manager'))
          .build();

      expect(page['type'], equals('page'));
      expect(page['title'], equals('File Manager'));
      expect(page['version'], equals('1.1'));
      expect(page['permissions'], isA<Map>());
      expect(page['channels'], isA<Map>());
      expect(page['content'], isA<Map>());
    });

    test('Boundary: v1.1 with permissions but no channels', () {
      final perms = MCPUIJsonGenerator.permissions(
        file: MCPUIJsonGenerator.filePermissions(
          read: {'paths': ['./']},
        ),
      );

      final page = MCPUIBuilder.page(title: 'Reader')
          .version('1.1')
          .permissions(perms)
          .content(MCPUIJsonGenerator.text('Reader'))
          .build();

      expect(page['version'], equals('1.1'));
      expect(page['permissions'], isA<Map>());
      expect(page.containsKey('channels'), isFalse);
    });
  });
}
