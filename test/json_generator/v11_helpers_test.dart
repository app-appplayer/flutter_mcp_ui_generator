import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-123~131: Binding & Expression helpers
  group('TC-123~131: Binding & Expression helpers', () {
    test('Normal: binding creates expression', () {
      expect(MCPUIJsonGenerator.binding('count'), equals('{{count}}'));
    });

    test('Normal: localState creates local binding', () {
      expect(MCPUIJsonGenerator.localState('expanded'), equals('{{local.expanded}}'));
    });

    test('Normal: appState creates app binding', () {
      expect(MCPUIJsonGenerator.appState('user.name'), equals('{{app.user.name}}'));
    });

    test('Normal: themeBinding creates theme binding', () {
      expect(MCPUIJsonGenerator.themeBinding('colors.primary'), equals('{{theme.colors.primary}}'));
    });

    test('Normal: routeState creates route binding', () {
      expect(MCPUIJsonGenerator.routeState('params.id'), equals('{{route.params.id}}'));
    });

    test('Normal: conditional creates ternary expression', () {
      final result = MCPUIJsonGenerator.conditional('x > 0', 'yes', 'no');
      expect(result, contains('x > 0'));
    });

    test('Normal: computed creates computed expression', () {
      final result = MCPUIJsonGenerator.computed('a + b');
      expect(result, contains('a + b'));
    });

    test('Normal: themeColor creates theme color binding', () {
      final result = MCPUIJsonGenerator.themeColor('primary');
      expect(result, contains('theme'));
      expect(result, contains('primary'));
    });

    test('Boundary: nested path binding', () {
      expect(MCPUIJsonGenerator.binding('deeply.nested.path'), equals('{{deeply.nested.path}}'));
    });
  });

  // TC-136~139: Event helpers
  group('TC-136~139: Event helpers', () {
    test('Normal: eventValue', () {
      expect(MCPUIJsonGenerator.eventValue(), equals('{{event.value}}'));
    });

    test('Normal: eventIndex', () {
      expect(MCPUIJsonGenerator.eventIndex(), equals('{{event.index}}'));
    });

    test('Normal: eventChecked', () {
      expect(MCPUIJsonGenerator.eventChecked(), equals('{{event.checked}}'));
    });

    test('Normal: eventData with field', () {
      expect(MCPUIJsonGenerator.eventData('field'), equals('{{event.field}}'));
    });
  });

  // TC-140~143: Route & Lifecycle helpers
  group('TC-140~143: Route & Lifecycle helpers', () {
    test('Normal: routeParam', () {
      final result = MCPUIJsonGenerator.routeParam('id');
      expect(result, contains('route'));
      expect(result, contains('id'));
    });

    test('Normal: routeQuery', () {
      final result = MCPUIJsonGenerator.routeQuery('page');
      expect(result, contains('route'));
      expect(result, contains('page'));
    });

    test('Normal: onInit creates lifecycle hook', () {
      final actions = [
        MCPUIJsonGenerator.toolAction('loadData'),
      ];
      final hook = MCPUIJsonGenerator.onInit(actions);
      expect(hook, isNotNull);
    });

    test('Normal: onDestroy creates lifecycle hook', () {
      final actions = [
        MCPUIJsonGenerator.toolAction('cleanup'),
      ];
      final hook = MCPUIJsonGenerator.onDestroy(actions);
      expect(hook, isNotNull);
    });
  });

  // TC-145~147: Accessibility helpers
  group('TC-145~147: Accessibility helpers', () {
    test('Normal: withAccessibility wraps widget', () {
      final widget = MCPUIJsonGenerator.text('Hello');
      final accessible = MCPUIJsonGenerator.withAccessibility(
        widget,
        label: 'Greeting text',
        description: 'Displays greeting',
        role: 'text',
      );

      expect(accessible['label'], equals('Greeting text'));
      expect(accessible['role'], equals('text'));
    });

    test('Boundary: only label provided', () {
      final widget = MCPUIJsonGenerator.text('Hello');
      final accessible = MCPUIJsonGenerator.withAccessibility(
        widget,
        label: 'Greeting',
      );

      expect(accessible['label'], equals('Greeting'));
    });

    test('Normal: accessibleButton', () {
      final button = MCPUIJsonGenerator.accessibleButton(
        label: 'Submit',
        click: MCPUIJsonGenerator.toolAction('submit'),
        accessibilityLabel: 'Submit form',
      );

      expect(button['type'], equals('button'));
      expect(button['label'], equals('Submit form'));
    });

    test('Normal: accessibleTextInput', () {
      final input = MCPUIJsonGenerator.accessibleTextInput(
        label: 'Email',
        value: '{{email}}',
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 'email', value: '{{event.value}}'),
        accessibilityLabel: 'Email address input',
      );

      expect(input['type'], equals('textInput'));
      expect(input['label'], equals('Email address input'));
    });
  });

  // TC-149~150: Validation helpers
  group('TC-149~150: Validation helpers', () {
    test('Normal: requiredValidation', () {
      final rule = MCPUIJsonGenerator.requiredValidation(message: 'Field is required');
      expect(rule, isNotNull);
      expect(rule['required'], isTrue);
      expect(rule['message'], equals('Field is required'));
    });

    test('Normal: emailValidation', () {
      final rule = MCPUIJsonGenerator.emailValidation(message: 'Invalid email');
      expect(rule, isNotNull);
    });
  });

  // TC-151: i18n helpers
  group('TC-151: i18n helpers', () {
    test('Normal: i18n key reference', () {
      final result = MCPUIJsonGenerator.i18n('greeting', args: {'name': 'User'});
      expect(result, isNotNull);
    });

    test('Boundary: i18n key without args', () {
      final result = MCPUIJsonGenerator.i18n('welcome');
      expect(result, isNotNull);
    });
  });

  // TC-159~166: v1.1 Client Action helpers
  group('TC-159~166: v1.1 Client Action helpers', () {
    test('Normal: clientSelectFile', () {
      final action = MCPUIJsonGenerator.clientSelectFile(
        title: 'Select File',
        filters: [{'name': 'JSON', 'extensions': ['json']}, {'name': 'Text', 'extensions': ['txt']}],
      );
      expect(action['type'], equals('client.selectFile'));
    });

    test('Normal: clientReadFile', () {
      final action = MCPUIJsonGenerator.clientReadFile(
        path: '/test.txt',
        encoding: 'utf-8',
      );
      expect(action['type'], equals('client.readFile'));
    });

    test('Normal: clientWriteFile', () {
      final action = MCPUIJsonGenerator.clientWriteFile(
        path: '/output.txt',
        content: 'Hello World',
        confirmMessage: 'Write to file?',
      );
      expect(action['type'], equals('client.writeFile'));
    });

    test('Normal: clientListFiles', () {
      final action = MCPUIJsonGenerator.clientListFiles(
        path: '/data',
        pattern: '*.json',
        recursive: true,
      );
      expect(action['type'], equals('client.listFiles'));
    });

    test('Normal: clientHttpRequest', () {
      final action = MCPUIJsonGenerator.clientHttpRequest(
        url: 'https://api.example.com/data',
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: {'key': 'value'},
      );
      expect(action['type'], equals('client.httpRequest'));
    });

    test('Normal: clientGetSystemInfo', () {
      final action = MCPUIJsonGenerator.clientGetSystemInfo(
        properties: ['platform', 'memory'],
      );
      expect(action['type'], equals('client.getSystemInfo'));
    });

    test('Normal: clientExec', () {
      final action = MCPUIJsonGenerator.clientExec(
        command: 'ls',
        args: ['-la'],
        timeout: 5000,
      );
      expect(action['type'], equals('client.exec'));
    });

    test('Boundary: clientSelectFile minimal params', () {
      final action = MCPUIJsonGenerator.clientSelectFile();
      expect(action['type'], equals('client.selectFile'));
    });
  });

  // TC-167~171: v1.1 Permission helpers
  group('TC-167~171: v1.1 Permission helpers', () {
    test('Normal: permissions declaration', () {
      final perms = MCPUIJsonGenerator.permissions(
        file: MCPUIJsonGenerator.filePermissions(
          read: {'paths': ['./config']},
          write: {'paths': ['./output']},
        ),
        network: MCPUIJsonGenerator.networkPermissions(
          http: {'domains': ['api.example.com']},
        ),
      );

      expect(perms['permissions']['file'], isNotNull);
      expect(perms['permissions']['network'], isNotNull);
    });

    test('Normal: systemPermissions', () {
      final perms = MCPUIJsonGenerator.systemPermissions(
        info: ['platform', 'memory'],
        exec: {'commands': ['ls']},
      );

      expect(perms['info'], contains('platform'));
    });

    test('Normal: permissionPrompt widget', () {
      final prompt = MCPUIJsonGenerator.permissionPrompt(
        title: 'File Access Required',
        message: 'This app needs to read files',
        permissions: ['file.read'],
      );

      expect(prompt['type'], equals('permissionPrompt'));
    });
  });

  // TC-173~177: v1.1 Channel helpers
  group('TC-173~177: v1.1 Channel helpers', () {
    test('Normal: watchFileChannel', () {
      final channel = MCPUIJsonGenerator.watchFileChannel(
        path: './config.json',
        events: ['change'],
      );

      expect(channel['type'], equals('client.watchFile'));
      expect(channel['path'], equals('./config.json'));
    });

    test('Normal: watchDirectoryChannel', () {
      final channel = MCPUIJsonGenerator.watchDirectoryChannel(
        path: './data',
        recursive: true,
      );

      expect(channel['type'], equals('client.watchDirectory'));
    });

    test('Normal: systemMonitorChannel', () {
      final channel = MCPUIJsonGenerator.systemMonitorChannel(
        metrics: ['cpu', 'memory'],
        interval: 5000,
      );

      expect(channel['type'], equals('client.systemMonitor'));
    });

    test('Normal: pollChannel', () {
      final channel = MCPUIJsonGenerator.pollChannel(
        action: MCPUIJsonGenerator.toolAction('fetchStatus'),
        interval: 10000,
        binding: 'status',
      );

      expect(channel['type'], equals('client.poll'));
    });

    test('Normal: channelAction', () {
      final action = MCPUIJsonGenerator.channelAction(
        channel: 'systemMonitor',
        action: 'start',
      );

      expect(action['type'], equals('channel.start'));
    });
  });

  // TC-178~185: v1.1 Client Binding helpers
  group('TC-178~185: v1.1 Client Binding helpers', () {
    test('Normal: clientBinding', () {
      expect(MCPUIJsonGenerator.clientBinding('platform'), equals('{{client.platform}}'));
    });

    test('Normal: clientWorkingDirectory', () {
      expect(MCPUIJsonGenerator.clientWorkingDirectory(), equals('{{client.workingDirectory}}'));
    });

    test('Normal: clientUserName', () {
      expect(MCPUIJsonGenerator.clientUserName(), equals('{{client.userName}}'));
    });

    test('Normal: clientPlatform', () {
      expect(MCPUIJsonGenerator.clientPlatform(), equals('{{client.platform}}'));
    });

    test('Normal: clientLocale', () {
      expect(MCPUIJsonGenerator.clientLocale(), equals('{{client.locale}}'));
    });

    test('Normal: clientTheme', () {
      expect(MCPUIJsonGenerator.clientTheme('background'), equals('{{client.theme.background}}'));
    });

    test('Normal: permissionBinding', () {
      expect(MCPUIJsonGenerator.permissionBinding('file.read'), equals('{{permissions.file.read}}'));
    });

    test('Normal: channelBinding', () {
      expect(MCPUIJsonGenerator.channelBinding('systemMonitor', 'cpu'), equals('{{channels.systemMonitor.cpu}}'));
    });
  });

  // TC-190~192: Utility methods
  group('TC-190~192: Utility methods', () {
    test('Normal: toPrettyJson', () {
      final json = MCPUIJsonGenerator.toPrettyJson({'type': 'text', 'content': 'hello'});
      expect(json, contains('"type"'));
      expect(json, contains('"text"'));
    });

    test('Normal: createWidget with valid type', () {
      final widget = MCPUIJsonGenerator.createWidget('text', {'content': 'hello'});
      expect(widget['type'], equals('text'));
      expect(widget['content'], equals('hello'));
    });

    test('Normal: createAction', () {
      final action = MCPUIJsonGenerator.createAction(
        type: 'state',
        params: {'action': 'set', 'binding': 'x', 'value': 1},
      );
      expect(action['type'], equals('state'));
    });

    test('Boundary: toPrettyJson with nested complex object', () {
      final complex = {
        'type': 'linear',
        'children': [
          {'type': 'text', 'content': 'A'},
          {'type': 'box', 'child': {'type': 'text', 'content': 'B'}},
        ],
      };
      final json = MCPUIJsonGenerator.toPrettyJson(complex);
      expect(json, contains('"linear"'));
      expect(json, contains('"children"'));
    });
  });

  // TC-118~122: Dimension & Size helpers
  group('TC-118~122: Dimension & Size helpers', () {
    test('Normal: percent', () {
      expect(MCPUIJsonGenerator.percent(50), contains('%'));
    });

    test('Normal: vw', () {
      expect(MCPUIJsonGenerator.vw(100), contains('vw'));
    });

    test('Normal: vh', () {
      expect(MCPUIJsonGenerator.vh(50), contains('vh'));
    });

    test('Normal: dimension', () {
      final dim = MCPUIJsonGenerator.dimension(100, 'px');
      expect(dim['value'], equals(100));
      expect(dim['unit'], equals('px'));
    });
  });

  // TC-186~188: PageBuilder v1.1 extensions
  group('TC-186~188: PageBuilder v1.1 extensions', () {
    test('Normal: version sets DSL version', () {
      final page = MCPUIBuilder.page(title: 'V11 Page')
          .version('1.1')
          .content(MCPUIJsonGenerator.text('Hello'))
          .build();

      expect(page['version'], equals('1.1'));
    });

    test('Normal: permissions declares required permissions', () {
      final page = MCPUIBuilder.page(title: 'Perm Page')
          .version('1.1')
          .content(MCPUIJsonGenerator.text('Hello'))
          .permissions({'file': ['read']})
          .build();

      expect(page['permissions'], isNotNull);
      expect(page['permissions']['file'], contains('read'));
    });

    test('Normal: channels declares channels', () {
      final page = MCPUIBuilder.page(title: 'Channel Page')
          .version('1.1')
          .content(MCPUIJsonGenerator.text('Hello'))
          .channels({
            'monitor': MCPUIJsonGenerator.systemMonitorChannel(
              metrics: ['cpu'],
              interval: 5000,
            ),
          })
          .build();

      expect(page['channels'], isNotNull);
    });
  });
}
