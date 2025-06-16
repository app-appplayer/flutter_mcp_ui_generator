import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

/// Basic Widgets Showcase
/// 
/// 이 예제는 Flutter MCP UI Generator의 모든 기본 위젯들을 보여줍니다.
/// 레이아웃, 디스플레이, 입력, 리스트, 네비게이션 위젯들의 기본 사용법을 확인할 수 있습니다.
void main() {
  print('=== Flutter MCP UI Generator - Basic Widgets Showcase ===\n');

  // 1. 레이아웃 위젯 예제
  print('1. Layout Widgets');
  _demonstrateLayoutWidgets();
  
  // 2. 디스플레이 위젯 예제
  print('\n2. Display Widgets');
  _demonstrateDisplayWidgets();
  
  // 3. 입력 위젯 예제
  print('\n3. Input Widgets');
  _demonstrateInputWidgets();
  
  // 4. 리스트 위젯 예제
  print('\n4. List Widgets');
  _demonstrateListWidgets();
  
  // 5. 네비게이션 위젯 예제
  print('\n5. Navigation Widgets');
  _demonstrateNavigationWidgets();
  
  // 6. 완전한 페이지 예제
  print('\n6. Complete Page Example');
  _demonstrateCompletePage();
  
  print('\n=== 모든 예제가 완료되었습니다! ===');
  print('생성된 JSON 파일들을 확인해보세요:');
  print('- widgets_showcase_layout.json');
  print('- widgets_showcase_display.json');
  print('- widgets_showcase_input.json');
  print('- widgets_showcase_list.json');
  print('- widgets_showcase_navigation.json');
  print('- widgets_showcase_complete.json');
}

/// 레이아웃 위젯 데모
void _demonstrateLayoutWidgets() {
  // Container 예제
  final container = MCPUIJsonGenerator.container(
    width: 200,
    height: 100,
    padding: MCPUIJsonGenerator.edgeInsets(all: 16),
    decoration: MCPUIJsonGenerator.decoration(
      color: '#E3F2FD',
      borderRadius: 8,
      border: MCPUIJsonGenerator.border(
        color: '#2196F3',
        width: 2,
      ),
    ),
    child: MCPUIJsonGenerator.center(
      child: MCPUIJsonGenerator.text(
        'Container Example',
        style: MCPUIJsonGenerator.textStyle(
          fontWeight: 'bold',
          color: '#1976D2',
        ),
      ),
    ),
  );

  // Column과 Row 예제
  final columnRow = MCPUIJsonGenerator.column(
    children: [
      MCPUIJsonGenerator.text(
        'Column Layout',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 16),
      MCPUIJsonGenerator.row(
        mainAxisAlignment: 'spaceBetween',
        children: [
          MCPUIJsonGenerator.expanded(
            child: MCPUIJsonGenerator.container(
              color: '#FFEBEE',
              padding: MCPUIJsonGenerator.edgeInsets(all: 8),
              child: MCPUIJsonGenerator.text('Item 1'),
            ),
          ),
          MCPUIJsonGenerator.sizedBox(width: 8),
          MCPUIJsonGenerator.expanded(
            child: MCPUIJsonGenerator.container(
              color: '#E8F5E8',
              padding: MCPUIJsonGenerator.edgeInsets(all: 8),
              child: MCPUIJsonGenerator.text('Item 2'),
            ),
          ),
        ],
      ),
    ],
  );

  // Stack 예제
  final stack = MCPUIJsonGenerator.stack(
    children: [
      MCPUIJsonGenerator.container(
        width: 150,
        height: 150,
        color: '#FFF3E0',
      ),
      MCPUIJsonGenerator.container(
        width: 100,
        height: 100,
        color: '#FFE082',
        margin: MCPUIJsonGenerator.edgeInsets(all: 25),
      ),
      MCPUIJsonGenerator.container(
        width: 50,
        height: 50,
        color: '#FF8F00',
        margin: MCPUIJsonGenerator.edgeInsets(all: 50),
      ),
    ],
    alignment: 'topLeft',
  );

  final layoutPage = MCPUIJsonGenerator.column(
    children: [
      MCPUIJsonGenerator.text(
        'Layout Widgets Showcase',
        style: MCPUIJsonGenerator.textStyle(fontSize: 24, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 20),
      container,
      MCPUIJsonGenerator.sizedBox(height: 20),
      columnRow,
      MCPUIJsonGenerator.sizedBox(height: 20),
      stack,
    ],
  );

  MCPUIJsonGenerator.generateJsonFile(layoutPage, 'widgets_showcase_layout.json');
  print('✓ Layout widgets 예제 생성됨: widgets_showcase_layout.json');
}

/// 디스플레이 위젯 데모
void _demonstrateDisplayWidgets() {
  final displayWidgets = MCPUIJsonGenerator.column(
    children: [
      MCPUIJsonGenerator.text(
        'Display Widgets Showcase',
        style: MCPUIJsonGenerator.textStyle(fontSize: 24, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.divider(thickness: 2, color: '#E0E0E0'),
      
      // Text 예제들
      MCPUIJsonGenerator.text(
        'Basic Text',
        style: MCPUIJsonGenerator.textStyle(fontSize: 16),
      ),
      MCPUIJsonGenerator.text(
        'Bold and Colored Text',
        style: MCPUIJsonGenerator.textStyle(
          fontSize: 18,
          fontWeight: 'bold',
          color: '#F44336',
        ),
      ),
      MCPUIJsonGenerator.text(
        'Styled Text with Decoration',
        style: MCPUIJsonGenerator.textStyle(
          fontSize: 16,
          fontStyle: 'italic',
          decoration: 'underline',
          color: '#4CAF50',
        ),
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 16),
      MCPUIJsonGenerator.divider(),
      
      // Icon 예제들
      MCPUIJsonGenerator.row(
        mainAxisAlignment: 'spaceEvenly',
        children: [
          MCPUIJsonGenerator.icon(icon: 'home', size: 32, color: '#2196F3'),
          MCPUIJsonGenerator.icon(icon: 'star', size: 32, color: '#FF9800'),
          MCPUIJsonGenerator.icon(icon: 'favorite', size: 32, color: '#E91E63'),
          MCPUIJsonGenerator.icon(icon: 'settings', size: 32, color: '#9C27B0'),
        ],
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 16),
      MCPUIJsonGenerator.divider(),
      
      // Image 예제
      MCPUIJsonGenerator.image(
        src: 'https://picsum.photos/200/100',
        width: 200,
        height: 100,
        fit: 'cover',
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 16),
      MCPUIJsonGenerator.divider(),
      
      // Card 예제
      MCPUIJsonGenerator.card(
        elevation: 4,
        margin: MCPUIJsonGenerator.edgeInsets(all: 8),
        child: MCPUIJsonGenerator.padding(
          padding: MCPUIJsonGenerator.edgeInsets(all: 16),
          child: MCPUIJsonGenerator.column(
            children: [
              MCPUIJsonGenerator.text(
                'Card Example',
                style: MCPUIJsonGenerator.textStyle(
                  fontSize: 18,
                  fontWeight: 'bold',
                ),
              ),
              MCPUIJsonGenerator.sizedBox(height: 8),
              MCPUIJsonGenerator.text(
                'This is a card with elevation and padding. Perfect for grouping content.',
              ),
            ],
          ),
        ),
      ),
    ],
  );

  MCPUIJsonGenerator.generateJsonFile(displayWidgets, 'widgets_showcase_display.json');
  print('✓ Display widgets 예제 생성됨: widgets_showcase_display.json');
}

/// 입력 위젯 데모
void _demonstrateInputWidgets() {
  final inputWidgets = MCPUIJsonGenerator.column(
    children: [
      MCPUIJsonGenerator.text(
        'Input Widgets Showcase',
        style: MCPUIJsonGenerator.textStyle(fontSize: 24, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // Button 예제들
      MCPUIJsonGenerator.text(
        'Buttons',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.row(
        mainAxisAlignment: 'spaceEvenly',
        children: [
          MCPUIJsonGenerator.button(
            label: 'Elevated',
            style: 'elevated',
            onTap: MCPUIJsonGenerator.toolAction('buttonPressed', args: {'type': 'elevated'}),
          ),
          MCPUIJsonGenerator.button(
            label: 'Outlined',
            style: 'outlined',
            onTap: MCPUIJsonGenerator.toolAction('buttonPressed', args: {'type': 'outlined'}),
          ),
          MCPUIJsonGenerator.button(
            label: 'Text',
            style: 'text',
            onTap: MCPUIJsonGenerator.toolAction('buttonPressed', args: {'type': 'text'}),
          ),
        ],
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // TextField 예제들
      MCPUIJsonGenerator.text(
        'Text Fields',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.textField(
        label: 'Username',
        placeholder: 'Enter your username',
        value: '{{username}}',
        onChange: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'username',
          value: '{{event.value}}',
        ),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.textField(
        label: 'Password',
        placeholder: 'Enter your password',
        value: '{{password}}',
        obscureText: true,
        onChange: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'password',
          value: '{{event.value}}',
        ),
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // Checkbox와 Switch 예제
      MCPUIJsonGenerator.text(
        'Toggles',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.checkbox(
        label: 'Agree to terms and conditions',
        value: '{{agreeToTerms}}',
        onChange: MCPUIJsonGenerator.stateAction(
          action: 'toggle',
          binding: 'agreeToTerms',
        ),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.switchWidget(
        label: 'Enable notifications',
        value: '{{notifications}}',
        onChange: MCPUIJsonGenerator.stateAction(
          action: 'toggle',
          binding: 'notifications',
        ),
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // Slider 예제
      MCPUIJsonGenerator.text(
        'Slider',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.slider(
        value: '{{volume}}',
        min: 0,
        max: 100,
        divisions: 10,
        label: 'Volume: {{volume}}%',
        onChange: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'volume',
          value: '{{event.value}}',
        ),
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // Dropdown 예제
      MCPUIJsonGenerator.text(
        'Dropdown',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.dropdown(
        label: 'Select Country',
        value: '{{selectedCountry}}',
        items: [
          {'value': 'kr', 'label': 'South Korea'},
          {'value': 'us', 'label': 'United States'},
          {'value': 'jp', 'label': 'Japan'},
          {'value': 'cn', 'label': 'China'},
        ],
        onChange: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'selectedCountry',
          value: '{{event.value}}',
        ),
      ),
    ],
  );

  MCPUIJsonGenerator.generateJsonFile(inputWidgets, 'widgets_showcase_input.json');
  print('✓ Input widgets 예제 생성됨: widgets_showcase_input.json');
}

/// 리스트 위젯 데모
void _demonstrateListWidgets() {
  final listWidgets = MCPUIJsonGenerator.column(
    children: [
      MCPUIJsonGenerator.text(
        'List Widgets Showcase',
        style: MCPUIJsonGenerator.textStyle(fontSize: 24, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // ListView 예제
      MCPUIJsonGenerator.text(
        'List View',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.container(
        height: 200,
        decoration: MCPUIJsonGenerator.decoration(
          border: MCPUIJsonGenerator.border(color: '#E0E0E0', width: 1),
          borderRadius: 8,
        ),
        child: MCPUIJsonGenerator.listView(
          items: '{{todoItems}}',
          itemSpacing: 8,
          itemTemplate: MCPUIJsonGenerator.listTile(
            title: '{{item.title}}',
            subtitle: '{{item.description}}',
            leading: MCPUIJsonGenerator.icon(
              icon: '{{item.completed ? "check_circle" : "radio_button_unchecked"}}',
              color: '{{item.completed ? "#4CAF50" : "#9E9E9E"}}',
            ),
            trailing: MCPUIJsonGenerator.icon(icon: 'more_vert'),
          ),
        ),
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // GridView 예제
      MCPUIJsonGenerator.text(
        'Grid View',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.container(
        height: 200,
        decoration: MCPUIJsonGenerator.decoration(
          border: MCPUIJsonGenerator.border(color: '#E0E0E0', width: 1),
          borderRadius: 8,
        ),
        child: MCPUIJsonGenerator.gridView(
          items: '{{products}}',
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemTemplate: MCPUIJsonGenerator.card(
            child: MCPUIJsonGenerator.column(
              children: [
                MCPUIJsonGenerator.image(
                  src: '{{item.imageUrl}}',
                  height: 80,
                  fit: 'cover',
                ),
                MCPUIJsonGenerator.padding(
                  padding: MCPUIJsonGenerator.edgeInsets(all: 8),
                  child: MCPUIJsonGenerator.column(
                    children: [
                      MCPUIJsonGenerator.text(
                        '{{item.name}}',
                        style: MCPUIJsonGenerator.textStyle(fontWeight: 'bold'),
                      ),
                      MCPUIJsonGenerator.text(
                        '{{item.price}}',
                        style: MCPUIJsonGenerator.textStyle(color: '#4CAF50'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // ListTile 예제들
      MCPUIJsonGenerator.text(
        'List Tiles',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.card(
        child: MCPUIJsonGenerator.column(
          children: [
            MCPUIJsonGenerator.listTile(
              leading: MCPUIJsonGenerator.icon(icon: 'person', color: '#2196F3'),
              title: 'Profile',
              subtitle: 'View and edit your profile',
              trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
            ),
            MCPUIJsonGenerator.divider(),
            MCPUIJsonGenerator.listTile(
              leading: MCPUIJsonGenerator.icon(icon: 'settings', color: '#9C27B0'),
              title: 'Settings',
              subtitle: 'App preferences and configuration',
              trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
            ),
            MCPUIJsonGenerator.divider(),
            MCPUIJsonGenerator.listTile(
              leading: MCPUIJsonGenerator.icon(icon: 'help', color: '#FF9800'),
              title: 'Help & Support',
              subtitle: 'Get help and contact support',
              trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward_ios'),
            ),
          ],
        ),
      ),
    ],
  );

  MCPUIJsonGenerator.generateJsonFile(listWidgets, 'widgets_showcase_list.json');
  print('✓ List widgets 예제 생성됨: widgets_showcase_list.json');
}

/// 네비게이션 위젯 데모
void _demonstrateNavigationWidgets() {
  final navigationWidgets = MCPUIJsonGenerator.column(
    children: [
      MCPUIJsonGenerator.text(
        'Navigation Widgets Showcase',
        style: MCPUIJsonGenerator.textStyle(fontSize: 24, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // AppBar 예제
      MCPUIJsonGenerator.text(
        'App Bar',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.appBar(
        title: 'My Application',
        elevation: 4,
        actions: [
          MCPUIJsonGenerator.icon(icon: 'search'),
          MCPUIJsonGenerator.icon(icon: 'more_vert'),
        ],
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // Bottom Navigation Bar 예제
      MCPUIJsonGenerator.text(
        'Bottom Navigation Bar',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.bottomNavigationBar(
        currentIndex: 0,
        items: [
          {'icon': 'home', 'label': 'Home'},
          {'icon': 'search', 'label': 'Search'},
          {'icon': 'favorite', 'label': 'Favorites'},
          {'icon': 'person', 'label': 'Profile'},
        ],
        onTap: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'currentTab',
          value: '{{event.index}}',
        ),
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // Drawer 예제
      MCPUIJsonGenerator.text(
        'Drawer',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.container(
        width: 300,
        height: 400,
        decoration: MCPUIJsonGenerator.decoration(
          border: MCPUIJsonGenerator.border(color: '#E0E0E0', width: 1),
          borderRadius: 8,
        ),
        child: MCPUIJsonGenerator.drawer(
          child: MCPUIJsonGenerator.column(
            children: [
              MCPUIJsonGenerator.container(
                height: 120,
                color: '#2196F3',
                padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                child: MCPUIJsonGenerator.column(
                  crossAxisAlignment: 'start',
                  mainAxisAlignment: 'end',
                  children: [
                    MCPUIJsonGenerator.text(
                      'John Doe',
                      style: MCPUIJsonGenerator.textStyle(
                        color: 'white',
                        fontSize: 18,
                        fontWeight: 'bold',
                      ),
                    ),
                    MCPUIJsonGenerator.text(
                      'john.doe@example.com',
                      style: MCPUIJsonGenerator.textStyle(color: 'white'),
                    ),
                  ],
                ),
              ),
              MCPUIJsonGenerator.listTile(
                leading: MCPUIJsonGenerator.icon(icon: 'home'),
                title: 'Home',
              ),
              MCPUIJsonGenerator.listTile(
                leading: MCPUIJsonGenerator.icon(icon: 'settings'),
                title: 'Settings',
              ),
              MCPUIJsonGenerator.listTile(
                leading: MCPUIJsonGenerator.icon(icon: 'logout'),
                title: 'Logout',
              ),
            ],
          ),
        ),
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // Floating Action Button 예제
      MCPUIJsonGenerator.text(
        'Floating Action Button',
        style: MCPUIJsonGenerator.textStyle(fontSize: 18, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
      MCPUIJsonGenerator.floatingActionButton(
        onPressed: MCPUIJsonGenerator.toolAction('addNewItem'),
        tooltip: 'Add new item',
        child: MCPUIJsonGenerator.icon(icon: 'add'),
      ),
    ],
  );

  MCPUIJsonGenerator.generateJsonFile(navigationWidgets, 'widgets_showcase_navigation.json');
  print('✓ Navigation widgets 예제 생성됨: widgets_showcase_navigation.json');
}

/// 완전한 페이지 예제
void _demonstrateCompletePage() {
  final completePage = MCPUIJsonGenerator.page(
    title: 'Widget Showcase',
    content: MCPUIJsonGenerator.column(
      children: [
        // 헤더
        MCPUIJsonGenerator.appBar(
          title: 'Widget Showcase',
          elevation: 2,
          actions: [
            MCPUIJsonGenerator.icon(icon: 'refresh'),
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
                    padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                    child: MCPUIJsonGenerator.row(
                      children: [
                        MCPUIJsonGenerator.icon(
                          icon: 'widgets',
                          size: 48,
                          color: '#2196F3',
                        ),
                        MCPUIJsonGenerator.sizedBox(width: 16),
                        MCPUIJsonGenerator.expanded(
                          child: MCPUIJsonGenerator.column(
                            crossAxisAlignment: 'start',
                            children: [
                              MCPUIJsonGenerator.text(
                                'Welcome to Widget Showcase',
                                style: MCPUIJsonGenerator.textStyle(
                                  fontSize: 20,
                                  fontWeight: 'bold',
                                ),
                              ),
                              MCPUIJsonGenerator.sizedBox(height: 8),
                              MCPUIJsonGenerator.text(
                                'Explore all the widgets available in Flutter MCP UI Generator.',
                                style: MCPUIJsonGenerator.textStyle(color: '#666666'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                MCPUIJsonGenerator.sizedBox(height: 20),
                
                // 위젯 카테고리 그리드
                MCPUIJsonGenerator.expanded(
                  child: MCPUIJsonGenerator.gridView(
                    items: '{{widgetCategories}}',
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
                              size: 48,
                              color: '{{item.color}}',
                            ),
                            MCPUIJsonGenerator.sizedBox(height: 12),
                            MCPUIJsonGenerator.text(
                              '{{item.title}}',
                              style: MCPUIJsonGenerator.textStyle(
                                fontSize: 16,
                                fontWeight: 'bold',
                              ),
                              textAlign: 'center',
                            ),
                            MCPUIJsonGenerator.sizedBox(height: 4),
                            MCPUIJsonGenerator.text(
                              '{{item.description}}',
                              style: MCPUIJsonGenerator.textStyle(
                                fontSize: 12,
                                color: '#666666',
                              ),
                              textAlign: 'center',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // 하단 네비게이션
        MCPUIJsonGenerator.bottomNavigationBar(
          currentIndex: 0,
          items: [
            {'icon': 'widgets', 'label': 'Widgets'},
            {'icon': 'code', 'label': 'Examples'},
            {'icon': 'help', 'label': 'Help'},
          ],
          onTap: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'currentTab',
            value: '{{event.index}}',
          ),
        ),
      ],
    ),
    state: {
      'initial': {
        'currentTab': 0,
        'widgetCategories': [
          {
            'title': 'Layout',
            'description': 'Container, Row, Column, Stack',
            'icon': 'view_module',
            'color': '#2196F3',
          },
          {
            'title': 'Display',
            'description': 'Text, Image, Icon, Card',
            'icon': 'visibility',
            'color': '#4CAF50',
          },
          {
            'title': 'Input',
            'description': 'Button, TextField, Slider',
            'icon': 'input',
            'color': '#FF9800',
          },
          {
            'title': 'List',
            'description': 'ListView, GridView, ListTile',
            'icon': 'list',
            'color': '#9C27B0',
          },
        ],
      },
    },
  );

  MCPUIJsonGenerator.generateJsonFile(completePage, 'widgets_showcase_complete.json');
  print('✓ Complete page 예제 생성됨: widgets_showcase_complete.json');
}