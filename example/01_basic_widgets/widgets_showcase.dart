import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

/// Basic Widgets Showcase
/// 
/// This example shows all the basic widgets of Flutter MCP UI Generator.
/// You can see the basic usage of layout, display, input, list, and navigation widgets.
void main() {
  print('=== Flutter MCP UI Generator - Basic Widgets Showcase ===\n');

  // 1. Layout widget examples
  print('1. Layout Widgets');
  _demonstrateLayoutWidgets();
  
  // 2. Display widget examples
  print('\n2. Display Widgets');
  _demonstrateDisplayWidgets();
  
  // 3. Input widget examples
  print('\n3. Input Widgets');
  _demonstrateInputWidgets();
  
  // 4. List widget examples
  print('\n4. List Widgets');
  _demonstrateListWidgets();
  
  // 5. Navigation widget examples
  print('\n5. Navigation Widgets');
  _demonstrateNavigationWidgets();
  
  // 6. Complete page example
  print('\n6. Complete Page Example');
  _demonstrateCompletePage();
  
  print('\n=== All examples completed! ===');
  print('Check the generated JSON files:');
  print('- widgets_showcase_layout.json');
  print('- widgets_showcase_display.json');
  print('- widgets_showcase_input.json');
  print('- widgets_showcase_list.json');
  print('- widgets_showcase_navigation.json');
  print('- widgets_showcase_complete.json');
}

/// Layout widget demo
void _demonstrateLayoutWidgets() {
  // Container example
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

  // Column and Row example
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

  // Stack example
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
  print('✓ Layout widgets example created: widgets_showcase_layout.json');
}

/// Display widget demo
void _demonstrateDisplayWidgets() {
  final displayWidgets = MCPUIJsonGenerator.column(
    children: [
      MCPUIJsonGenerator.text(
        'Display Widgets Showcase',
        style: MCPUIJsonGenerator.textStyle(fontSize: 24, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.divider(thickness: 2, color: '#E0E0E0'),
      
      // Text examples
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
      
      // Icon examples
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
      
      // Image example
      MCPUIJsonGenerator.image(
        src: 'https://picsum.photos/200/100',
        width: 200,
        height: 100,
        fit: 'cover',
      ),
      
      MCPUIJsonGenerator.sizedBox(height: 16),
      MCPUIJsonGenerator.divider(),
      
      // Card example
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
  print('✓ Display widgets example created: widgets_showcase_display.json');
}

/// Input widget demo
void _demonstrateInputWidgets() {
  final inputWidgets = MCPUIJsonGenerator.column(
    children: [
      MCPUIJsonGenerator.text(
        'Input Widgets Showcase',
        style: MCPUIJsonGenerator.textStyle(fontSize: 24, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // Button examples
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
      
      // TextField examples
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
      
      // Checkbox and Switch examples
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
      
      // Slider example
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
      
      // Dropdown example
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
  print('✓ Input widgets example created: widgets_showcase_input.json');
}

/// List widget demo
void _demonstrateListWidgets() {
  final listWidgets = MCPUIJsonGenerator.column(
    children: [
      MCPUIJsonGenerator.text(
        'List Widgets Showcase',
        style: MCPUIJsonGenerator.textStyle(fontSize: 24, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // ListView example
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
      
      // GridView example
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
      
      // ListTile examples
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
  print('✓ List widgets example created: widgets_showcase_list.json');
}

/// Navigation widget demo
void _demonstrateNavigationWidgets() {
  final navigationWidgets = MCPUIJsonGenerator.column(
    children: [
      MCPUIJsonGenerator.text(
        'Navigation Widgets Showcase',
        style: MCPUIJsonGenerator.textStyle(fontSize: 24, fontWeight: 'bold'),
      ),
      MCPUIJsonGenerator.sizedBox(height: 20),
      
      // AppBar example
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
      
      // Bottom Navigation Bar example
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
      
      // Drawer example
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
      
      // Floating Action Button example
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
  print('✓ Navigation widgets example created: widgets_showcase_navigation.json');
}

/// Complete page example
void _demonstrateCompletePage() {
  final completePage = MCPUIJsonGenerator.page(
    title: 'Widget Showcase',
    content: MCPUIJsonGenerator.column(
      children: [
        // Header
        MCPUIJsonGenerator.appBar(
          title: 'Widget Showcase',
          elevation: 2,
          actions: [
            MCPUIJsonGenerator.icon(icon: 'refresh'),
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
                
                // Widget category grid
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
        
        // Bottom navigation
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
  print('✓ Complete page example created: widgets_showcase_complete.json');
}