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
  
  /// Start with a container
  static ContainerBuilder container() => ContainerBuilder();
  
  /// Start with a column
  static ColumnBuilder column() => ColumnBuilder();
  
  /// Start with a row
  static RowBuilder row() => RowBuilder();
  
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
  
  PageBuilder({required String title}) : _definition = {
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

class ContainerBuilder {
  final Map<String, dynamic> _definition = {'type': 'container'};
  
  ContainerBuilder child(Map<String, dynamic> child) {
    _definition['child'] = child;
    return this;
  }
  
  ContainerBuilder width(double width) {
    _definition['width'] = width;
    return this;
  }
  
  ContainerBuilder height(double height) {
    _definition['height'] = height;
    return this;
  }
  
  ContainerBuilder color(String color) {
    _definition['color'] = color;
    return this;
  }
  
  ContainerBuilder padding(Map<String, dynamic> padding) {
    _definition['padding'] = padding;
    return this;
  }
  
  ContainerBuilder margin(Map<String, dynamic> margin) {
    _definition['margin'] = margin;
    return this;
  }
  
  ContainerBuilder decoration(Map<String, dynamic> decoration) {
    _definition['decoration'] = decoration;
    return this;
  }
  
  Map<String, dynamic> build() => _definition;
}

class ColumnBuilder {
  final Map<String, dynamic> _definition = {
    'type': 'column',
    'children': [],
  };
  
  ColumnBuilder add(Map<String, dynamic> child) {
    (_definition['children'] as List).add(child);
    return this;
  }
  
  ColumnBuilder addAll(List<Map<String, dynamic>> children) {
    (_definition['children'] as List).addAll(children);
    return this;
  }
  
  ColumnBuilder mainAxisAlignment(String alignment) {
    _definition['mainAxisAlignment'] = alignment;
    return this;
  }
  
  ColumnBuilder crossAxisAlignment(String alignment) {
    _definition['crossAxisAlignment'] = alignment;
    return this;
  }
  
  ColumnBuilder mainAxisSize(String size) {
    _definition['mainAxisSize'] = size;
    return this;
  }
  
  Map<String, dynamic> build() => _definition;
}

class RowBuilder {
  final Map<String, dynamic> _definition = {
    'type': 'row',
    'children': [],
  };
  
  RowBuilder add(Map<String, dynamic> child) {
    (_definition['children'] as List).add(child);
    return this;
  }
  
  RowBuilder addAll(List<Map<String, dynamic>> children) {
    (_definition['children'] as List).addAll(children);
    return this;
  }
  
  RowBuilder mainAxisAlignment(String alignment) {
    _definition['mainAxisAlignment'] = alignment;
    return this;
  }
  
  RowBuilder crossAxisAlignment(String alignment) {
    _definition['crossAxisAlignment'] = alignment;
    return this;
  }
  
  RowBuilder mainAxisSize(String size) {
    _definition['mainAxisSize'] = size;
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
    'type': 'listview',
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
    'type': 'gridview',
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
  static Map<String, dynamic> textButton(String label, Map<String, dynamic> onTap) {
    return MCPUIJsonGenerator.button(
      label: label,
      onTap: onTap,
      style: 'text',
    );
  }
  
  /// Create an elevated button with icon
  static Map<String, dynamic> iconButton({
    required String label,
    required String icon,
    required Map<String, dynamic> onTap,
  }) {
    return MCPUIJsonGenerator.button(
      label: label,
      icon: icon,
      onTap: onTap,
      style: 'elevated',
    );
  }
  
  /// Create a simple form field
  static Map<String, dynamic> formField({
    required String label,
    required String binding,
    String? placeholder,
    String? helperText,
  }) {
    return MCPUIJsonGenerator.textField(
      label: label,
      value: MCPUIJsonGenerator.binding(binding),
      onChange: MCPUIJsonGenerator.stateAction(
        action: 'set',
        binding: binding,
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
    return MCPUIJsonGenerator.column(
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
      child: MCPUIJsonGenerator.column(
        children: [
          {'type': 'circularprogress'},
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
    return MCPUIJsonGenerator.container(
      padding: MCPUIJsonGenerator.edgeInsets(all: 16),
      decoration: MCPUIJsonGenerator.decoration(
        color: '#ffebee',
        borderRadius: 8,
      ),
      child: MCPUIJsonGenerator.row(
        children: [
          MCPUIJsonGenerator.icon(
            icon: 'error',
            color: '#c62828',
          ),
          MCPUIJsonGenerator.sizedBox(width: 8),
          MCPUIJsonGenerator.expanded(
            child: MCPUIJsonGenerator.text(
              message,
              style: MCPUIJsonGenerator.textStyle(color: '#c62828'),
            ),
          ),
        ],
      ),
    );
  }
}