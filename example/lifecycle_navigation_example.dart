import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

/// Example demonstrating lifecycle hooks and navigation structures
void main() {
  // Example 1: Page with lifecycle hooks
  final pageWithLifecycle = MCPUIJsonGenerator.page(
    title: 'Lifecycle Example',
    content: MCPUIJsonGenerator.linear(
      direction: 'vertical',
      gap: 16,
      children: [
        MCPUIJsonGenerator.text(
          'This page has lifecycle hooks',
          style: MCPUIJsonGenerator.textStyle(fontSize: 20),
        ),
        MCPUIJsonGenerator.text(
          'Current count: {{local.count}}',
        ),
        MCPUIJsonGenerator.button(
          label: 'Increment',
          click: MCPUIJsonGenerator.stateAction(
            action: 'increment',
            binding: 'local.count',
          ),
        ),
      ],
    ),
    lifecycle: MCPUIJsonGenerator.lifecycle(
      onInit: [
        MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'local.count',
          value: 0,
        ),
        MCPUIJsonGenerator.toolAction(
          'logEvent',
          args: {'event': 'page_initialized'},
        ),
      ],
      onDestroy: [
        MCPUIJsonGenerator.toolAction(
          'saveData',
          args: {'count': '{{local.count}}'},
        ),
      ],
      onResume: [
        MCPUIJsonGenerator.toolAction(
          'refreshData',
        ),
      ],
      onPause: [
        MCPUIJsonGenerator.toolAction(
          'pauseBackgroundTasks',
        ),
      ],
    ),
  );

  // Example 2: Application with drawer navigation
  final appWithDrawer = MCPUIJsonGenerator.application(
    title: 'Drawer Navigation App',
    version: '1.0.0',
    navigation: MCPUIJsonGenerator.drawerNavigation(
      header: MCPUIJsonGenerator.container(
        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
        color: '#2196F3',
        child: MCPUIJsonGenerator.column(
          crossAxisAlignment: 'start',
          children: [
            MCPUIJsonGenerator.text(
              'My App',
              style: MCPUIJsonGenerator.textStyle(
                fontSize: 24,
                color: '#FFFFFF',
                fontWeight: 'bold',
              ),
            ),
            MCPUIJsonGenerator.text(
              'user@example.com',
              style: MCPUIJsonGenerator.textStyle(
                fontSize: 14,
                color: '#FFFFFF',
              ),
            ),
          ],
        ),
      ),
      items: [
        MCPUIJsonGenerator.navigationItem(
          label: 'Dashboard',
          route: '/dashboard',
          icon: 'dashboard',
        ),
        MCPUIJsonGenerator.navigationItem(
          label: 'Profile',
          route: '/profile',
          icon: 'person',
        ),
        MCPUIJsonGenerator.navigationItem(
          label: 'Settings',
          route: '/settings',
          icon: 'settings',
          children: [
            MCPUIJsonGenerator.navigationItem(
              label: 'Account',
              route: '/settings/account',
            ),
            MCPUIJsonGenerator.navigationItem(
              label: 'Privacy',
              route: '/settings/privacy',
            ),
          ],
        ),
      ],
      footer: MCPUIJsonGenerator.container(
        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
        child: MCPUIJsonGenerator.button(
          label: 'Logout',
          click: MCPUIJsonGenerator.toolAction('logout'),
          style: 'text',
          icon: 'logout',
        ),
      ),
    ),
    routes: {
      '/dashboard': MCPUIJsonGenerator.page(
        title: 'Dashboard',
        content: MCPUIJsonGenerator.text('Dashboard Content'),
      ),
      '/profile': MCPUIJsonGenerator.page(
        title: 'Profile',
        content: MCPUIJsonGenerator.text('Profile Content'),
      ),
      '/settings': MCPUIJsonGenerator.page(
        title: 'Settings',
        content: MCPUIJsonGenerator.text('Settings Content'),
      ),
    },
  );

  // Example 3: Application with tabs navigation
  final appWithTabs = MCPUIJsonGenerator.application(
    title: 'Tabs Navigation App',
    version: '1.0.0',
    navigation: MCPUIJsonGenerator.tabsNavigation(
      tabs: [
        MCPUIJsonGenerator.tabItem(
          label: 'Home',
          icon: 'home',
          content: MCPUIJsonGenerator.page(
            title: 'Home',
            content: MCPUIJsonGenerator.center(
              child: MCPUIJsonGenerator.text('Home Tab Content'),
            ),
          ),
        ),
        MCPUIJsonGenerator.tabItem(
          label: 'Explore',
          icon: 'explore',
          content: MCPUIJsonGenerator.page(
            title: 'Explore',
            content: MCPUIJsonGenerator.center(
              child: MCPUIJsonGenerator.text('Explore Tab Content'),
            ),
          ),
        ),
        MCPUIJsonGenerator.tabItem(
          label: 'Profile',
          icon: 'person',
          content: MCPUIJsonGenerator.page(
            title: 'Profile',
            content: MCPUIJsonGenerator.center(
              child: MCPUIJsonGenerator.text('Profile Tab Content'),
            ),
          ),
        ),
      ],
      initialIndex: 0,
      tabBarPosition: 'bottom',
    ),
    routes: {
      '/': MCPUIJsonGenerator.page(
        title: 'Main',
        content: MCPUIJsonGenerator.text('Main App'),
      ),
    },
  );

  // Example 4: Using builder pattern for lifecycle
  final pageUsingBuilder = MCPUIBuilder.page(title: 'Builder Example')
    .content(
      MCPUIJsonGenerator.linear(
        direction: 'vertical',
        children: [
          MCPUIJsonGenerator.text('Page created with builder'),
        ],
      ),
    )
    .onInit([
      MCPUIJsonGenerator.toolAction('initializePage'),
    ])
    .onDestroy([
      MCPUIJsonGenerator.toolAction('cleanupPage'),
    ])
    .build();

  print('Lifecycle and Navigation Examples Generated Successfully!');
  print('\nPage with lifecycle hooks:');
  print(pageWithLifecycle);
  print('\nApp with drawer navigation:');
  print(appWithDrawer);
  print('\nApp with tabs navigation:');
  print(appWithTabs);
}