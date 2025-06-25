import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  group('Builders', () {
    test('application', () {
      final app = MCPUIBuilder.application(
        title: 'Test App',
        version: '1.0.0',
      )
          .initialRoute('/home')
          .addRoute('/home', 'ui://pages/home')
          .addRoute('/settings', 'ui://pages/settings')
          .theme({'primaryColor': '#2196F3'}).navigation(
              {'type': 'drawer'}).initialState({'user': 'John'}).build();

      expect(app['type'], 'application');
      expect(app['title'], 'Test App');
      expect(app['initialRoute'], '/home');
      expect(app['routes'].length, 2);
      expect(app['theme'], isNotNull);
      expect(app['navigation'], isNotNull);
      expect(app['state']['initial']['user'], 'John');
    });

    test('page', () {
      final page = MCPUIBuilder.page(title: 'Test Page')
          .content(MCPUIJsonGenerator.text('Hello'))
          .route('/test')
          .initialState({'count': 0}).onInit([
        MCPUIJsonGenerator.toolAction('loadData')
      ]).onDestroy([MCPUIJsonGenerator.toolAction('cleanup')]).build();

      expect(page['type'], 'page');
      expect(page['title'], 'Test Page');
      expect(page['lifecycle']['onInit'].length, 1);
      expect(page['lifecycle']['onDestroy'].length, 1);
    });

    test('linear builder', () {
      final layout = MCPUIBuilder.linear()
          .add(MCPUIJsonGenerator.text('Title'))
          .add(MCPUIJsonGenerator.sizedBox(height: 20))
          .direction('vertical')
          .distribution('center')
          .alignment('start')
          .gap(16.0)
          .build();

      expect(layout['type'], 'linear');
      expect(layout['children'].length, 2);
      expect(layout['direction'], 'vertical');
      expect(layout['distribution'], 'center');
      expect(layout['alignment'], 'start');
      expect(layout['gap'], 16.0);
    });

    test('box builder', () {
      final box = MCPUIBuilder.box()
          .child(MCPUIJsonGenerator.text('Content'))
          .width(100.0)
          .height(200.0)
          .color('#ff0000')
          .padding(MCPUIJsonGenerator.edgeInsets(all: 16))
          .margin(MCPUIJsonGenerator.edgeInsets(all: 8))
          .build();

      expect(box['type'], 'box');
      expect(box['child'], isA<Map>());
      expect(box['width'], 100.0);
      expect(box['height'], 200.0);
      expect(box['color'], '#ff0000');
      expect(box['padding'], isA<Map>());
      expect(box['margin'], isA<Map>());
    });

    test('stack builder', () {
      final stack = MCPUIBuilder.stack()
          .add(MCPUIJsonGenerator.box(color: '#ff0000'))
          .add(MCPUIJsonGenerator.text('Overlay'))
          .alignment('center')
          .fit('expand')
          .build();

      expect(stack['type'], 'stack');
      expect(stack['children'].length, 2);
      expect(stack['alignment'], 'center');
      expect(stack['fit'], 'expand');
    });

    test('center builder', () {
      final center = MCPUIBuilder.center()
          .child(MCPUIJsonGenerator.text('Centered'))
          .build();

      expect(center['type'], 'center');
      expect(center['child'], isA<Map>());
    });

    test('card builder', () {
      final card = MCPUIBuilder.card()
          .child(MCPUIJsonGenerator.text('Card content'))
          .elevation(4.0)
          .margin(MCPUIJsonGenerator.edgeInsets(all: 8))
          .shape(MCPUIJsonGenerator.decoration(borderRadius: 8))
          .build();

      expect(card['type'], 'card');
      expect(card['child'], isA<Map>());
      expect(card['elevation'], 4.0);
      expect(card['margin'], isA<Map>());
      expect(card['shape'], isA<Map>());
    });

    test('listView builder', () {
      final listView = MCPUIBuilder.listView(
        items: '{{items}}',
        itemTemplate: MCPUIJsonGenerator.listTile(
          title: '{{item.name}}',
          subtitle: '{{item.description}}',
        ),
      ).itemSpacing(8).shrinkWrap(true).scrollDirection('vertical').build();

      expect(listView['type'], 'list');
      expect(listView['items'], '{{items}}');
      expect(listView['itemTemplate'], isA<Map>());
      expect(listView['itemSpacing'], 8);
      expect(listView['shrinkWrap'], true);
      expect(listView['scrollDirection'], 'vertical');
    });

    test('gridView builder', () {
      final gridView = MCPUIBuilder.gridView(
        items: '{{products}}',
        itemTemplate: MCPUIJsonGenerator.card(
          child: MCPUIJsonGenerator.text('{{item.name}}'),
        ),
      )
          .crossAxisCount(2)
          .mainAxisSpacing(8.0)
          .crossAxisSpacing(8.0)
          .childAspectRatio(1.5)
          .build();

      expect(gridView['type'], 'grid');
      expect(gridView['items'], '{{products}}');
      expect(gridView['itemTemplate'], isA<Map>());
      expect(gridView['crossAxisCount'], 2);
      expect(gridView['mainAxisSpacing'], 8.0);
      expect(gridView['crossAxisSpacing'], 8.0);
      expect(gridView['childAspectRatio'], 1.5);
    });
  });
}
