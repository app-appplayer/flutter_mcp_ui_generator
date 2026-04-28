import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-178: MCPUIJsonGenerator.clientBinding
  group('TC-178: MCPUIJsonGenerator.clientBinding', () {
    test('Normal: produces client binding', () {
      expect(
        MCPUIJsonGenerator.clientBinding('platform'),
        equals('{{client.platform}}'),
      );
    });

    test('Boundary: nested path', () {
      expect(
        MCPUIJsonGenerator.clientBinding('theme.background'),
        equals('{{client.theme.background}}'),
      );
    });
  });

  // TC-179: MCPUIJsonGenerator.clientWorkingDirectory
  group('TC-179: MCPUIJsonGenerator.clientWorkingDirectory', () {
    test('Normal: returns working directory binding', () {
      expect(
        MCPUIJsonGenerator.clientWorkingDirectory(),
        equals('{{client.workingDirectory}}'),
      );
    });
  });

  // TC-180: MCPUIJsonGenerator.clientUserName
  group('TC-180: MCPUIJsonGenerator.clientUserName', () {
    test('Normal: returns user name binding', () {
      expect(
        MCPUIJsonGenerator.clientUserName(),
        equals('{{client.userName}}'),
      );
    });
  });

  // TC-181: MCPUIJsonGenerator.clientPlatform
  group('TC-181: MCPUIJsonGenerator.clientPlatform', () {
    test('Normal: returns platform binding', () {
      expect(
        MCPUIJsonGenerator.clientPlatform(),
        equals('{{client.platform}}'),
      );
    });
  });

  // TC-182: MCPUIJsonGenerator.clientLocale
  group('TC-182: MCPUIJsonGenerator.clientLocale', () {
    test('Normal: returns locale binding', () {
      expect(
        MCPUIJsonGenerator.clientLocale(),
        equals('{{client.locale}}'),
      );
    });
  });

  // TC-183: MCPUIJsonGenerator.clientTheme
  group('TC-183: MCPUIJsonGenerator.clientTheme', () {
    test('Normal: returns client theme property binding', () {
      expect(
        MCPUIJsonGenerator.clientTheme('background'),
        equals('{{client.theme.background}}'),
      );
    });

    test('Boundary: nested property path', () {
      expect(
        MCPUIJsonGenerator.clientTheme('colors.primary'),
        equals('{{client.theme.colors.primary}}'),
      );
    });
  });

  // TC-184: MCPUIJsonGenerator.permissionBinding
  group('TC-184: MCPUIJsonGenerator.permissionBinding', () {
    test('Normal: returns permission binding', () {
      expect(
        MCPUIJsonGenerator.permissionBinding('file.read'),
        equals('{{permissions.file.read}}'),
      );
    });

    test('Boundary: nested path', () {
      expect(
        MCPUIJsonGenerator.permissionBinding('network.http.domains'),
        equals('{{permissions.network.http.domains}}'),
      );
    });
  });

  // TC-185: MCPUIJsonGenerator.channelBinding
  group('TC-185: MCPUIJsonGenerator.channelBinding', () {
    test('Normal: returns channel data binding', () {
      expect(
        MCPUIJsonGenerator.channelBinding('systemMonitor', 'cpu'),
        equals('{{channels.systemMonitor.cpu}}'),
      );
    });

    test('Boundary: different channel/property combinations', () {
      expect(
        MCPUIJsonGenerator.channelBinding('fileWatch', 'lastEvent'),
        equals('{{channels.fileWatch.lastEvent}}'),
      );
    });
  });
}
