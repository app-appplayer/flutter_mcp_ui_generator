import 'package:flutter_mcp_ui_generator/src/json_generator.dart';
import 'package:flutter_mcp_ui_generator/src/ui_builder.dart';

void main() {
  // Example 1: Using MCPUIJsonGenerator for theme creation
  print('=== Example 1: Theme with MCPUIJsonGenerator ===');
  
  final myTheme = MCPUIJsonGenerator.theme(
    mode: 'light',
    colors: MCPUIJsonGenerator.themeColors(
      primary: '#4CAF50',
      secondary: '#FF9800',
      background: '#FAFAFA',
    ),
    typography: MCPUIJsonGenerator.themeTypography(
      h1: {'fontSize': 36, 'fontWeight': 'bold'},
      body1: {'fontSize': 18, 'fontWeight': 'normal'},
    ),
    spacing: MCPUIJsonGenerator.themeSpacing(
      md: 20,
      lg: 32,
    ),
  );
  
  // Create application with theme
  final app = MCPUIJsonGenerator.application(
    title: 'Themed App',
    version: '1.0.0',
    theme: myTheme,
    routes: {
      '/home': {'uri': 'ui://pages/home'},
    },
    state: {
      'initial': {
        'themeMode': 'light',
      },
    },
  );
  
  print(MCPUIJsonGenerator.toPrettyJson(app));
  
  // Example 2: Using theme bindings in widgets
  print('\n=== Example 2: Widgets with Theme Bindings ===');
  
  final themedWidget = MCPUIJsonGenerator.column(
    children: [
      MCPUIJsonGenerator.text(
        'Welcome!',
        style: MCPUIJsonGenerator.textStyle(
          fontSize: 32,
          fontWeight: 'bold',
          color: MCPUIJsonGenerator.themeColor('primary'),
        ),
      ),
      MCPUIJsonGenerator.container(
        color: MCPUIJsonGenerator.themeColor('surface'),
        padding: MCPUIJsonGenerator.edgeInsets(
          all: 16, // You could use: MCPUIJsonGenerator.themeSpacingValue('md')
        ),
        child: MCPUIJsonGenerator.text(
          'This is a themed container',
          style: MCPUIJsonGenerator.textStyle(
            color: MCPUIJsonGenerator.themeColor('onSurface'),
            fontSize: 16,
          ),
        ),
      ),
      MCPUIJsonGenerator.button(
        label: 'Themed Button',
        style: 'elevated',
        onTap: MCPUIJsonGenerator.toolAction('handleClick'),
      ),
    ],
  );
  
  print(MCPUIJsonGenerator.toPrettyJson(themedWidget));
  
  // Example 3: Using ApplicationBuilder for complex theme
  print('\n=== Example 3: Complex Theme with Builder ===');
  
  final complexApp = MCPUIBuilder.application(
    title: 'Complex Themed App',
    version: '1.0.0',
  )
    .themeMode('light')
    .themeColors({
      'primary': '#6200EA',
      'secondary': '#03DAC6',
      'background': '#FFFFFF',
      'surface': '#F5F5F5',
      'error': '#B00020',
    })
    .themeTypography({
      'h1': {'fontSize': 32, 'fontWeight': 'bold'},
      'h2': {'fontSize': 28, 'fontWeight': 'bold'},
      'body1': {'fontSize': 16, 'fontWeight': 'normal'},
      'button': {'fontSize': 14, 'fontWeight': 'medium'},
    })
    .themeSpacing({
      'xs': 4,
      'sm': 8,
      'md': 16,
      'lg': 24,
      'xl': 32,
    })
    .addRoute('/dashboard', 'ui://pages/dashboard')
    .addRoute('/settings', 'ui://pages/settings')
    .initialRoute('/dashboard')
    .build();
  
  print(MCPUIJsonGenerator.toPrettyJson(complexApp));
  
  // Example 4: Dark/Light theme modes
  print('\n=== Example 4: Dark/Light Theme Modes ===');
  
  final dualThemeApp = MCPUIJsonGenerator.application(
    title: 'Dual Theme App',
    version: '1.0.0',
    theme: MCPUIJsonGenerator.theme(
      mode: MCPUIJsonGenerator.binding('app.themeMode'),
      light: {
        'colors': {
          'primary': '#2196F3',
          'background': '#FFFFFF',
          'onBackground': '#000000',
        },
      },
      dark: {
        'colors': {
          'primary': '#1976D2',
          'background': '#121212',
          'onBackground': '#FFFFFF',
        },
      },
    ),
    routes: {
      '/home': {'uri': 'ui://pages/home'},
    },
    state: {
      'initial': {
        'themeMode': 'light',
      },
    },
  );
  
  print(MCPUIJsonGenerator.toPrettyJson(dualThemeApp));
  
  // Example 5: Theme binding helpers
  print('\n=== Example 5: Theme Binding Helpers ===');
  
  final bindingExamples = {
    'themeColor': MCPUIJsonGenerator.themeColor('primary'),
    'themeFontSize': MCPUIJsonGenerator.themeTypographyProperty('h1', 'fontSize'),
    'themeSpacing': MCPUIJsonGenerator.themeSpacingValue('md'),
    'themeBorderRadius': MCPUIJsonGenerator.themeBorderRadiusValue('lg'),
    'themeElevation': MCPUIJsonGenerator.themeElevationValue('md'),
  };
  
  print(MCPUIJsonGenerator.toPrettyJson(bindingExamples));
}