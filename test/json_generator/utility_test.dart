import 'dart:convert';
import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-190: MCPUIJsonGenerator.toPrettyJson
  group('TC-190: MCPUIJsonGenerator.toPrettyJson', () {
    test('Normal: returns formatted JSON string', () {
      final json = MCPUIJsonGenerator.toPrettyJson({
        'type': 'text',
        'content': 'hello',
      });

      expect(json, isA<String>());
      // Should be parseable back to a map
      final parsed = jsonDecode(json) as Map<String, dynamic>;
      expect(parsed['type'], equals('text'));
      expect(parsed['content'], equals('hello'));
    });

    test('Boundary: nested complex object', () {
      final json = MCPUIJsonGenerator.toPrettyJson({
        'type': 'linear',
        'children': [
          {'type': 'text', 'content': 'a'},
          {'type': 'text', 'content': 'b'},
        ],
        'meta': {'key': 'value'},
      });

      expect(json, contains('"type": "linear"'));
      expect(json, contains('"children"'));
    });
  });

  // TC-191: MCPUIJsonGenerator.createWidget
  group('TC-191: MCPUIJsonGenerator.createWidget', () {
    test('Normal: creates widget map with type validation', () {
      final w = MCPUIJsonGenerator.createWidget('text', {'content': 'hello'});

      expect(w['type'], equals('text'));
      expect(w['content'], equals('hello'));
    });

    test('Boundary: all spec-defined widget types accepted', () {
      // Test a few known widget types
      expect(
        () => MCPUIJsonGenerator.createWidget('button', {'label': 'OK'}),
        returnsNormally,
      );
      expect(
        () => MCPUIJsonGenerator.createWidget('linear', {'children': []}),
        returnsNormally,
      );
      expect(
        () => MCPUIJsonGenerator.createWidget('box', {}),
        returnsNormally,
      );
    });

    test('Error: invalid widget type throws', () {
      expect(
        () => MCPUIJsonGenerator.createWidget('nonExistentWidget', {}),
        throwsException,
      );
    });
  });

  // TC-192: MCPUIJsonGenerator.createAction
  group('TC-192: MCPUIJsonGenerator.createAction', () {
    test('Normal: creates action map', () {
      final a = MCPUIJsonGenerator.createAction(
        type: 'state',
        params: {'action': 'set', 'binding': 'x', 'value': 1},
      );

      expect(a['type'], equals('state'));
      expect(a['action'], equals('set'));
      expect(a['binding'], equals('x'));
    });

    test('Boundary: minimal params', () {
      final a = MCPUIJsonGenerator.createAction(type: 'tool');

      expect(a['type'], equals('tool'));
    });
  });

  // TC-216: createWidget type validation
  group('TC-216: createWidget type validation', () {
    test('Normal: valid widget type passes', () {
      final w = MCPUIJsonGenerator.createWidget('text', {'content': 'test'});
      expect(w, isA<Map>());
    });

    test('Error: invalid widget type produces validation error', () {
      expect(
        () => MCPUIJsonGenerator.createWidget('invalidType123', {}),
        throwsException,
      );
    });
  });

  // TC-217: Builder output format
  group('TC-217: Builder output format', () {
    test('Normal: output is Map<String, dynamic>', () {
      final app = MCPUIBuilder.application(title: 'App', version: '1.0')
          .initialRoute('/')
          .build();

      expect(app, isA<Map<String, dynamic>>());
    });

    test('Normal: output includes all explicitly set properties', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .route('/test')
          .content(MCPUIJsonGenerator.text('Hello'))
          .build();

      expect(page['title'], equals('Test'));
      expect(page['route'], equals('/test'));
      expect(page['content'], isA<Map>());
    });
  });

  // TC-218: MCPUIBuilder.application
  group('TC-218: MCPUIBuilder.application', () {
    test('Normal: returns ApplicationBuilder instance', () {
      final builder = MCPUIBuilder.application(title: 'App', version: '1.0');
      expect(builder, isA<ApplicationBuilder>());
    });
  });

  // TC-219: MCPUIBuilder.page
  group('TC-219: MCPUIBuilder.page', () {
    test('Normal: returns PageBuilder instance', () {
      final builder = MCPUIBuilder.page(title: 'Page');
      expect(builder, isA<PageBuilder>());
    });
  });

  // TC-220: MCPUIBuilder.linear
  group('TC-220: MCPUIBuilder.linear', () {
    test('Normal: returns LinearBuilder instance', () {
      final builder = MCPUIBuilder.linear();
      expect(builder, isA<LinearBuilder>());
    });
  });

  // TC-221: MCPUIBuilder factory — all widget builders
  group('TC-221: MCPUIBuilder factory — all widget builders', () {
    test('Normal: factory provides access to all builder types', () {
      expect(MCPUIBuilder.application(title: 'A', version: '1'), isA<ApplicationBuilder>());
      expect(MCPUIBuilder.page(title: 'P'), isA<PageBuilder>());
      expect(MCPUIBuilder.linear(), isA<LinearBuilder>());
      expect(MCPUIBuilder.box(), isA<BoxBuilder>());
      expect(MCPUIBuilder.stack(), isA<StackBuilder>());
      expect(MCPUIBuilder.center(), isA<CenterBuilder>());
      expect(MCPUIBuilder.card(), isA<CardBuilder>());
      expect(
        MCPUIBuilder.listView(
          items: '{{items}}',
          itemTemplate: {'type': 'text'},
        ),
        isA<ListViewBuilder>(),
      );
      expect(
        MCPUIBuilder.gridView(
          items: '{{items}}',
          itemTemplate: {'type': 'text'},
        ),
        isA<GridViewBuilder>(),
      );
    });
  });
}
