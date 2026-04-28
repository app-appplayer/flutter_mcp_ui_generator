import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-159: MCPUIJsonGenerator.clientSelectFile
  group('TC-159: MCPUIJsonGenerator.clientSelectFile', () {
    test('Normal: produces client.selectFile action map', () {
      final a = MCPUIJsonGenerator.clientSelectFile(
        title: 'Select',
        filters: [
          {'name': 'Images', 'extensions': ['png', 'jpg']},
        ],
        defaultPath: '/home',
        multiple: false,
        onSuccess: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'file',
          value: '{{event.value}}',
        ),
      );

      expect(a['type'], equals('client.selectFile'));
      expect(a['title'], equals('Select'));
      expect(a['filters'], isA<List>());
      expect(a['defaultPath'], equals('/home'));
      expect(a['multiple'], isFalse);
      expect(a['onSuccess'], isA<Map>());
    });

    test('Boundary: no optional params', () {
      final a = MCPUIJsonGenerator.clientSelectFile();

      expect(a['type'], equals('client.selectFile'));
    });
  });

  // TC-160: MCPUIJsonGenerator.clientReadFile
  group('TC-160: MCPUIJsonGenerator.clientReadFile', () {
    test('Normal: produces client.readFile action map', () {
      final a = MCPUIJsonGenerator.clientReadFile(
        path: '{{file}}',
        encoding: 'utf-8',
        onSuccess: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'content',
        ),
        onError: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'error',
          value: '{{event.value}}',
        ),
      );

      expect(a['type'], equals('client.readFile'));
      expect(a['path'], equals('{{file}}'));
      expect(a['encoding'], equals('utf-8'));
      expect(a['onSuccess'], isA<Map>());
      expect(a['onError'], isA<Map>());
    });

    test('Boundary: path only', () {
      final a = MCPUIJsonGenerator.clientReadFile(path: '/tmp/data.txt');

      expect(a['type'], equals('client.readFile'));
      expect(a['path'], equals('/tmp/data.txt'));
    });
  });

  // TC-161: MCPUIJsonGenerator.clientWriteFile
  group('TC-161: MCPUIJsonGenerator.clientWriteFile', () {
    test('Normal: produces client.writeFile action map', () {
      final a = MCPUIJsonGenerator.clientWriteFile(
        path: '{{file}}',
        content: 'data',
        confirmMessage: 'Save?',
        onSuccess: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'saved',
          value: true,
        ),
      );

      expect(a['type'], equals('client.writeFile'));
      expect(a['path'], equals('{{file}}'));
      expect(a['content'], equals('data'));
      expect(a['confirmMessage'], equals('Save?'));
    });

    test('Boundary: path and content only', () {
      final a = MCPUIJsonGenerator.clientWriteFile(
        path: '/tmp/out.txt',
        content: 'hello',
      );

      expect(a['type'], equals('client.writeFile'));
    });
  });

  // TC-162: MCPUIJsonGenerator.clientSaveFile
  group('TC-162: MCPUIJsonGenerator.clientSaveFile', () {
    test('Normal: produces client.saveFile action map', () {
      final a = MCPUIJsonGenerator.clientSaveFile(
        content: 'file data',
        defaultName: 'output.txt',
        filters: [
          {'name': 'Text', 'extensions': ['txt']},
        ],
        onSuccess: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'saved',
          value: true,
        ),
      );

      expect(a['type'], equals('client.saveFile'));
      expect(a['content'], equals('file data'));
      expect(a['defaultName'], equals('output.txt'));
    });

    test('Boundary: minimal params', () {
      final a = MCPUIJsonGenerator.clientSaveFile(content: 'data');

      expect(a['type'], equals('client.saveFile'));
    });
  });

  // TC-163: MCPUIJsonGenerator.clientListFiles
  group('TC-163: MCPUIJsonGenerator.clientListFiles', () {
    test('Normal: produces client.listFiles action map', () {
      final a = MCPUIJsonGenerator.clientListFiles(
        path: './data',
        pattern: '*.json',
        recursive: true,
        onSuccess: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'files',
        ),
      );

      expect(a['type'], equals('client.listFiles'));
      expect(a['path'], equals('./data'));
      expect(a['pattern'], equals('*.json'));
      expect(a['recursive'], isTrue);
    });

    test('Boundary: path only', () {
      final a = MCPUIJsonGenerator.clientListFiles(path: './');

      expect(a['type'], equals('client.listFiles'));
      expect(a['path'], equals('./'));
    });
  });

  // TC-164: MCPUIJsonGenerator.clientHttpRequest
  group('TC-164: MCPUIJsonGenerator.clientHttpRequest', () {
    test('Normal: GET request with headers', () {
      final a = MCPUIJsonGenerator.clientHttpRequest(
        url: 'https://api.example.com/data',
        method: 'GET',
        headers: {'Authorization': 'Bearer token'},
        onSuccess: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'data',
        ),
      );

      expect(a['type'], equals('client.httpRequest'));
      expect(a['url'], equals('https://api.example.com/data'));
      expect(a['method'], equals('GET'));
      expect(a['headers'], isA<Map>());
    });

    test('Normal: POST request with body', () {
      final a = MCPUIJsonGenerator.clientHttpRequest(
        url: 'https://api.example.com/submit',
        method: 'POST',
        body: {'key': 'value'},
      );

      expect(a['method'], equals('POST'));
      expect(a['body'], isA<Map>());
    });

    test('Boundary: URL and method only', () {
      final a = MCPUIJsonGenerator.clientHttpRequest(
        url: 'https://api.example.com',
      );

      expect(a['type'], equals('client.httpRequest'));
      expect(a['method'], equals('GET'));
    });
  });

  // TC-165: MCPUIJsonGenerator.clientGetSystemInfo
  group('TC-165: MCPUIJsonGenerator.clientGetSystemInfo', () {
    test('Normal: produces client.getSystemInfo action map', () {
      final a = MCPUIJsonGenerator.clientGetSystemInfo(
        properties: ['platform', 'memory'],
        onSuccess: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'sysInfo',
        ),
      );

      expect(a['type'], equals('client.getSystemInfo'));
      expect(a['properties'], isA<List>());
      expect((a['properties'] as List).length, equals(2));
    });

    test('Boundary: single property', () {
      final a = MCPUIJsonGenerator.clientGetSystemInfo(
        properties: ['platform'],
      );

      expect((a['properties'] as List).length, equals(1));
    });
  });

  // TC-166: MCPUIJsonGenerator.clientExec
  group('TC-166: MCPUIJsonGenerator.clientExec', () {
    test('Normal: produces client.exec action map', () {
      final a = MCPUIJsonGenerator.clientExec(
        command: 'ls',
        args: ['-la'],
        cwd: '/tmp',
        timeout: 5000,
        requireConfirmation: true,
      );

      expect(a['type'], equals('client.exec'));
      expect(a['command'], equals('ls'));
      expect(a['args'], equals(['-la']));
      expect(a['cwd'], equals('/tmp'));
      expect(a['timeout'], equals(5000));
      expect(a['requireConfirmation'], isTrue);
    });

    test('Boundary: command only', () {
      final a = MCPUIJsonGenerator.clientExec(command: 'whoami');

      expect(a['type'], equals('client.exec'));
      expect(a['command'], equals('whoami'));
    });
  });
}
