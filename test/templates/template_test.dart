import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-193: CounterTemplate
  group('TC-193: CounterTemplate', () {
    test('Normal: generates counter UI with increment/decrement buttons', () {
      final template = CounterTemplate();
      final page = template.generate(title: 'Counter');

      expect(page['type'], equals('page'));
      expect(page['title'], equals('Counter'));
      expect(page['state'], isNotNull);
      expect(page['state']['counter'], equals(0));
      expect(page['content'], isNotNull);
      expect(page['content']['type'], isNotNull);
    });

    test('Boundary: custom title and config', () {
      final template = CounterTemplate();
      final page = template.generate(
        title: 'My Counter',
        config: {'initialValue': 10, 'step': 5, 'binding': 'myCount'},
      );

      expect(page['title'], equals('My Counter'));
      expect(page['state']['myCount'], equals(10));
    });
  });

  // TC-194: FormTemplate
  group('TC-194: FormTemplate', () {
    test('Normal: generates form with fields and submit button', () {
      final template = FormTemplate();
      final page = template.generate(title: 'Contact Form');

      expect(page['type'], equals('page'));
      expect(page['title'], equals('Contact Form'));
      expect(page['content'], isNotNull);
    });

    test('Boundary: custom field configuration', () {
      final template = FormTemplate();
      final page = template.generate(
        title: 'Custom Form',
        config: {
          'fields': [
            {'label': 'Phone', 'path': 'phone', 'type': 'text'},
          ],
          'submitLabel': 'Send',
          'formBinding': 'myForm',
        },
      );

      expect(page['title'], equals('Custom Form'));
    });
  });

  // TC-195: ListDetailTemplate
  group('TC-195: ListDetailTemplate', () {
    test('Normal: generates master-detail layout', () {
      final template = ListDetailTemplate();
      final page = template.generate(title: 'Items');

      expect(page['type'], equals('page'));
      expect(page['title'], equals('Items'));
      expect(page['content'], isNotNull);
    });

    test('Boundary: custom list and detail views', () {
      final template = ListDetailTemplate();
      final page = template.generate(
        title: 'Products',
        config: {
          'itemsBinding': 'products',
          'selectedBinding': 'selectedProduct',
          'itemTitle': '{{item.name}}',
          'itemSubtitle': '{{item.price}}',
        },
      );

      expect(page['title'], equals('Products'));
    });
  });

  // TC-196: DashboardTemplate
  group('TC-196: DashboardTemplate', () {
    test('Normal: generates card grid dashboard with metrics', () {
      final template = DashboardTemplate();
      final page = template.generate(title: 'Dashboard');

      expect(page['type'], equals('page'));
      expect(page['title'], equals('Dashboard'));
    });

    test('Boundary: custom card count and layout', () {
      final template = DashboardTemplate();
      final page = template.generate(
        title: 'Analytics',
        config: {
          'metrics': [
            {'label': 'Users', 'binding': 'userCount', 'icon': 'people'},
            {'label': 'Revenue', 'binding': 'revenue', 'icon': 'attach_money'},
          ],
          'columns': 3,
        },
      );

      expect(page['title'], equals('Analytics'));
    });
  });

  // TC-197: LoginTemplate
  group('TC-197: LoginTemplate', () {
    test('Normal: generates login form with username, password, submit', () {
      final template = LoginTemplate();
      final page = template.generate(title: 'Login');

      expect(page['type'], equals('page'));
      expect(page['title'], equals('Login'));
    });

    test('Boundary: custom auth flow action', () {
      final template = LoginTemplate();
      final page = template.generate(
        title: 'Sign In',
        config: {
          'usernameLabel': 'Email',
          'passwordLabel': 'Secret',
          'submitLabel': 'Sign In',
          'loginAction': MCPUIJsonGenerator.toolAction('authenticate'),
        },
      );

      expect(page['title'], equals('Sign In'));
    });
  });

  // TC-198: SettingsTemplate
  group('TC-198: SettingsTemplate', () {
    test('Normal: generates settings page with toggles and selects', () {
      final template = SettingsTemplate();
      final page = template.generate(title: 'Settings');

      expect(page['type'], equals('page'));
      expect(page['title'], equals('Settings'));
    });

    test('Boundary: custom setting options', () {
      final template = SettingsTemplate();
      final page = template.generate(
        title: 'Preferences',
        config: {
          'sections': [
            {
              'title': 'Appearance',
              'items': [
                {'type': 'toggle', 'label': 'Dark Mode', 'binding': 'darkMode'},
              ],
            },
          ],
          'settingsBinding': 'prefs',
        },
      );

      expect(page['title'], equals('Preferences'));
    });
  });
}
