import 'json_generator.dart';

/// Fluent API for building MCP UI definitions
///
/// Provides a chainable interface for constructing UI definitions
/// Compatible with MCP UI DSL v1.0 specification
class MCPUIBuilder {
  final Map<String, dynamic> _definition = {};

  MCPUIBuilder();

  // ===== Application Builder =====

  /// Start building an application
  static ApplicationBuilder application({
    required String title,
    required String version,
  }) {
    return ApplicationBuilder(title: title, version: version);
  }

  /// Start building a page
  static PageBuilder page({
    required String title,
  }) {
    return PageBuilder(title: title);
  }

  // ===== Widget Builders =====

  /// Start with a linear layout (MCP UI DSL v1.0)
  static LinearBuilder linear() => LinearBuilder();

  /// Start with a box (MCP UI DSL v1.0)
  static BoxBuilder box() => BoxBuilder();

  /// Start with a stack
  static StackBuilder stack() => StackBuilder();

  /// Start with a center
  static CenterBuilder center() => CenterBuilder();

  /// Start with a card
  static CardBuilder card() => CardBuilder();

  /// Start with a list view
  static ListViewBuilder listView({
    required String items,
    required Map<String, dynamic> itemTemplate,
  }) {
    return ListViewBuilder(items: items, itemTemplate: itemTemplate);
  }

  /// Start with a grid view
  static GridViewBuilder gridView({
    required String items,
    required Map<String, dynamic> itemTemplate,
  }) {
    return GridViewBuilder(items: items, itemTemplate: itemTemplate);
  }

  /// Build the final definition
  Map<String, dynamic> build() => _definition;
}

// ===== Application Builder =====

class ApplicationBuilder {
  final Map<String, dynamic> _definition;
  final Map<String, String> _routes = {};

  ApplicationBuilder({
    required String title,
    required String version,
  }) : _definition = {
          'type': 'application',
          'title': title,
          'version': version,
          'routes': {},
        } {
    _definition['routes'] = _routes;
  }

  ApplicationBuilder initialRoute(String route) {
    _definition['initialRoute'] = route;
    return this;
  }

  ApplicationBuilder addRoute(String path, String resourceUri) {
    _routes[path] = resourceUri;
    return this;
  }

  ApplicationBuilder theme(Map<String, dynamic> theme) {
    _definition['theme'] = theme;
    return this;
  }

  /// Add a complete theme with all sections
  ApplicationBuilder fullTheme({
    String mode = 'light',
    Map<String, dynamic>? colors,
    Map<String, dynamic>? typography,
    Map<String, dynamic>? spacing,
    Map<String, dynamic>? borderRadius,
    Map<String, dynamic>? elevation,
    Map<String, dynamic>? light,
    Map<String, dynamic>? dark,
  }) {
    _definition['theme'] = {
      'mode': mode,
      if (colors != null) 'colors': colors,
      if (typography != null) 'typography': typography,
      if (spacing != null) 'spacing': spacing,
      if (borderRadius != null) 'borderRadius': borderRadius,
      if (elevation != null) 'elevation': elevation,
      if (light != null) 'light': light,
      if (dark != null) 'dark': dark,
    };
    return this;
  }

  /// Set theme mode
  ApplicationBuilder themeMode(String mode) {
    if (_definition['theme'] == null) {
      _definition['theme'] = {};
    }
    _definition['theme']['mode'] = mode;
    return this;
  }

  /// Add theme colors
  ApplicationBuilder themeColors(Map<String, dynamic> colors) {
    if (_definition['theme'] == null) {
      _definition['theme'] = {};
    }
    _definition['theme']['colors'] = colors;
    return this;
  }

  /// Add theme typography
  ApplicationBuilder themeTypography(Map<String, dynamic> typography) {
    if (_definition['theme'] == null) {
      _definition['theme'] = {};
    }
    _definition['theme']['typography'] = typography;
    return this;
  }

  /// Add theme spacing
  ApplicationBuilder themeSpacing(Map<String, dynamic> spacing) {
    if (_definition['theme'] == null) {
      _definition['theme'] = {};
    }
    _definition['theme']['spacing'] = spacing;
    return this;
  }

  ApplicationBuilder navigation(Map<String, dynamic> navigation) {
    _definition['navigation'] = navigation;
    return this;
  }

  ApplicationBuilder initialState(Map<String, dynamic> state) {
    _definition['state'] = {'initial': state};
    return this;
  }

  Map<String, dynamic> build() => _definition;
}

// ===== Page Builder =====

class PageBuilder {
  final Map<String, dynamic> _definition;

  PageBuilder({required String title})
      : _definition = {
          'type': 'page',
          'title': title,
        };

  PageBuilder content(Map<String, dynamic> content) {
    _definition['content'] = content;
    return this;
  }

  PageBuilder route(String route) {
    _definition['route'] = route;
    return this;
  }

  PageBuilder initialState(Map<String, dynamic> state) {
    _definition['state'] = {'initial': state};
    return this;
  }

  PageBuilder onInit(List<Map<String, dynamic>> actions) {
    _definition['lifecycle'] ??= <String, dynamic>{};
    (_definition['lifecycle'] as Map<String, dynamic>)['onInit'] = actions;
    return this;
  }

  PageBuilder onDestroy(List<Map<String, dynamic>> actions) {
    _definition['lifecycle'] ??= <String, dynamic>{};
    (_definition['lifecycle'] as Map<String, dynamic>)['onDestroy'] = actions;
    return this;
  }

  Map<String, dynamic> build() => _definition;
}

// ===== Layout Widget Builders =====

/// Builder for box widgets (MCP UI DSL v1.0)
class BoxBuilder {
  final Map<String, dynamic> _definition = {'type': 'box'};

  BoxBuilder child(Map<String, dynamic> child) {
    _definition['child'] = child;
    return this;
  }

  BoxBuilder width(double width) {
    _definition['width'] = width;
    return this;
  }

  BoxBuilder height(double height) {
    _definition['height'] = height;
    return this;
  }

  BoxBuilder color(String color) {
    _definition['color'] = color;
    return this;
  }

  BoxBuilder padding(Map<String, dynamic> padding) {
    _definition['padding'] = padding;
    return this;
  }

  BoxBuilder margin(Map<String, dynamic> margin) {
    _definition['margin'] = margin;
    return this;
  }

  BoxBuilder decoration(Map<String, dynamic> decoration) {
    _definition['decoration'] = decoration;
    return this;
  }

  Map<String, dynamic> build() => _definition;
}

class StackBuilder {
  final Map<String, dynamic> _definition = {
    'type': 'stack',
    'children': [],
  };

  StackBuilder add(Map<String, dynamic> child) {
    (_definition['children'] as List).add(child);
    return this;
  }

  StackBuilder addAll(List<Map<String, dynamic>> children) {
    (_definition['children'] as List).addAll(children);
    return this;
  }

  StackBuilder alignment(String alignment) {
    _definition['alignment'] = alignment;
    return this;
  }

  StackBuilder fit(String fit) {
    _definition['fit'] = fit;
    return this;
  }

  Map<String, dynamic> build() => _definition;
}

class CenterBuilder {
  final Map<String, dynamic> _definition = {'type': 'center'};

  CenterBuilder child(Map<String, dynamic> child) {
    _definition['child'] = child;
    return this;
  }

  Map<String, dynamic> build() => _definition;
}

class CardBuilder {
  final Map<String, dynamic> _definition = {'type': 'card'};

  CardBuilder child(Map<String, dynamic> child) {
    _definition['child'] = child;
    return this;
  }

  CardBuilder elevation(double elevation) {
    _definition['elevation'] = elevation;
    return this;
  }

  CardBuilder margin(Map<String, dynamic> margin) {
    _definition['margin'] = margin;
    return this;
  }

  CardBuilder shape(Map<String, dynamic> shape) {
    _definition['shape'] = shape;
    return this;
  }

  Map<String, dynamic> build() => _definition;
}

// ===== List Widget Builders =====

class ListViewBuilder {
  final Map<String, dynamic> _definition;

  ListViewBuilder({
    required String items,
    required Map<String, dynamic> itemTemplate,
  }) : _definition = {
          'type': 'list',
          'items': items,
          'itemTemplate': itemTemplate,
        };

  ListViewBuilder itemSpacing(double spacing) {
    _definition['itemSpacing'] = spacing;
    return this;
  }

  ListViewBuilder shrinkWrap(bool shrinkWrap) {
    _definition['shrinkWrap'] = shrinkWrap;
    return this;
  }

  ListViewBuilder scrollDirection(String direction) {
    _definition['scrollDirection'] = direction;
    return this;
  }

  Map<String, dynamic> build() => _definition;
}

class GridViewBuilder {
  final Map<String, dynamic> _definition;

  GridViewBuilder({
    required String items,
    required Map<String, dynamic> itemTemplate,
  }) : _definition = {
          'type': 'grid',
          'items': items,
          'itemTemplate': itemTemplate,
        };

  GridViewBuilder crossAxisCount(int count) {
    _definition['crossAxisCount'] = count;
    return this;
  }

  GridViewBuilder mainAxisSpacing(double spacing) {
    _definition['mainAxisSpacing'] = spacing;
    return this;
  }

  GridViewBuilder crossAxisSpacing(double spacing) {
    _definition['crossAxisSpacing'] = spacing;
    return this;
  }

  GridViewBuilder childAspectRatio(double ratio) {
    _definition['childAspectRatio'] = ratio;
    return this;
  }

  Map<String, dynamic> build() => _definition;
}

// ===== Quick Builders =====

/// Quick builder functions for common patterns
class QuickBuilders {
  /// Create a simple text button
  static Map<String, dynamic> textButton(
      String label, Map<String, dynamic> click) {
    return MCPUIJsonGenerator.button(
      label: label,
      click: click,
      style: 'text',
    );
  }

  /// Create an elevated button with icon
  static Map<String, dynamic> iconButton({
    required String label,
    required String icon,
    required Map<String, dynamic> click,
  }) {
    return MCPUIJsonGenerator.button(
      label: label,
      icon: icon,
      click: click,
      style: 'elevated',
    );
  }

  /// Create a simple form field
  static Map<String, dynamic> formField({
    required String label,
    required String path,
    String? placeholder,
    String? helperText,
  }) {
    return MCPUIJsonGenerator.textInput(
      label: label,
      value: MCPUIJsonGenerator.binding(path),
      change: MCPUIJsonGenerator.stateAction(
        action: 'set',
        binding: path,
        value: '{{event.value}}',
      ),
      placeholder: placeholder,
      helperText: helperText,
    );
  }

  /// Create a labeled section
  static Map<String, dynamic> section({
    required String title,
    required List<Map<String, dynamic>> children,
  }) {
    return MCPUIJsonGenerator.linear(
      direction: 'vertical',
      children: [
        MCPUIJsonGenerator.text(
          title,
          style: MCPUIJsonGenerator.textStyle(
            fontSize: 18,
            fontWeight: 'bold',
          ),
        ),
        MCPUIJsonGenerator.sizedBox(height: 8),
        ...children,
      ],
    );
  }

  /// Create a loading indicator
  static Map<String, dynamic> loadingIndicator([String? message]) {
    return MCPUIJsonGenerator.center(
      child: MCPUIJsonGenerator.linear(
        direction: 'vertical',
        children: [
          MCPUIJsonGenerator.loadingIndicator(indicatorType: 'circular'),
          if (message != null) ...[
            MCPUIJsonGenerator.sizedBox(height: 16),
            MCPUIJsonGenerator.text(message),
          ],
        ],
      ),
    );
  }

  /// Create an error message
  static Map<String, dynamic> errorMessage(String message) {
    return MCPUIJsonGenerator.box(
      padding: MCPUIJsonGenerator.edgeInsets(all: 16),
      decoration: MCPUIJsonGenerator.decoration(
        color: '#FFffebee',
        borderRadius: 8,
      ),
      child: MCPUIJsonGenerator.linear(
        direction: 'horizontal',
        children: [
          MCPUIJsonGenerator.icon(
            icon: 'error',
            color: '#FFc62828',
          ),
          MCPUIJsonGenerator.sizedBox(width: 8),
          MCPUIJsonGenerator.expanded(
            child: MCPUIJsonGenerator.text(
              message,
              style: MCPUIJsonGenerator.textStyle(color: '#FFc62828'),
            ),
          ),
        ],
      ),
    );
  }
}

/// Builder for linear layout (MCP UI DSL v1.0)
class LinearBuilder {
  final Map<String, dynamic> _definition = {
    'type': 'linear',
    'children': [],
    'direction': 'vertical',
  };

  LinearBuilder add(Map<String, dynamic> child) {
    (_definition['children'] as List).add(child);
    return this;
  }

  LinearBuilder addAll(List<Map<String, dynamic>> children) {
    (_definition['children'] as List).addAll(children);
    return this;
  }

  LinearBuilder direction(String direction) {
    _definition['direction'] = direction;
    return this;
  }

  LinearBuilder distribution(String distribution) {
    _definition['distribution'] = distribution;
    return this;
  }

  LinearBuilder alignment(String alignment) {
    _definition['alignment'] = alignment;
    return this;
  }

  LinearBuilder gap(double gap) {
    _definition['gap'] = gap;
    return this;
  }

  LinearBuilder wrap(bool wrap) {
    _definition['wrap'] = wrap;
    return this;
  }

  /// Set direction to vertical
  LinearBuilder vertical() {
    _definition['direction'] = 'vertical';
    return this;
  }

  /// Set direction to horizontal
  LinearBuilder horizontal() {
    _definition['direction'] = 'horizontal';
    return this;
  }

  Map<String, dynamic> build() => _definition;
}
