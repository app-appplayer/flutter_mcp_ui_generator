import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-092: MCPUIJsonGenerator.headerBar
  group('TC-092: MCPUIJsonGenerator.headerBar', () {
    test('Normal: produces header bar with title, leading, actions', () {
      final w = MCPUIJsonGenerator.headerBar(
        title: 'My App',
        leading: MCPUIJsonGenerator.icon(icon: 'menu'),
        actions: [MCPUIJsonGenerator.icon(icon: 'search')],
      );

      expect(w['type'], equals('headerBar'));
      expect(w['title'], equals('My App'));
      expect(w['leading'], isA<Map>());
      expect(w['actions'], isA<List>());
    });

    test('Boundary: title only', () {
      final w = MCPUIJsonGenerator.headerBar(title: 'Title');

      expect(w['type'], equals('headerBar'));
      expect(w['title'], equals('Title'));
    });
  });

  // TC-093: MCPUIJsonGenerator.appBar (alias)
  group('TC-093: MCPUIJsonGenerator.appBar (alias)', () {
    test('Normal: produces same output as headerBar', () {
      final w = MCPUIJsonGenerator.appBar(title: 'Test');

      expect(w['type'], equals('headerBar'));
      expect(w['title'], equals('Test'));
    });
  });

  // TC-094: MCPUIJsonGenerator.bottomNavigation
  group('TC-094: MCPUIJsonGenerator.bottomNavigation', () {
    test('Normal: produces bottom navigation with items', () {
      final w = MCPUIJsonGenerator.bottomNavigation(
        items: [
          MCPUIJsonGenerator.navigationItem(
            icon: 'home',
            label: 'Home',
            route: '/home',
          ),
          MCPUIJsonGenerator.navigationItem(
            icon: 'settings',
            label: 'Settings',
            route: '/settings',
          ),
        ],
        currentIndex: 0,
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'navIndex',
          value: '{{event.value}}',
        ),
      );

      expect(w['type'], equals('bottomNavigation'));
      expect((w['items'] as List).length, equals(2));
      expect(w['currentIndex'], equals(0));
    });

    test('Boundary: single navigation item', () {
      final w = MCPUIJsonGenerator.bottomNavigation(
        items: [
          MCPUIJsonGenerator.navigationItem(
            icon: 'home',
            label: 'Home',
            route: '/home',
          ),
        ],
        currentIndex: 0,
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'navIndex',
        ),
      );

      expect((w['items'] as List).length, equals(1));
    });
  });

  // TC-095: MCPUIJsonGenerator.drawer
  group('TC-095: MCPUIJsonGenerator.drawer', () {
    test('Normal: produces drawer with child', () {
      final w = MCPUIJsonGenerator.drawer(
        child: MCPUIJsonGenerator.linear(
          children: [MCPUIJsonGenerator.text('Menu')],
        ),
      );

      expect(w['type'], equals('drawer'));
      expect(w['child'], isA<Map>());
    });
  });

  // TC-096: MCPUIJsonGenerator.floatingActionButton
  group('TC-096: MCPUIJsonGenerator.floatingActionButton', () {
    test('Normal: produces FAB with icon, label, click', () {
      final w = MCPUIJsonGenerator.floatingActionButton(
        icon: 'add',
        label: 'New',
        click: MCPUIJsonGenerator.toolAction('create'),
      );

      expect(w['type'], equals('floatingActionButton'));
      expect(w['icon'], equals('add'));
      expect(w['label'], equals('New'));
      expect(w['onTap'], isA<Map>());
    });

    test('Boundary: icon only (no label)', () {
      final w = MCPUIJsonGenerator.floatingActionButton(
        icon: 'add',
        click: MCPUIJsonGenerator.toolAction('create'),
      );

      expect(w['type'], equals('floatingActionButton'));
      expect(w['icon'], equals('add'));
    });
  });

  // TC-097: MCPUIJsonGenerator.drawerNavigation
  group('TC-097: MCPUIJsonGenerator.drawerNavigation', () {
    test('Normal: produces drawer navigation with items', () {
      final w = MCPUIJsonGenerator.drawerNavigation(
        items: [
          MCPUIJsonGenerator.navigationItem(
            icon: 'home',
            label: 'Home',
            route: '/home',
          ),
        ],
      );

      // drawerNavigation uses 'drawer' as type with items
      expect(w['type'], equals('drawer'));
      expect(w['items'], isA<List>());
    });
  });

  // TC-098: MCPUIJsonGenerator.tabsNavigation
  group('TC-098: MCPUIJsonGenerator.tabsNavigation', () {
    test('Normal: produces tab navigation', () {
      final w = MCPUIJsonGenerator.tabsNavigation(
        tabs: [
          MCPUIJsonGenerator.tabItem(
            label: 'Home',
            content: MCPUIJsonGenerator.text('Home'),
          ),
          MCPUIJsonGenerator.tabItem(
            label: 'Settings',
            content: MCPUIJsonGenerator.text('Settings'),
          ),
        ],
      );

      expect(w['type'], equals('tabs'));
      expect((w['tabs'] as List).length, equals(2));
    });

    test('Boundary: two tabs (minimum)', () {
      final w = MCPUIJsonGenerator.tabsNavigation(
        tabs: [
          MCPUIJsonGenerator.tabItem(
            label: 'A',
            content: MCPUIJsonGenerator.text('A'),
          ),
          MCPUIJsonGenerator.tabItem(
            label: 'B',
            content: MCPUIJsonGenerator.text('B'),
          ),
        ],
      );

      expect((w['tabs'] as List).length, equals(2));
    });
  });

  // TC-099: MCPUIJsonGenerator.tabItem
  group('TC-099: MCPUIJsonGenerator.tabItem', () {
    test('Normal: produces tab item definition', () {
      final w = MCPUIJsonGenerator.tabItem(
        label: 'Home',
        content: MCPUIJsonGenerator.text('Home content'),
        icon: 'home',
      );

      expect(w['label'], equals('Home'));
      expect(w['content'], isA<Map>());
      expect(w['icon'], equals('home'));
    });

    test('Boundary: minimal fields', () {
      final w = MCPUIJsonGenerator.tabItem(
        label: 'Tab',
        content: MCPUIJsonGenerator.text('Content'),
      );

      expect(w['label'], equals('Tab'));
      expect(w['content'], isA<Map>());
    });
  });

  // TC-100: MCPUIJsonGenerator.navigationItem
  group('TC-100: MCPUIJsonGenerator.navigationItem', () {
    test('Normal: produces navigation item', () {
      final w = MCPUIJsonGenerator.navigationItem(
        icon: 'home',
        label: 'Home',
        route: '/home',
      );

      expect(w['icon'], equals('home'));
      expect(w['label'], equals('Home'));
      expect(w['route'], equals('/home'));
    });

    test('Boundary: label and route only', () {
      final w = MCPUIJsonGenerator.navigationItem(
        label: 'Page',
        route: '/page',
      );

      expect(w['label'], equals('Page'));
      expect(w['route'], equals('/page'));
    });
  });
}
