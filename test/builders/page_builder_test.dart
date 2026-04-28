import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-014: PageBuilder — constructor
  group('TC-014: PageBuilder — constructor', () {
    test('Normal: creates builder with title', () {
      final page = MCPUIBuilder.page(title: 'Settings').build();

      expect(page['type'], equals('page'));
      expect(page['title'], equals('Settings'));
    });

    test('Boundary: title with special characters', () {
      final page = MCPUIBuilder.page(title: 'Settings — 設定').build();

      expect(page['title'], equals('Settings — 設定'));
    });
  });

  // TC-015: PageBuilder — content
  group('TC-015: PageBuilder — content', () {
    test('Normal: sets page content', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .content(MCPUIJsonGenerator.text('Hello'))
          .build();

      expect(page['content'], isA<Map>());
      expect(page['content']['type'], equals('text'));
    });

    test('Boundary: deeply nested content', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .content(MCPUIJsonGenerator.center(
            child: MCPUIJsonGenerator.linear(
              children: [
                MCPUIJsonGenerator.box(
                  child: MCPUIJsonGenerator.text('Deep'),
                ),
              ],
            ),
          ))
          .build();

      expect(page['content']['type'], equals('center'));
    });
  });

  // TC-016: PageBuilder — route
  group('TC-016: PageBuilder — route', () {
    test('Normal: sets page route', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .route('/settings')
          .build();

      expect(page['route'], equals('/settings'));
    });

    test('Boundary: route with query params', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .route('/search?q=test')
          .build();

      expect(page['route'], equals('/search?q=test'));
    });
  });

  // TC-017: PageBuilder — initialState
  group('TC-017: PageBuilder — initialState', () {
    test('Normal: sets page state', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .initialState({'key': 'value'})
          .build();

      expect(page['state']['initial']['key'], equals('value'));
    });

    test('Boundary: empty initial state', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .initialState({})
          .build();

      expect(page['state']['initial'], equals({}));
    });
  });

  // TC-018: PageBuilder — onInit
  group('TC-018: PageBuilder — onInit', () {
    test('Normal: sets init lifecycle actions', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .onInit([
            MCPUIJsonGenerator.toolAction('loadData'),
            MCPUIJsonGenerator.toolAction('analytics'),
          ])
          .build();

      expect(page['lifecycle']['onInit'].length, equals(2));
    });

    test('Boundary: empty actions list', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .onInit([])
          .build();

      expect(page['lifecycle']['onInit'], isEmpty);
    });
  });

  // TC-019: PageBuilder — onDestroy
  group('TC-019: PageBuilder — onDestroy', () {
    test('Normal: sets destroy lifecycle actions', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .onDestroy([MCPUIJsonGenerator.toolAction('cleanup')])
          .build();

      expect(page['lifecycle']['onDestroy'].length, equals(1));
    });

    test('Boundary: empty actions list', () {
      final page = MCPUIBuilder.page(title: 'Test')
          .onDestroy([])
          .build();

      expect(page['lifecycle']['onDestroy'], isEmpty);
    });
  });

  // TC-020: PageBuilder — build output (complete)
  group('TC-020: PageBuilder — build output (complete)', () {
    test('Normal: complete build with all fields', () {
      final page = MCPUIBuilder.page(title: 'Full Page')
          .content(MCPUIJsonGenerator.text('Hello'))
          .route('/full')
          .initialState({'count': 0})
          .onInit([MCPUIJsonGenerator.toolAction('init')])
          .onDestroy([MCPUIJsonGenerator.toolAction('cleanup')])
          .build();

      expect(page['type'], equals('page'));
      expect(page['title'], equals('Full Page'));
      expect(page['content'], isNotNull);
      expect(page['route'], equals('/full'));
      expect(page['state'], isNotNull);
      expect(page['lifecycle']['onInit'], isNotNull);
      expect(page['lifecycle']['onDestroy'], isNotNull);
    });

    test('Boundary: minimal build (title only)', () {
      final page = MCPUIBuilder.page(title: 'Minimal').build();

      expect(page['type'], equals('page'));
      expect(page['title'], equals('Minimal'));
    });
  });
}
