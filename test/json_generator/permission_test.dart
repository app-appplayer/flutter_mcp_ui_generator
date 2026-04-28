import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-167: MCPUIJsonGenerator.permissions
  group('TC-167: MCPUIJsonGenerator.permissions', () {
    test('Normal: produces permissions declaration with all types', () {
      final p = MCPUIJsonGenerator.permissions(
        file: MCPUIJsonGenerator.filePermissions(
          read: {'paths': ['./config']},
        ),
        network: MCPUIJsonGenerator.networkPermissions(
          http: {'domains': ['api.example.com']},
        ),
        system: MCPUIJsonGenerator.systemPermissions(
          info: ['platform'],
        ),
      );

      expect(p['permissions'], isA<Map>());
      final perms = p['permissions'] as Map;
      expect(perms['file'], isA<Map>());
      expect(perms['network'], isA<Map>());
      expect(perms['system'], isA<Map>());
    });

    test('Boundary: single permission type only', () {
      final p = MCPUIJsonGenerator.permissions(
        file: MCPUIJsonGenerator.filePermissions(
          read: {'paths': ['./data']},
        ),
      );

      final perms = p['permissions'] as Map;
      expect(perms['file'], isA<Map>());
      expect(perms.containsKey('network'), isFalse);
    });
  });

  // TC-168: MCPUIJsonGenerator.filePermissions
  group('TC-168: MCPUIJsonGenerator.filePermissions', () {
    test('Normal: produces file permission map', () {
      final fp = MCPUIJsonGenerator.filePermissions(
        read: {'paths': ['./config'], 'extensions': ['json']},
        write: {'paths': ['./output'], 'maxSize': '10MB'},
      );

      expect(fp['read'], isA<Map>());
      expect(fp['write'], isA<Map>());
    });

    test('Boundary: read only', () {
      final fp = MCPUIJsonGenerator.filePermissions(
        read: {'paths': ['./data']},
      );

      expect(fp['read'], isA<Map>());
      expect(fp.containsKey('write'), isFalse);
    });
  });

  // TC-169: MCPUIJsonGenerator.networkPermissions
  group('TC-169: MCPUIJsonGenerator.networkPermissions', () {
    test('Normal: produces network permission map', () {
      final np = MCPUIJsonGenerator.networkPermissions(
        http: {'domains': ['api.example.com', '*.mydomain.com']},
      );

      expect(np['http'], isA<Map>());
    });

    test('Boundary: empty domain list', () {
      final np = MCPUIJsonGenerator.networkPermissions(
        http: {'domains': <String>[]},
      );

      expect(np['http'], isA<Map>());
    });
  });

  // TC-170: MCPUIJsonGenerator.systemPermissions
  group('TC-170: MCPUIJsonGenerator.systemPermissions', () {
    test('Normal: produces system permission map', () {
      final sp = MCPUIJsonGenerator.systemPermissions(
        info: ['platform', 'memory'],
        exec: {'commands': ['ls', 'cat']},
      );

      expect(sp['info'], isA<List>());
      expect(sp['exec'], isA<Map>());
    });

    test('Boundary: info only', () {
      final sp = MCPUIJsonGenerator.systemPermissions(
        info: ['platform'],
      );

      expect(sp['info'], isA<List>());
      expect(sp.containsKey('exec'), isFalse);
    });
  });

  // TC-171: MCPUIJsonGenerator.permissionPrompt
  group('TC-171: MCPUIJsonGenerator.permissionPrompt', () {
    test('Normal: produces permissionPrompt widget map', () {
      final w = MCPUIJsonGenerator.permissionPrompt(
        permissions: ['file.read', 'network.http'],
        title: 'Access Required',
        message: 'This app needs access to files and network.',
        remember: true,
      );

      expect(w['type'], equals('permissionPrompt'));
      expect(w['permissions'], isA<List>());
      expect(w['title'], equals('Access Required'));
      expect(w['remember'], isTrue);
    });

    test('Boundary: minimal params', () {
      final w = MCPUIJsonGenerator.permissionPrompt(
        permissions: ['file.read'],
      );

      expect(w['type'], equals('permissionPrompt'));
      expect((w['permissions'] as List).length, equals(1));
    });
  });
}
