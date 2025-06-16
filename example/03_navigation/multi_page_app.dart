import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

/// Multi-Page Application Example
/// 
/// 이 예제는 여러 페이지를 가진 완전한 애플리케이션 구조를 보여줍니다.
/// 앱 정의와 각각의 페이지들을 생성합니다.
void main() {
  print('=== Multi-Page Application Example ===\n');

  // 1. 애플리케이션 정의 생성
  _createApplication();
  
  // 2. 개별 페이지들 생성
  _createHomePage();
  _createProfilePage();
  _createSettingsPage();
  _createAboutPage();
  
  print('\n=== 멀티 페이지 앱 예제가 완료되었습니다! ===');
  print('생성된 파일들:');
  print('- multi_page_app.json (애플리케이션 정의)');
  print('- home_page.json');
  print('- profile_page.json');
  print('- settings_page.json');
  print('- about_page.json');
}

/// 애플리케이션 정의 생성
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
  })
  .navigation({
    'type': 'bottomNavigationBar',
    'items': [
      {'icon': 'home', 'label': 'Home', 'route': '/home'},
      {'icon': 'person', 'label': 'Profile', 'route': '/profile'},
      {'icon': 'settings', 'label': 'Settings', 'route': '/settings'},
      {'icon': 'info', 'label': 'About', 'route': '/about'},
    ],
  })
  .initialState({
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
  })
  .build();

  MCPUIJsonGenerator.generateJsonFile(app, 'multi_page_app.json');
  print('✓ 애플리케이션 정의 생성됨: multi_page_app.json');
}

/// 홈 페이지 생성
void _createHomePage() {
  final homePage = MCPUIBuilder.page(title: 'Home')
    .content(
      MCPUIJsonGenerator.column(
        children: [
          // 앱바
          MCPUIJsonGenerator.appBar(
            title: 'Welcome Home',
            actions: [
              MCPUIJsonGenerator.icon(icon: 'notifications'),
              MCPUIJsonGenerator.icon(icon: 'search'),
            ],
          ),
          
          // 메인 콘텐츠
          MCPUIJsonGenerator.expanded(
            child: MCPUIJsonGenerator.padding(
              padding: MCPUIJsonGenerator.edgeInsets(all: 16),
              child: MCPUIJsonGenerator.column(
                children: [
                  // 환영 카드
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
                  
                  // 빠른 액션 그리드
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
                  
                  // 최근 활동
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
                          trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
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
        {'icon': 'email', 'title': 'New message received', 'time': '2 minutes ago', 'color': '#2196F3'},
        {'icon': 'task_alt', 'title': 'Task completed', 'time': '1 hour ago', 'color': '#4CAF50'},
        {'icon': 'event', 'title': 'Meeting scheduled', 'time': '3 hours ago', 'color': '#FF9800'},
        {'icon': 'upload', 'title': 'File uploaded', 'time': '1 day ago', 'color': '#9C27B0'},
      ],
    })
    .build();

  MCPUIJsonGenerator.generateJsonFile(homePage, 'home_page.json');
  print('✓ 홈 페이지 생성됨: home_page.json');
}

/// 프로필 페이지 생성
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
                  // 프로필 헤더
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
                  
                  // 프로필 옵션들
                  MCPUIJsonGenerator.column(
                    children: [
                      MCPUIJsonGenerator.card(
                        child: MCPUIJsonGenerator.column(
                          children: [
                            MCPUIJsonGenerator.listTile(
                              leading: MCPUIJsonGenerator.icon(icon: 'edit'),
                              title: 'Edit Profile',
                              subtitle: 'Update your personal information',
                              trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
                              onTap: MCPUIJsonGenerator.navigationAction(
                                action: 'push',
                                route: '/profile/edit',
                              ),
                            ),
                            MCPUIJsonGenerator.divider(),
                            MCPUIJsonGenerator.listTile(
                              leading: MCPUIJsonGenerator.icon(icon: 'security'),
                              title: 'Security',
                              subtitle: 'Password and security settings',
                              trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
                              onTap: MCPUIJsonGenerator.navigationAction(
                                action: 'push',
                                route: '/profile/security',
                              ),
                            ),
                            MCPUIJsonGenerator.divider(),
                            MCPUIJsonGenerator.listTile(
                              leading: MCPUIJsonGenerator.icon(icon: 'notifications'),
                              title: 'Notifications',
                              subtitle: 'Manage notification preferences',
                              trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
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

  MCPUIJsonGenerator.generateJsonFile(profilePage, 'profile_page.json');
  print('✓ 프로필 페이지 생성됨: profile_page.json');
}

/// 설정 페이지 생성
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
                  // 일반 설정
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
                                  MCPUIJsonGenerator.text('{{settings.language}}'),
                                  MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
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
                  
                  // 알림 설정
                  QuickBuilders.section(
                    title: 'Notifications',
                    children: [
                      MCPUIJsonGenerator.card(
                        child: MCPUIJsonGenerator.column(
                          children: [
                            MCPUIJsonGenerator.listTile(
                              leading: MCPUIJsonGenerator.icon(icon: 'notifications'),
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
                  
                  // 계정 설정
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
                              trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
                            ),
                            MCPUIJsonGenerator.divider(),
                            MCPUIJsonGenerator.listTile(
                              leading: MCPUIJsonGenerator.icon(icon: 'storage'),
                              title: 'Storage',
                              subtitle: 'Manage storage usage',
                              trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
                            ),
                            MCPUIJsonGenerator.divider(),
                            MCPUIJsonGenerator.listTile(
                              leading: MCPUIJsonGenerator.icon(
                                icon: 'delete',
                                color: '#F44336',
                              ),
                              title: 'Delete Account',
                              subtitle: 'Permanently delete your account',
                              trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
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
    })
    .build();

  MCPUIJsonGenerator.generateJsonFile(settingsPage, 'settings_page.json');
  print('✓ 설정 페이지 생성됨: settings_page.json');
}

/// 정보 페이지 생성
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
                  // 앱 정보
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
                  
                  // 링크들
                  MCPUIJsonGenerator.card(
                    child: MCPUIJsonGenerator.column(
                      children: [
                        MCPUIJsonGenerator.listTile(
                          leading: MCPUIJsonGenerator.icon(icon: 'help'),
                          title: 'Help & Support',
                          trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
                        ),
                        MCPUIJsonGenerator.divider(),
                        MCPUIJsonGenerator.listTile(
                          leading: MCPUIJsonGenerator.icon(icon: 'policy'),
                          title: 'Privacy Policy',
                          trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
                        ),
                        MCPUIJsonGenerator.divider(),
                        MCPUIJsonGenerator.listTile(
                          leading: MCPUIJsonGenerator.icon(icon: 'description'),
                          title: 'Terms of Service',
                          trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
                        ),
                        MCPUIJsonGenerator.divider(),
                        MCPUIJsonGenerator.listTile(
                          leading: MCPUIJsonGenerator.icon(icon: 'star'),
                          title: 'Rate This App',
                          trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
                        ),
                      ],
                    ),
                  ),
                  
                  MCPUIJsonGenerator.sizedBox(height: 24),
                  
                  // 개발자 정보
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

  MCPUIJsonGenerator.generateJsonFile(aboutPage, 'about_page.json');
  print('✓ 정보 페이지 생성됨: about_page.json');
}