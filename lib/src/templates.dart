/// Pre-built templates for common UI patterns
///
/// Each template class generates a complete MCP UI DSL page definition
/// for a specific UI pattern. Templates accept configuration via [generate()]
/// and produce valid `Map<String, dynamic>` output.
import 'json_generator.dart';

/// Base class for all templates
abstract class Template {
  /// Generate a complete page definition for this template pattern
  Map<String, dynamic> generate({
    required String title,
    Map<String, dynamic>? config,
  });
}

/// Counter template: counter value with increment/decrement buttons
///
/// Config options:
/// - `initialValue` (int): Starting counter value (default: 0)
/// - `step` (int): Increment/decrement step (default: 1)
/// - `binding` (String): State binding path (default: 'counter')
class CounterTemplate extends Template {
  @override
  Map<String, dynamic> generate({
    required String title,
    Map<String, dynamic>? config,
  }) {
    final initialValue = config?['initialValue'] as int? ?? 0;
    final step = config?['step'] as int? ?? 1;
    final binding = config?['binding'] as String? ?? 'counter';

    return MCPUIJsonGenerator.page(
      title: title,
      state: {binding: initialValue},
      content: MCPUIJsonGenerator.center(
        child: MCPUIJsonGenerator.linear(
          direction: 'vertical',
          spacing: 16,
          children: [
            MCPUIJsonGenerator.text(
              title,
              style: MCPUIJsonGenerator.textStyle(
                fontSize: 24,
                fontWeight: 'bold',
              ),
            ),
            MCPUIJsonGenerator.text(
              MCPUIJsonGenerator.binding(binding),
              style: MCPUIJsonGenerator.textStyle(fontSize: 48),
            ),
            MCPUIJsonGenerator.linear(
              direction: 'horizontal',
              spacing: 16,
              children: [
                MCPUIJsonGenerator.button(
                  label: '-',
                  click: MCPUIJsonGenerator.stateAction(
                    action: 'decrement',
                    binding: binding,
                    value: step,
                  ),
                  variant: 'outlined',
                ),
                MCPUIJsonGenerator.button(
                  label: '+',
                  click: MCPUIJsonGenerator.stateAction(
                    action: 'increment',
                    binding: binding,
                    value: step,
                  ),
                  variant: 'filled',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Form template: form with fields, validation, and submit
///
/// Config options:
/// - `fields` (List<Map>): List of field configs with `label`, `path`, `type`, `placeholder`, `required`
/// - `submitLabel` (String): Submit button label (default: 'Submit')
/// - `submitAction` (Map): Action to execute on submit
/// - `formBinding` (String): State binding prefix for form data (default: 'form')
class FormTemplate extends Template {
  @override
  Map<String, dynamic> generate({
    required String title,
    Map<String, dynamic>? config,
  }) {
    final fields = (config?['fields'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [
      {'label': 'Name', 'path': 'name', 'type': 'text', 'required': true},
      {'label': 'Email', 'path': 'email', 'type': 'email', 'required': true},
    ];
    final submitLabel = config?['submitLabel'] as String? ?? 'Submit';
    final submitAction = config?['submitAction'] as Map<String, dynamic>?;
    final formBinding = config?['formBinding'] as String? ?? 'form';

    final initialState = <String, dynamic>{};
    final fieldWidgets = <Map<String, dynamic>>[];

    for (final field in fields) {
      final label = field['label'] as String;
      final path = field['path'] as String;
      final fullPath = '$formBinding.$path';
      final placeholder = field['placeholder'] as String?;

      initialState[fullPath] = '';

      fieldWidgets.add(
        MCPUIJsonGenerator.textInput(
          label: label,
          value: MCPUIJsonGenerator.binding(fullPath),
          change: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: fullPath,
            value: '{{event.value}}',
          ),
          placeholder: placeholder,
        ),
      );
      fieldWidgets.add(MCPUIJsonGenerator.sizedBox(height: 12));
    }

    return MCPUIJsonGenerator.page(
      title: title,
      state: initialState,
      content: MCPUIJsonGenerator.padding(
        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
        child: MCPUIJsonGenerator.linear(
          direction: 'vertical',
          spacing: 8,
          children: [
            MCPUIJsonGenerator.text(
              title,
              style: MCPUIJsonGenerator.textStyle(
                fontSize: 24,
                fontWeight: 'bold',
              ),
            ),
            MCPUIJsonGenerator.sizedBox(height: 16),
            ...fieldWidgets,
            MCPUIJsonGenerator.sizedBox(height: 16),
            MCPUIJsonGenerator.button(
              label: submitLabel,
              click: submitAction ?? MCPUIJsonGenerator.stateAction(
                action: 'set',
                binding: '$formBinding._submitted',
                value: true,
              ),
              variant: 'filled',
            ),
          ],
        ),
      ),
    );
  }
}

/// List-detail template: master-detail layout with list and detail pane
///
/// Config options:
/// - `itemsBinding` (String): State binding for items list (default: 'items')
/// - `selectedBinding` (String): State binding for selected item (default: 'selectedItem')
/// - `itemTitle` (String): Binding expression for item title (default: '{{item.title}}')
/// - `itemSubtitle` (String?): Binding expression for item subtitle
/// - `detailContent` (Map?): Custom detail pane widget definition
class ListDetailTemplate extends Template {
  @override
  Map<String, dynamic> generate({
    required String title,
    Map<String, dynamic>? config,
  }) {
    final itemsBinding = config?['itemsBinding'] as String? ?? 'items';
    final selectedBinding = config?['selectedBinding'] as String? ?? 'selectedItem';
    final itemTitle = config?['itemTitle'] as String? ?? '{{item.title}}';
    final itemSubtitle = config?['itemSubtitle'] as String?;
    final detailContent = config?['detailContent'] as Map<String, dynamic>?;

    return MCPUIJsonGenerator.page(
      title: title,
      state: {
        itemsBinding: <dynamic>[],
        selectedBinding: null,
      },
      content: MCPUIJsonGenerator.linear(
        direction: 'horizontal',
        children: [
          // Master pane (list)
          MCPUIJsonGenerator.expanded(
            flex: 1,
            child: MCPUIJsonGenerator.list(
              items: MCPUIJsonGenerator.binding(itemsBinding),
              itemTemplate: MCPUIJsonGenerator.listTile(
                title: itemTitle,
                subtitle: itemSubtitle,
                click: MCPUIJsonGenerator.stateAction(
                  action: 'set',
                  binding: selectedBinding,
                  value: '{{item}}',
                ),
              ),
            ),
          ),
          // Detail pane
          MCPUIJsonGenerator.expanded(
            flex: 2,
            child: detailContent ?? MCPUIJsonGenerator.center(
              child: MCPUIJsonGenerator.conditionalWidget(
                condition: '$selectedBinding != null',
                then: MCPUIJsonGenerator.padding(
                  padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                  child: MCPUIJsonGenerator.linear(
                    direction: 'vertical',
                    spacing: 8,
                    children: [
                      MCPUIJsonGenerator.text(
                        MCPUIJsonGenerator.binding('$selectedBinding.title'),
                        style: MCPUIJsonGenerator.textStyle(
                          fontSize: 24,
                          fontWeight: 'bold',
                        ),
                      ),
                      MCPUIJsonGenerator.text(
                        MCPUIJsonGenerator.binding('$selectedBinding.description'),
                      ),
                    ],
                  ),
                ),
                orElse: MCPUIJsonGenerator.text(
                  'Select an item to view details',
                  style: MCPUIJsonGenerator.textStyle(color: '#FF9E9E9E'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dashboard template: card grid with metric cards
///
/// Config options:
/// - `metrics` (List<Map>): List of metric configs with `label`, `binding`, `icon`, `color`
class DashboardTemplate extends Template {
  @override
  Map<String, dynamic> generate({
    required String title,
    Map<String, dynamic>? config,
  }) {
    final metrics = (config?['metrics'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [
      {'label': 'Users', 'binding': 'metrics.users', 'icon': 'people', 'color': '#FF1976D2'},
      {'label': 'Revenue', 'binding': 'metrics.revenue', 'icon': 'attach_money', 'color': '#FF388E3C'},
      {'label': 'Orders', 'binding': 'metrics.orders', 'icon': 'shopping_cart', 'color': '#FFF57C00'},
      {'label': 'Growth', 'binding': 'metrics.growth', 'icon': 'trending_up', 'color': '#FF7B1FA2'},
    ];
    final initialState = <String, dynamic>{};
    final metricCards = <Map<String, dynamic>>[];

    for (final metric in metrics) {
      final label = metric['label'] as String;
      final binding = metric['binding'] as String;
      final icon = metric['icon'] as String? ?? 'info';
      final color = metric['color'] as String? ?? '#FF1976D2';

      initialState[binding] = 0;

      metricCards.add(
        MCPUIJsonGenerator.card(
          child: MCPUIJsonGenerator.padding(
            padding: MCPUIJsonGenerator.edgeInsets(all: 16),
            child: MCPUIJsonGenerator.linear(
              direction: 'vertical',
              spacing: 8,
              children: [
                MCPUIJsonGenerator.linear(
                  direction: 'horizontal',
                  children: [
                    MCPUIJsonGenerator.icon(icon: icon, color: color),
                    MCPUIJsonGenerator.sizedBox(width: 8),
                    MCPUIJsonGenerator.text(
                      label,
                      style: MCPUIJsonGenerator.textStyle(
                        fontSize: 14,
                        color: '#FF757575',
                      ),
                    ),
                  ],
                ),
                MCPUIJsonGenerator.text(
                  MCPUIJsonGenerator.binding(binding),
                  style: MCPUIJsonGenerator.textStyle(
                    fontSize: 28,
                    fontWeight: 'bold',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return MCPUIJsonGenerator.page(
      title: title,
      state: initialState,
      content: MCPUIJsonGenerator.padding(
        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
        child: MCPUIJsonGenerator.linear(
          direction: 'vertical',
          spacing: 16,
          children: [
            MCPUIJsonGenerator.text(
              title,
              style: MCPUIJsonGenerator.textStyle(
                fontSize: 24,
                fontWeight: 'bold',
              ),
            ),
            {
              'type': 'wrap',
              'spacing': 12,
              'runSpacing': 12,
              'children': metricCards,
            },
          ],
        ),
      ),
    );
  }
}

/// Login template: login form with username/password and auth action
///
/// Config options:
/// - `usernameLabel` (String): Username field label (default: 'Username')
/// - `passwordLabel` (String): Password field label (default: 'Password')
/// - `submitLabel` (String): Login button label (default: 'Login')
/// - `loginAction` (Map): Action to execute on login
/// - `formBinding` (String): State binding prefix (default: 'login')
/// - `showForgotPassword` (bool): Show forgot password link (default: true)
class LoginTemplate extends Template {
  @override
  Map<String, dynamic> generate({
    required String title,
    Map<String, dynamic>? config,
  }) {
    final usernameLabel = config?['usernameLabel'] as String? ?? 'Username';
    final passwordLabel = config?['passwordLabel'] as String? ?? 'Password';
    final submitLabel = config?['submitLabel'] as String? ?? 'Login';
    final loginAction = config?['loginAction'] as Map<String, dynamic>?;
    final formBinding = config?['formBinding'] as String? ?? 'login';
    final showForgotPassword = config?['showForgotPassword'] as bool? ?? true;

    final children = <Map<String, dynamic>>[
      MCPUIJsonGenerator.sizedBox(height: 32),
      MCPUIJsonGenerator.text(
        title,
        style: MCPUIJsonGenerator.textStyle(
          fontSize: 28,
          fontWeight: 'bold',
        ),
      ),
      MCPUIJsonGenerator.sizedBox(height: 32),
      MCPUIJsonGenerator.textInput(
        label: usernameLabel,
        value: MCPUIJsonGenerator.binding('$formBinding.username'),
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: '$formBinding.username',
          value: '{{event.value}}',
        ),
      ),
      MCPUIJsonGenerator.sizedBox(height: 16),
      MCPUIJsonGenerator.textInput(
        label: passwordLabel,
        value: MCPUIJsonGenerator.binding('$formBinding.password'),
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: '$formBinding.password',
          value: '{{event.value}}',
        ),
        obscureText: true,
      ),
      MCPUIJsonGenerator.sizedBox(height: 8),
    ];

    if (showForgotPassword) {
      children.add(
        MCPUIJsonGenerator.button(
          label: 'Forgot Password?',
          click: MCPUIJsonGenerator.navigationAction(
            action: 'push',
            route: '/forgot-password',
          ),
          variant: 'text',
        ),
      );
    }

    children.addAll([
      MCPUIJsonGenerator.sizedBox(height: 24),
      MCPUIJsonGenerator.button(
        label: submitLabel,
        click: loginAction ?? MCPUIJsonGenerator.toolAction(
          'auth.login',
          params: {
            'username': MCPUIJsonGenerator.binding('$formBinding.username'),
            'password': MCPUIJsonGenerator.binding('$formBinding.password'),
          },
        ),
        variant: 'filled',
      ),
    ]);

    // Show error message if login failed
    children.add(
      MCPUIJsonGenerator.conditionalWidget(
        condition: '$formBinding.error != null',
        then: MCPUIJsonGenerator.padding(
          padding: MCPUIJsonGenerator.edgeInsets(top: 16),
          child: MCPUIJsonGenerator.text(
            MCPUIJsonGenerator.binding('$formBinding.error'),
            style: MCPUIJsonGenerator.textStyle(color: '#FFF44336'),
          ),
        ),
      ),
    );

    return MCPUIJsonGenerator.page(
      title: title,
      state: {
        '$formBinding.username': '',
        '$formBinding.password': '',
        '$formBinding.error': null,
      },
      content: MCPUIJsonGenerator.center(
        child: MCPUIJsonGenerator.box(
          width: 360,
          padding: MCPUIJsonGenerator.edgeInsets(all: 24),
          child: MCPUIJsonGenerator.linear(
            direction: 'vertical',
            children: children,
          ),
        ),
      ),
    );
  }
}

/// Settings template: settings page with toggles, selects, and sections
///
/// Config options:
/// - `sections` (List<Map>): List of section configs with `title` and `items`
///   Each item has: `type` (toggle/select/slider), `label`, `binding`, and type-specific config
/// - `settingsBinding` (String): State binding prefix (default: 'settings')
class SettingsTemplate extends Template {
  @override
  Map<String, dynamic> generate({
    required String title,
    Map<String, dynamic>? config,
  }) {
    final sections = (config?['sections'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [
      {
        'title': 'General',
        'items': [
          {'type': 'toggle', 'label': 'Dark Mode', 'binding': 'darkMode'},
          {'type': 'toggle', 'label': 'Notifications', 'binding': 'notifications'},
        ],
      },
      {
        'title': 'Preferences',
        'items': [
          {
            'type': 'select',
            'label': 'Language',
            'binding': 'language',
            'options': [
              {'value': 'en', 'label': 'English'},
              {'value': 'ko', 'label': 'Korean'},
              {'value': 'ja', 'label': 'Japanese'},
            ],
          },
          {
            'type': 'slider',
            'label': 'Font Size',
            'binding': 'fontSize',
            'min': 12,
            'max': 24,
          },
        ],
      },
    ];
    final settingsBinding = config?['settingsBinding'] as String? ?? 'settings';

    final initialState = <String, dynamic>{};
    final sectionWidgets = <Map<String, dynamic>>[];

    for (final section in sections) {
      final sectionTitle = section['title'] as String;
      final items = (section['items'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];

      final itemWidgets = <Map<String, dynamic>>[];

      for (final item in items) {
        final type = item['type'] as String;
        final label = item['label'] as String;
        final binding = item['binding'] as String;
        final fullBinding = '$settingsBinding.$binding';

        switch (type) {
          case 'toggle':
            initialState[fullBinding] = item['defaultValue'] ?? false;
            itemWidgets.add(
              MCPUIJsonGenerator.linear(
                direction: 'horizontal',
                children: [
                  MCPUIJsonGenerator.expanded(
                    child: MCPUIJsonGenerator.text(label),
                  ),
                  MCPUIJsonGenerator.toggle(
                    value: MCPUIJsonGenerator.binding(fullBinding),
                    change: MCPUIJsonGenerator.stateAction(
                      action: 'toggle',
                      binding: fullBinding,
                    ),
                  ),
                ],
              ),
            );
            break;

          case 'select':
            final options = (item['options'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
            initialState[fullBinding] = item['defaultValue'] ?? (options.isNotEmpty ? options.first['value'] : '');
            itemWidgets.add(
              MCPUIJsonGenerator.select(
                label: label,
                value: MCPUIJsonGenerator.binding(fullBinding),
                options: options,
                change: MCPUIJsonGenerator.stateAction(
                  action: 'set',
                  binding: fullBinding,
                  value: '{{event.value}}',
                ),
              ),
            );
            break;

          case 'slider':
            final min = (item['min'] as num?)?.toDouble() ?? 0;
            final max = (item['max'] as num?)?.toDouble() ?? 100;
            initialState[fullBinding] = item['defaultValue'] ?? min;
            itemWidgets.add(
              MCPUIJsonGenerator.linear(
                direction: 'vertical',
                children: [
                  MCPUIJsonGenerator.text(label),
                  MCPUIJsonGenerator.slider(
                    value: MCPUIJsonGenerator.binding(fullBinding),
                    min: min,
                    max: max,
                    change: MCPUIJsonGenerator.stateAction(
                      action: 'set',
                      binding: fullBinding,
                      value: '{{event.value}}',
                    ),
                  ),
                ],
              ),
            );
            break;
        }

        itemWidgets.add(MCPUIJsonGenerator.sizedBox(height: 8));
      }

      sectionWidgets.add(
        MCPUIJsonGenerator.linear(
          direction: 'vertical',
          spacing: 4,
          children: [
            MCPUIJsonGenerator.text(
              sectionTitle,
              style: MCPUIJsonGenerator.textStyle(
                fontSize: 18,
                fontWeight: 'bold',
              ),
            ),
            MCPUIJsonGenerator.sizedBox(height: 8),
            ...itemWidgets,
            MCPUIJsonGenerator.sizedBox(height: 16),
          ],
        ),
      );
    }

    return MCPUIJsonGenerator.page(
      title: title,
      state: initialState,
      content: MCPUIJsonGenerator.padding(
        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
        child: MCPUIJsonGenerator.scrollView(
          child: MCPUIJsonGenerator.linear(
            direction: 'vertical',
            children: [
              MCPUIJsonGenerator.text(
                title,
                style: MCPUIJsonGenerator.textStyle(
                  fontSize: 24,
                  fontWeight: 'bold',
                ),
              ),
              MCPUIJsonGenerator.sizedBox(height: 16),
              ...sectionWidgets,
            ],
          ),
        ),
      ),
    );
  }
}
