import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import '../utils/file_writer.dart';

/// Multi-Page Application Example
///
/// This example demonstrates a complete application structure with multiple pages.
/// It creates the app definition and individual pages.
void main() {
  print('=== Multi-Page Application Example ===\n');

  // 1. Create application definition
  _createApplication();

  // 2. Create individual pages
  _createHomePage();
  _createProfilePage();
  _createSettingsPage();
  _createAboutPage();

  print('\n=== Multi-page app example completed! ===');
  print('Generated files:');
  print('- multi_page_app.json (application definition)');
  print('- home_page.json');
  print('- profile_page.json');
  print('- settings_page.json');
  print('- about_page.json');
}

/// Create application definition
void _createApplication() {
  final app = MCPUIBuilder.application(
    title: 'Multi-Page Demo App',
    version: '1.0.0',
  )
      .initialRoute('/home')
      .addRoute('/home', 'ui://pages/home')
      .addRoute('/profile', 'ui://pages/profile')
      .addRoute('/settings', 'ui://pages/settings')
      .addRoute('/about', 'ui://pages/about')
      .theme({
    'primaryColor': '#2196F3',
    'accentColor': '#FF4081',
    'backgroundColor': '#FAFAFA',
    'surfaceColor': '#FFFFFF',
    'textTheme': {
      'headline': {'fontSize': 24, 'fontWeight': 'bold'},
      'body': {'fontSize': 16},
      'caption': {'fontSize': 12, 'color': '#666666'},
    },
  }).navigation({
    'type': 'bottomNavigationBar',
    'items': [
      {'icon': 'home', 'label': 'Home', 'route': '/home'},
      {'icon': 'person', 'label': 'Profile', 'route': '/profile'},
      {'icon': 'settings', 'label': 'Settings', 'route': '/settings'},
      {'icon': 'info', 'label': 'About', 'route': '/about'},
    ],
  }).initialState({
    'currentUser': {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'avatar': 'https://example.com/avatar.jpg',
    },
    'currentTab': 0,
    'notifications': [],
    'settings': {
      'darkMode': false,
      'notifications': true,
      'language': 'en',
    },
  }).build();

  ExampleFileWriter.writeJsonFile(app, 'multi_page_app.json');
  print('✓ Application definition created: multi_page_app.json');
}

/// Create home page
void _createHomePage() {
  final homePage = MCPUIBuilder.page(title: 'Home')
      .content(
    MCPUIJsonGenerator.column(
      children: [
        // App bar
        MCPUIJsonGenerator.appBar(
          title: 'Welcome Home',
          actions: [
            MCPUIJsonGenerator.icon(icon: 'notifications'),
            MCPUIJsonGenerator.icon(icon: 'search'),
          ],
        ),

        // Main content
        MCPUIJsonGenerator.expanded(
          child: MCPUIJsonGenerator.padding(
            padding: MCPUIJsonGenerator.edgeInsets(all: 16),
            child: MCPUIJsonGenerator.column(
              children: [
                // Welcome card
                MCPUIJsonGenerator.card(
                  elevation: 4,
                  child: MCPUIJsonGenerator.padding(
                    padding: MCPUIJsonGenerator.edgeInsets(all: 20),
                    child: MCPUIJsonGenerator.row(
                      children: [
                        MCPUIJsonGenerator.container(
                          width: 60,
                          height: 60,
                          decoration: MCPUIJsonGenerator.decoration(
                            borderRadius: 30,
                            color: '#E3F2FD',
                          ),
                          child: MCPUIJsonGenerator.icon(
                            icon: 'person',
                            size: 32,
                            color: '#2196F3',
                          ),
                        ),
                        MCPUIJsonGenerator.sizedBox(width: 16),
                        MCPUIJsonGenerator.expanded(
                          child: MCPUIJsonGenerator.column(
                            crossAxisAlignment: 'start',
                            children: [
                              MCPUIJsonGenerator.text(
                                'Welcome back,',
                                style: MCPUIJsonGenerator.textStyle(
                                  fontSize: 16,
                                  color: '#666666',
                                ),
                              ),
                              MCPUIJsonGenerator.text(
                                '{{currentUser.name}}',
                                style: MCPUIJsonGenerator.textStyle(
                                  fontSize: 20,
                                  fontWeight: 'bold',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                MCPUIJsonGenerator.sizedBox(height: 24),

                // Quick actions grid
                MCPUIJsonGenerator.text(
                  'Quick Actions',
                  style: MCPUIJsonGenerator.textStyle(
                    fontSize: 18,
                    fontWeight: 'bold',
                  ),
                ),
                MCPUIJsonGenerator.sizedBox(height: 16),

                MCPUIJsonGenerator.gridView(
                  items: '{{quickActions}}',
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  itemTemplate: MCPUIJsonGenerator.card(
                    elevation: 2,
                    child: MCPUIJsonGenerator.container(
                      padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                      child: MCPUIJsonGenerator.column(
                        mainAxisAlignment: 'center',
                        children: [
                          MCPUIJsonGenerator.icon(
                            icon: '{{item.icon}}',
                            size: 36,
                            color: '{{item.color}}',
                          ),
                          MCPUIJsonGenerator.sizedBox(height: 8),
                          MCPUIJsonGenerator.text(
                            '{{item.title}}',
                            style: MCPUIJsonGenerator.textStyle(
                              fontWeight: 'bold',
                            ),
                            textAlign: 'center',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                MCPUIJsonGenerator.sizedBox(height: 24),

                // Recent activity
                MCPUIJsonGenerator.text(
                  'Recent Activity',
                  style: MCPUIJsonGenerator.textStyle(
                    fontSize: 18,
                    fontWeight: 'bold',
                  ),
                ),
                MCPUIJsonGenerator.sizedBox(height: 16),

                MCPUIJsonGenerator.expanded(
                  child: MCPUIJsonGenerator.listView(
                    items: '{{recentActivity}}',
                    itemSpacing: 8,
                    itemTemplate: MCPUIJsonGenerator.card(
                      child: MCPUIJsonGenerator.listTile(
                        leading: MCPUIJsonGenerator.icon(
                          icon: '{{item.icon}}',
                          color: '{{item.color}}',
                        ),
                        title: '{{item.title}}',
                        subtitle: '{{item.time}}',
                        trailing:
                            MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  )
      .initialState({
    'quickActions': [
      {'icon': 'analytics', 'title': 'Analytics', 'color': '#4CAF50'},
      {'icon': 'inbox', 'title': 'Messages', 'color': '#FF9800'},
      {'icon': 'calendar_today', 'title': 'Calendar', 'color': '#9C27B0'},
      {'icon': 'tasks', 'title': 'Tasks', 'color': '#F44336'},
    ],
    'recentActivity': [
      {
        'icon': 'email',
        'title': 'New message received',
        'time': '2 minutes ago',
        'color': '#2196F3'
      },
      {
        'icon': 'task_alt',
        'title': 'Task completed',
        'time': '1 hour ago',
        'color': '#4CAF50'
      },
      {
        'icon': 'event',
        'title': 'Meeting scheduled',
        'time': '3 hours ago',
        'color': '#FF9800'
      },
      {
        'icon': 'upload',
        'title': 'File uploaded',
        'time': '1 day ago',
        'color': '#9C27B0'
      },
    ],
  }).build();

  ExampleFileWriter.writeJsonFile(homePage, 'home_page.json');
  print('✓ Home page created: home_page.json');
}

/// Create profile page
void _createProfilePage() {
  final profilePage = MCPUIBuilder.page(title: 'Profile')
      .content(
        MCPUIJsonGenerator.column(
          children: [
            MCPUIJsonGenerator.appBar(
              title: 'My Profile',
              actions: [
                MCPUIJsonGenerator.button(
                  label: 'Edit',
                  style: 'text',
                  onTap: MCPUIJsonGenerator.navigationAction(
                    action: 'push',
                    route: '/profile/edit',
                  ),
                ),
              ],
            ),
            MCPUIJsonGenerator.expanded(
              child: MCPUIJsonGenerator.padding(
                padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                child: MCPUIJsonGenerator.column(
                  children: [
                    // Profile header
                    MCPUIJsonGenerator.card(
                      elevation: 4,
                      child: MCPUIJsonGenerator.padding(
                        padding: MCPUIJsonGenerator.edgeInsets(all: 24),
                        child: MCPUIJsonGenerator.column(
                          children: [
                            MCPUIJsonGenerator.container(
                              width: 100,
                              height: 100,
                              decoration: MCPUIJsonGenerator.decoration(
                                borderRadius: 50,
                                color: '#E3F2FD',
                              ),
                              child: MCPUIJsonGenerator.icon(
                                icon: 'person',
                                size: 48,
                                color: '#2196F3',
                              ),
                            ),
                            MCPUIJsonGenerator.sizedBox(height: 16),
                            MCPUIJsonGenerator.text(
                              '{{currentUser.name}}',
                              style: MCPUIJsonGenerator.textStyle(
                                fontSize: 24,
                                fontWeight: 'bold',
                              ),
                            ),
                            MCPUIJsonGenerator.text(
                              '{{currentUser.email}}',
                              style: MCPUIJsonGenerator.textStyle(
                                fontSize: 16,
                                color: '#666666',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    MCPUIJsonGenerator.sizedBox(height: 24),

                    // Profile options
                    MCPUIJsonGenerator.column(
                      children: [
                        MCPUIJsonGenerator.card(
                          child: MCPUIJsonGenerator.column(
                            children: [
                              MCPUIJsonGenerator.listTile(
                                leading: MCPUIJsonGenerator.icon(icon: 'edit'),
                                title: 'Edit Profile',
                                subtitle: 'Update your personal information',
                                trailing: MCPUIJsonGenerator.icon(
                                    icon: 'arrow_forward_ios'),
                                onTap: MCPUIJsonGenerator.navigationAction(
                                  action: 'push',
                                  route: '/profile/edit',
                                ),
                              ),
                              MCPUIJsonGenerator.divider(),
                              MCPUIJsonGenerator.listTile(
                                leading:
                                    MCPUIJsonGenerator.icon(icon: 'security'),
                                title: 'Security',
                                subtitle: 'Password and security settings',
                                trailing: MCPUIJsonGenerator.icon(
                                    icon: 'arrow_forward_ios'),
                                onTap: MCPUIJsonGenerator.navigationAction(
                                  action: 'push',
                                  route: '/profile/security',
                                ),
                              ),
                              MCPUIJsonGenerator.divider(),
                              MCPUIJsonGenerator.listTile(
                                leading: MCPUIJsonGenerator.icon(
                                    icon: 'notifications'),
                                title: 'Notifications',
                                subtitle: 'Manage notification preferences',
                                trailing: MCPUIJsonGenerator.icon(
                                    icon: 'arrow_forward_ios'),
                                onTap: MCPUIJsonGenerator.navigationAction(
                                  action: 'push',
                                  route: '/profile/notifications',
                                ),
                              ),
                            ],
                          ),
                        ),
                        MCPUIJsonGenerator.sizedBox(height: 16),
                        MCPUIJsonGenerator.card(
                          child: MCPUIJsonGenerator.column(
                            children: [
                              MCPUIJsonGenerator.listTile(
                                leading: MCPUIJsonGenerator.icon(
                                  icon: 'logout',
                                  color: '#F44336',
                                ),
                                title: 'Sign Out',
                                onTap: MCPUIJsonGenerator.toolAction('signOut'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
      .build();

  ExampleFileWriter.writeJsonFile(profilePage, 'profile_page.json');
  print('✓ Profile page created: profile_page.json');
}

/// Create settings page
void _createSettingsPage() {
  final settingsPage = MCPUIBuilder.page(title: 'Settings')
      .content(
    MCPUIJsonGenerator.column(
      children: [
        MCPUIJsonGenerator.appBar(title: 'Settings'),
        MCPUIJsonGenerator.expanded(
          child: MCPUIJsonGenerator.padding(
            padding: MCPUIJsonGenerator.edgeInsets(all: 16),
            child: MCPUIJsonGenerator.column(
              children: [
                // General settings
                QuickBuilders.section(
                  title: 'General',
                  children: [
                    MCPUIJsonGenerator.card(
                      child: MCPUIJsonGenerator.column(
                        children: [
                          MCPUIJsonGenerator.listTile(
                            leading: MCPUIJsonGenerator.icon(icon: 'dark_mode'),
                            title: 'Dark Mode',
                            subtitle: 'Switch to dark theme',
                            trailing: MCPUIJsonGenerator.switchWidget(
                              value: '{{settings.darkMode}}',
                              onChange: MCPUIJsonGenerator.stateAction(
                                action: 'toggle',
                                binding: 'settings.darkMode',
                              ),
                            ),
                          ),
                          MCPUIJsonGenerator.divider(),
                          MCPUIJsonGenerator.listTile(
                            leading: MCPUIJsonGenerator.icon(icon: 'language'),
                            title: 'Language',
                            subtitle: 'Choose your language',
                            trailing: MCPUIJsonGenerator.row(
                              mainAxisSize: 'min',
                              children: [
                                MCPUIJsonGenerator.text(
                                    '{{settings.language}}'),
                                MCPUIJsonGenerator.icon(
                                    icon: 'arrow_forward_ios'),
                              ],
                            ),
                            onTap: MCPUIJsonGenerator.navigationAction(
                              action: 'push',
                              route: '/settings/language',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                MCPUIJsonGenerator.sizedBox(height: 24),

                // Notification settings
                QuickBuilders.section(
                  title: 'Notifications',
                  children: [
                    MCPUIJsonGenerator.card(
                      child: MCPUIJsonGenerator.column(
                        children: [
                          MCPUIJsonGenerator.listTile(
                            leading:
                                MCPUIJsonGenerator.icon(icon: 'notifications'),
                            title: 'Push Notifications',
                            subtitle: 'Receive push notifications',
                            trailing: MCPUIJsonGenerator.switchWidget(
                              value: '{{settings.notifications}}',
                              onChange: MCPUIJsonGenerator.stateAction(
                                action: 'toggle',
                                binding: 'settings.notifications',
                              ),
                            ),
                          ),
                          MCPUIJsonGenerator.divider(),
                          MCPUIJsonGenerator.listTile(
                            leading: MCPUIJsonGenerator.icon(icon: 'email'),
                            title: 'Email Notifications',
                            subtitle: 'Receive email updates',
                            trailing: MCPUIJsonGenerator.switchWidget(
                              value: '{{settings.emailNotifications}}',
                              onChange: MCPUIJsonGenerator.stateAction(
                                action: 'toggle',
                                binding: 'settings.emailNotifications',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                MCPUIJsonGenerator.sizedBox(height: 24),

                // Account settings
                QuickBuilders.section(
                  title: 'Account',
                  children: [
                    MCPUIJsonGenerator.card(
                      child: MCPUIJsonGenerator.column(
                        children: [
                          MCPUIJsonGenerator.listTile(
                            leading: MCPUIJsonGenerator.icon(icon: 'backup'),
                            title: 'Backup & Sync',
                            subtitle: 'Backup your data to cloud',
                            trailing: MCPUIJsonGenerator.icon(
                                icon: 'arrow_forward_ios'),
                          ),
                          MCPUIJsonGenerator.divider(),
                          MCPUIJsonGenerator.listTile(
                            leading: MCPUIJsonGenerator.icon(icon: 'storage'),
                            title: 'Storage',
                            subtitle: 'Manage storage usage',
                            trailing: MCPUIJsonGenerator.icon(
                                icon: 'arrow_forward_ios'),
                          ),
                          MCPUIJsonGenerator.divider(),
                          MCPUIJsonGenerator.listTile(
                            leading: MCPUIJsonGenerator.icon(
                              icon: 'delete',
                              color: '#F44336',
                            ),
                            title: 'Delete Account',
                            subtitle: 'Permanently delete your account',
                            trailing: MCPUIJsonGenerator.icon(
                                icon: 'arrow_forward_ios'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  )
      .initialState({
    'settings': {
      'darkMode': false,
      'language': 'English',
      'notifications': true,
      'emailNotifications': false,
    },
  }).build();

  ExampleFileWriter.writeJsonFile(settingsPage, 'settings_page.json');
  print('✓ Settings page created: settings_page.json');
}

/// Create about page
void _createAboutPage() {
  final aboutPage = MCPUIBuilder.page(title: 'About')
      .content(
        MCPUIJsonGenerator.column(
          children: [
            MCPUIJsonGenerator.appBar(title: 'About'),
            MCPUIJsonGenerator.expanded(
              child: MCPUIJsonGenerator.padding(
                padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                child: MCPUIJsonGenerator.column(
                  children: [
                    // App information
                    MCPUIJsonGenerator.card(
                      child: MCPUIJsonGenerator.padding(
                        padding: MCPUIJsonGenerator.edgeInsets(all: 24),
                        child: MCPUIJsonGenerator.column(
                          children: [
                            MCPUIJsonGenerator.icon(
                              icon: 'info',
                              size: 64,
                              color: '#2196F3',
                            ),
                            MCPUIJsonGenerator.sizedBox(height: 16),
                            MCPUIJsonGenerator.text(
                              'Multi-Page Demo App',
                              style: MCPUIJsonGenerator.textStyle(
                                fontSize: 24,
                                fontWeight: 'bold',
                              ),
                            ),
                            MCPUIJsonGenerator.sizedBox(height: 8),
                            MCPUIJsonGenerator.text(
                              'Version 1.0.0',
                              style: MCPUIJsonGenerator.textStyle(
                                fontSize: 16,
                                color: '#666666',
                              ),
                            ),
                            MCPUIJsonGenerator.sizedBox(height: 16),
                            MCPUIJsonGenerator.text(
                              'A demonstration of multi-page navigation using Flutter MCP UI Generator.',
                              textAlign: 'center',
                              style: MCPUIJsonGenerator.textStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),

                    MCPUIJsonGenerator.sizedBox(height: 24),

                    // Links
                    MCPUIJsonGenerator.card(
                      child: MCPUIJsonGenerator.column(
                        children: [
                          MCPUIJsonGenerator.listTile(
                            leading: MCPUIJsonGenerator.icon(icon: 'help'),
                            title: 'Help & Support',
                            trailing: MCPUIJsonGenerator.icon(
                                icon: 'arrow_forward_ios'),
                          ),
                          MCPUIJsonGenerator.divider(),
                          MCPUIJsonGenerator.listTile(
                            leading: MCPUIJsonGenerator.icon(icon: 'policy'),
                            title: 'Privacy Policy',
                            trailing: MCPUIJsonGenerator.icon(
                                icon: 'arrow_forward_ios'),
                          ),
                          MCPUIJsonGenerator.divider(),
                          MCPUIJsonGenerator.listTile(
                            leading:
                                MCPUIJsonGenerator.icon(icon: 'description'),
                            title: 'Terms of Service',
                            trailing: MCPUIJsonGenerator.icon(
                                icon: 'arrow_forward_ios'),
                          ),
                          MCPUIJsonGenerator.divider(),
                          MCPUIJsonGenerator.listTile(
                            leading: MCPUIJsonGenerator.icon(icon: 'star'),
                            title: 'Rate This App',
                            trailing: MCPUIJsonGenerator.icon(
                                icon: 'arrow_forward_ios'),
                          ),
                        ],
                      ),
                    ),

                    MCPUIJsonGenerator.sizedBox(height: 24),

                    // Developer info
                    MCPUIJsonGenerator.text(
                      'Made with Flutter MCP UI Generator',
                      style: MCPUIJsonGenerator.textStyle(
                        fontSize: 14,
                        color: '#999999',
                      ),
                      textAlign: 'center',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
      .build();

  ExampleFileWriter.writeJsonFile(aboutPage, 'about_page.json');
  print('✓ About page created: about_page.json');
}
