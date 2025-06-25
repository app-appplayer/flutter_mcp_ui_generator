import 'dart:convert';
import 'package:flutter_mcp_ui_core/flutter_mcp_ui_core.dart' as core;

/// MCP UI JSON Generator v1.0
///
/// Generates JSON UI definitions for MCP UI DSL v1.0 specification
/// Compatible with flutter_mcp_ui_runtime
class MCPUIJsonGenerator {
  // ===== Spec-based Widget Creation =====

  /// Create a widget using the spec registry with validation
  static Map<String, dynamic> createWidget(
      String type, Map<String, dynamic> params) {
    // Validate widget type exists
    if (!core.WidgetTypes.allTypes.contains(type)) {
      throw Exception('Unknown widget type: $type');
    }

    final widget = <String, dynamic>{'type': type};
    widget.addAll(params);
    return widget;
  }

  /// Create a validated action using the action spec registry
  static Map<String, dynamic> createAction({
    required String type,
    Map<String, dynamic>? params,
  }) {
    final action = <String, dynamic>{'type': type};
    if (params != null) {
      action.addAll(params);
    }
    return action;
  }

  // ===== Application & Page Builders =====

  /// Create an application definition
  static Map<String, dynamic> application({
    required String title,
    required String version,
    required Map<String, String> routes,
    String initialRoute = '/',
    Map<String, dynamic>? theme,
    Map<String, dynamic>? navigation,
    Map<String, dynamic>? state,
  }) {
    return {
      'type': 'application',
      'title': title,
      'version': version,
      'initialRoute': initialRoute,
      'routes': routes,
      if (theme != null) 'theme': theme,
      if (navigation != null) 'navigation': navigation,
      if (state != null) 'state': state,
    };
  }

  /// Create a page definition
  static Map<String, dynamic> page({
    required String title,
    required Map<String, dynamic> content,
    String? route,
    Map<String, dynamic>? state,
    Map<String, dynamic>? lifecycle,
  }) {
    return {
      'type': 'page',
      'title': title,
      'content': content,
      if (route != null) 'route': route,
      if (state != null) 'state': state,
      if (lifecycle != null) 'lifecycle': lifecycle,
    };
  }

  // ===== Layout Widgets =====

  /// Create a linear layout (MCP UI DSL v1.0)
  /// Supports both vertical and horizontal directions
  static Map<String, dynamic> linear({
    required List<Map<String, dynamic>> children,
    String direction = 'vertical',
    String distribution = 'start',
    String alignment = 'center',
    double? gap,
    bool wrap = false,
  }) {
    return {
      'type': 'linear',
      'children': children,
      'direction': direction,
      'distribution': distribution,
      'alignment': alignment,
      if (gap != null) 'gap': gap,
      'wrap': wrap,
    };
  }

  /// Create a box widget (MCP UI DSL v1.0 alias for container)
  static Map<String, dynamic> box({
    Map<String, dynamic>? child,
    double? width,
    double? height,
    Map<String, dynamic>? padding,
    Map<String, dynamic>? margin,
    Map<String, dynamic>? decoration,
    String? color,
  }) {
    return {
      'type': 'box',
      if (child != null) 'child': child,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (padding != null) 'padding': padding,
      if (margin != null) 'margin': margin,
      if (decoration != null) 'decoration': decoration,
      if (color != null) 'color': color,
    };
  }

  static Map<String, dynamic> stack({
    required List<Map<String, dynamic>> children,
    String alignment = 'topLeft',
    String fit = 'loose',
  }) {
    return {
      'type': 'stack',
      'children': children,
      'alignment': alignment,
      'fit': fit,
    };
  }

  static Map<String, dynamic> center({
    required Map<String, dynamic> child,
  }) {
    return {
      'type': 'center',
      'child': child,
    };
  }

  static Map<String, dynamic> expanded({
    required Map<String, dynamic> child,
    int? flex,
  }) {
    return {
      'type': 'expanded',
      'child': child,
      if (flex != null) 'flex': flex,
    };
  }

  static Map<String, dynamic> padding({
    required Map<String, dynamic> child,
    required Map<String, dynamic> padding,
  }) {
    return {
      'type': 'padding',
      'child': child,
      'padding': padding,
    };
  }

  static Map<String, dynamic> sizedBox({
    Map<String, dynamic>? child,
    double? width,
    double? height,
  }) {
    return {
      'type': 'sizedBox',
      if (child != null) 'child': child,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
    };
  }

  static Map<String, dynamic> conditionalWidget({
    required String condition,
    required Map<String, dynamic> then,
    Map<String, dynamic>? orElse,
  }) {
    return {
      'type': 'conditional',
      'condition': condition,
      'then': then,
      if (orElse != null) 'else': orElse,
    };
  }

  /// Create a scroll-view widget (MCP UI DSL v1.0)
  static Map<String, dynamic> scrollView({
    required Map<String, dynamic> child,
    String scrollDirection = 'vertical',
    bool reverse = false,
    Map<String, dynamic>? padding,
    bool primary = true,
    String? physics,
  }) {
    return {
      'type': 'scrollView',
      'child': child,
      'scrollDirection': scrollDirection,
      'reverse': reverse,
      if (padding != null) 'padding': padding,
      'primary': primary,
      if (physics != null) 'physics': physics,
    };
  }

  /// Create a flexible widget
  static Map<String, dynamic> flexible({
    required Map<String, dynamic> child,
    int flex = 1,
    String fit = 'loose',
  }) {
    return {
      'type': 'flexible',
      'child': child,
      'flex': flex,
      'fit': fit,
    };
  }

  // ===== Display Widgets =====

  static Map<String, dynamic> text(
    String content, {
    Map<String, dynamic>? style,
    String? textAlign,
    int? maxLines,
    String? overflow,
    String? testId,
  }) {
    return {
      'type': 'text',
      'content': content, // MCP UI DSL v1.0 uses 'content'
      if (style != null) 'style': style,
      if (textAlign != null) 'textAlign': textAlign,
      if (maxLines != null) 'maxLines': maxLines,
      if (overflow != null) 'overflow': overflow,
      if (testId != null) 'testId': testId,
    };
  }

  static Map<String, dynamic> image({
    required String src,
    double? width,
    double? height,
    String fit = 'cover',
    String? testId,
  }) {
    return {
      'type': 'image',
      'src': src,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      'fit': fit,
      if (testId != null) 'testId': testId,
    };
  }

  static Map<String, dynamic> icon({
    required String icon,
    double size = 24,
    String? color,
  }) {
    return {
      'type': 'icon',
      'icon': icon,
      'size': size,
      if (color != null) 'color': color,
    };
  }

  static Map<String, dynamic> card({
    required Map<String, dynamic> child,
    double elevation = 2,
    Map<String, dynamic>? margin,
    Map<String, dynamic>? shape,
  }) {
    return {
      'type': 'card',
      'child': child,
      'elevation': elevation,
      if (margin != null) 'margin': margin,
      if (shape != null) 'shape': shape,
    };
  }

  static Map<String, dynamic> divider({
    double thickness = 1,
    String? color,
    double? indent,
    double? endIndent,
  }) {
    return {
      'type': 'divider',
      'thickness': thickness,
      if (color != null) 'color': color,
      if (indent != null) 'indent': indent,
      if (endIndent != null) 'endIndent': endIndent,
    };
  }

  /// Create a loading indicator (MCP UI DSL v1.0)
  static Map<String, dynamic> loadingIndicator({
    double? value,
    String? color,
    double size = 24,
    String indicatorType = 'circular',
    String? message,
  }) {
    return {
      'type': 'loadingIndicator',
      if (value != null) 'value': value,
      if (color != null) 'color': color,
      'size': size,
      'indicatorType': indicatorType,
      if (message != null) 'message': message,
    };
  }

  // ===== Input Widgets =====

  static Map<String, dynamic> button({
    required String label,
    required Map<String, dynamic> click, // MCP UI DSL v1.0
    Map<String, dynamic>? doubleClick,
    Map<String, dynamic>? longPress,
    Map<String, dynamic>? rightClick,
    Map<String, dynamic>? hover,
    Map<String, dynamic>? focus,
    Map<String, dynamic>? blur,
    String style = 'elevated',
    String? icon,
    bool disabled = false,
    bool loading = false,
    String? loadingText,
    String? testId,
  }) {
    return {
      'type': 'button',
      'label': label,
      'click': click,
      if (doubleClick != null) 'doubleClick': doubleClick,
      if (longPress != null) 'longPress': longPress,
      if (rightClick != null) 'rightClick': rightClick,
      if (hover != null) 'hover': hover,
      if (focus != null) 'focus': focus,
      if (blur != null) 'blur': blur,
      'style': style,
      if (icon != null) 'icon': icon,
      'disabled': disabled,
      'loading': loading,
      if (loadingText != null) 'loadingText': loadingText,
      if (testId != null) 'testId': testId,
    };
  }

  /// Create a text-input widget (MCP UI DSL v1.0)
  static Map<String, dynamic> textInput({
    required String label,
    required String value,
    required Map<String, dynamic> change,
    Map<String, dynamic>? submit,
    Map<String, dynamic>? focus,
    Map<String, dynamic>? blur,
    String? placeholder,
    String? helperText,
    String? errorText,
    bool obscureText = false,
    int? maxLines,
    Map<String, dynamic>? validation,
    bool? error,
    String? testId,
  }) {
    return {
      'type': 'textInput',
      'label': label,
      'value': value,
      'change': change,
      if (submit != null) 'submit': submit,
      if (focus != null) 'focus': focus,
      if (blur != null) 'blur': blur,
      if (placeholder != null) 'placeholder': placeholder,
      if (helperText != null) 'helperText': helperText,
      if (errorText != null) 'errorText': errorText,
      'obscureText': obscureText,
      if (maxLines != null) 'maxLines': maxLines,
      if (validation != null) 'validation': validation,
      if (error != null) 'error': error,
      if (testId != null) 'testId': testId,
    };
  }

  static Map<String, dynamic> checkbox({
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL v1.0
    String? label,
  }) {
    return {
      'type': 'checkbox',
      'value': value,
      'change': change,
      if (label != null) 'label': label,
    };
  }

  /// Create a toggle widget (MCP UI DSL v1.0)
  static Map<String, dynamic> toggle({
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL v1.0 uses 'change'
    String? label,
  }) {
    return {
      'type': 'toggle',
      'value': value,
      'change': change,
      if (label != null) 'label': label,
    };
  }

  static Map<String, dynamic> slider({
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL v1.0
    double min = 0,
    double max = 100,
    int? divisions,
    String? label,
  }) {
    return {
      'type': 'slider',
      'value': value,
      'change': change,
      'min': min,
      'max': max,
      if (divisions != null) 'divisions': divisions,
      if (label != null) 'label': label,
    };
  }

  /// Create a select widget (MCP UI DSL v1.0)
  static Map<String, dynamic> select({
    required String value,
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> change, // MCP UI DSL v1.0 uses 'change'
    String? label,
    String? placeholder,
  }) {
    return {
      'type': 'select',
      'value': value,
      'items': items,
      'change': change,
      if (label != null) 'label': label,
      if (placeholder != null) 'placeholder': placeholder,
    };
  }

  static Map<String, dynamic> numberField({
    required String label,
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL v1.0
    double? min,
    double? max,
    double? step,
    String? placeholder,
    String? helperText,
    String? errorText,
    int? decimalPlaces,
    String? format,
    String? prefix,
    String? suffix,
    bool thousandSeparator = false,
    String? testId,
  }) {
    return {
      'type': 'numberField',
      'label': label,
      'value': value,
      'change': change,
      if (min != null) 'min': min,
      if (max != null) 'max': max,
      if (step != null) 'step': step,
      if (placeholder != null) 'placeholder': placeholder,
      if (helperText != null) 'helperText': helperText,
      if (errorText != null) 'errorText': errorText,
      if (decimalPlaces != null) 'decimalPlaces': decimalPlaces,
      if (format != null) 'format': format,
      if (prefix != null) 'prefix': prefix,
      if (suffix != null) 'suffix': suffix,
      'thousandSeparator': thousandSeparator,
      if (testId != null) 'testId': testId,
    };
  }

  static Map<String, dynamic> colorPicker({
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL v1.0
    String? label,
    bool enableAlpha = true,
    bool showAlpha = true,
    bool showLabel = true,
    String pickerType = 'wheel',
    bool enableHistory = false,
    List<String>? swatchColors,
    String? testId,
  }) {
    return {
      'type': 'colorPicker',
      'value': value,
      'change': change,
      if (label != null) 'label': label,
      'enableAlpha': enableAlpha,
      'showAlpha': showAlpha,
      'showLabel': showLabel,
      'pickerType': pickerType,
      'enableHistory': enableHistory,
      if (swatchColors != null) 'swatchColors': swatchColors,
      if (testId != null) 'testId': testId,
    };
  }

  static Map<String, dynamic> radioGroup({
    required String value,
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> change, // MCP UI DSL v1.0
    String? label,
    String orientation = 'vertical',
  }) {
    return {
      'type': 'radioGroup',
      'value': value,
      'items': items,
      'change': change,
      if (label != null) 'label': label,
      'orientation': orientation,
    };
  }

  static Map<String, dynamic> checkboxGroup({
    required String value,
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> change, // MCP UI DSL v1.0
    String? label,
    String orientation = 'vertical',
  }) {
    return {
      'type': 'checkboxGroup',
      'value': value,
      'items': items,
      'change': change,
      if (label != null) 'label': label,
      'orientation': orientation,
    };
  }

  static Map<String, dynamic> segmentedControl({
    required String value,
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> change, // MCP UI DSL v1.0
    String? label,
  }) {
    return {
      'type': 'segmentedControl',
      'value': value,
      'items': items,
      'change': change,
      if (label != null) 'label': label,
    };
  }

  static Map<String, dynamic> dateField({
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL v1.0
    String? label,
    String? minDate,
    String? maxDate,
    String format = 'yyyy-MM-dd',
    String? placeholder,
  }) {
    return {
      'type': 'dateField',
      'value': value,
      'change': change,
      if (label != null) 'label': label,
      if (minDate != null) 'minDate': minDate,
      if (maxDate != null) 'maxDate': maxDate,
      'format': format,
      if (placeholder != null) 'placeholder': placeholder,
    };
  }

  static Map<String, dynamic> timeField({
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL v1.0
    String? label,
    String format = 'HH:mm',
    bool use24HourFormat = true,
    String? placeholder,
  }) {
    return {
      'type': 'timeField',
      'value': value,
      'change': change,
      if (label != null) 'label': label,
      'format': format,
      'use24HourFormat': use24HourFormat,
      if (placeholder != null) 'placeholder': placeholder,
    };
  }

  static Map<String, dynamic> dateRangePicker({
    required String startDate,
    required String endDate,
    required Map<String, dynamic> change, // MCP UI DSL v1.0
    String? label,
    String? minDate,
    String? maxDate,
    String format = 'yyyy-MM-dd',
  }) {
    return {
      'type': 'dateRangePicker',
      'startDate': startDate,
      'endDate': endDate,
      'change': change,
      if (label != null) 'label': label,
      if (minDate != null) 'minDate': minDate,
      if (maxDate != null) 'maxDate': maxDate,
      'format': format,
    };
  }

  static Map<String, dynamic> rangeSlider({
    required String startValue,
    required String endValue,
    required Map<String, dynamic> change, // MCP UI DSL v1.0
    double min = 0,
    double max = 100,
    int? divisions,
    String? label,
  }) {
    return {
      'type': 'rangeSlider',
      'startValue': startValue,
      'endValue': endValue,
      'change': change,
      'min': min,
      'max': max,
      if (divisions != null) 'divisions': divisions,
      if (label != null) 'label': label,
    };
  }

  // ===== Drag & Drop Widgets =====

  static Map<String, dynamic> draggable({
    required Map<String, dynamic> child,
    required Map<String, dynamic> feedback,
    dynamic data,
    Map<String, dynamic>? onDragStarted,
    Map<String, dynamic>? onDragCompleted,
    Map<String, dynamic>? onDragEnd,
    Map<String, dynamic>? childWhenDragging,
    String axis = 'both',
    bool affinity = true,
  }) {
    return {
      'type': 'draggable',
      'child': child,
      'feedback': feedback,
      if (data != null) 'data': data,
      if (onDragStarted != null) 'onDragStarted': onDragStarted,
      if (onDragCompleted != null) 'onDragCompleted': onDragCompleted,
      if (onDragEnd != null) 'onDragEnd': onDragEnd,
      if (childWhenDragging != null) 'childWhenDragging': childWhenDragging,
      'axis': axis,
      'affinity': affinity,
    };
  }

  static Map<String, dynamic> dragTarget({
    required Map<String, dynamic> builder,
    required Map<String, dynamic> onAccept,
    Map<String, dynamic>? onWillAccept,
    Map<String, dynamic>? onLeave,
    Map<String, dynamic>? onMove,
  }) {
    return {
      'type': 'dragTarget',
      'builder': builder,
      'onAccept': onAccept,
      if (onWillAccept != null) 'onWillAccept': onWillAccept,
      if (onLeave != null) 'onLeave': onLeave,
      if (onMove != null) 'onMove': onMove,
    };
  }

  // ===== List Widgets =====

  /// Create a list widget (MCP UI DSL v1.0)
  static Map<String, dynamic> list({
    required String items,
    required Map<String, dynamic>
        itemTemplate, // MCP UI DSL v1.0 uses 'itemTemplate'
    Map<String, dynamic>? itemTap,
    double itemSpacing = 0,
    bool shrinkWrap = false,
    String scrollDirection = 'vertical',
  }) {
    return {
      'type': 'list',
      'items': items,
      'itemTemplate': itemTemplate, // MCP UI DSL v1.0 uses 'itemTemplate'
      if (itemTap != null) 'item-tap': itemTap,
      'itemSpacing': itemSpacing,
      'shrinkWrap': shrinkWrap,
      'scrollDirection': scrollDirection,
    };
  }

  /// Create a grid widget (MCP UI DSL v1.0)
  static Map<String, dynamic> grid({
    required String items,
    required Map<String, dynamic>
        itemTemplate, // MCP UI DSL v1.0 uses 'itemTemplate'
    Map<String, dynamic>? itemTap,
    int crossAxisCount = 2,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    double childAspectRatio = 1.0,
  }) {
    return {
      'type': 'grid',
      'items': items,
      'itemTemplate': itemTemplate, // MCP UI DSL v1.0 uses 'itemTemplate'
      if (itemTap != null) 'item-tap': itemTap,
      'crossAxisCount': crossAxisCount,
      'mainAxisSpacing': mainAxisSpacing,
      'crossAxisSpacing': crossAxisSpacing,
      'childAspectRatio': childAspectRatio,
    };
  }

  static Map<String, dynamic> listTile({
    String? title,
    String? subtitle,
    Map<String, dynamic>? leading,
    Map<String, dynamic>? trailing,
    Map<String, dynamic>? click,
  }) {
    return {
      'type': 'listTile',
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (leading != null) 'leading': leading,
      if (trailing != null) 'trailing': trailing,
      if (click != null) 'click': click,
    };
  }

  // ===== Navigation Widgets =====

  /// Create a header-bar widget (MCP UI DSL v1.0)
  static Map<String, dynamic> headerBar({
    required String title,
    List<Map<String, dynamic>>? actions,
    Map<String, dynamic>? leading,
    double elevation = 4,
  }) {
    return {
      'type': 'headerBar',
      'title': title,
      if (actions != null) 'actions': actions,
      if (leading != null) 'leading': leading,
      'elevation': elevation,
    };
  }

  /// Create a bottom-navigation widget (MCP UI DSL v1.0)
  static Map<String, dynamic> bottomNavigation({
    required List<Map<String, dynamic>> items,
    required int currentIndex,
    required Map<String, dynamic> click,
    String barType = 'fixed',
  }) {
    return {
      'type': 'bottomNavigation',
      'items': items,
      'currentIndex': currentIndex,
      'click': click,
      'barType': barType,
    };
  }

  static Map<String, dynamic> drawer({
    required Map<String, dynamic> child,
  }) {
    return {
      'type': 'drawer',
      'child': child,
    };
  }

  static Map<String, dynamic> floatingActionButton({
    required Map<String, dynamic> click,
    required Map<String, dynamic> child,
    String? tooltip,
  }) {
    return {
      'type': 'floatingActionButton',
      'click': click,
      'child': child,
      if (tooltip != null) 'tooltip': tooltip,
    };
  }

  // ===== Navigation Structure Helpers =====

  /// Create a drawer navigation structure
  static Map<String, dynamic> drawerNavigation({
    required List<Map<String, dynamic>> items,
    Map<String, dynamic>? header,
    Map<String, dynamic>? footer,
  }) {
    return {
      'type': 'drawer',
      'items': items,
      if (header != null) 'header': header,
      if (footer != null) 'footer': footer,
    };
  }

  /// Create a tabs navigation structure
  static Map<String, dynamic> tabsNavigation({
    required List<Map<String, dynamic>> tabs,
    int initialIndex = 0,
    String? tabBarPosition,
  }) {
    return {
      'type': 'tabs',
      'tabs': tabs,
      'initialIndex': initialIndex,
      if (tabBarPosition != null) 'tabBarPosition': tabBarPosition,
    };
  }

  /// Create a tab item for tabs navigation
  static Map<String, dynamic> tabItem({
    required String label,
    required Map<String, dynamic> content,
    String? icon,
  }) {
    return {
      'label': label,
      'content': content,
      if (icon != null) 'icon': icon,
    };
  }

  /// Create a navigation item
  static Map<String, dynamic> navigationItem({
    required String label,
    required String route,
    String? icon,
    List<Map<String, dynamic>>? children,
  }) {
    return {
      'label': label,
      'route': route,
      if (icon != null) 'icon': icon,
      if (children != null) 'children': children,
    };
  }

  // ===== Advanced Widgets =====

  /// Create a chart widget
  static Map<String, dynamic> chart({
    required String chartType,
    required List<Map<String, dynamic>> data,
    String? title,
    double? width,
    double? height,
    Map<String, dynamic>? options,
  }) {
    return {
      'type': 'chart',
      'chartType': chartType,
      'data': data,
      if (title != null) 'title': title,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (options != null) 'options': options,
    };
  }

  /// Create a map widget
  static Map<String, dynamic> map({
    required double latitude,
    required double longitude,
    double zoom = 10,
    List<Map<String, dynamic>>? markers,
    bool interactive = true,
    double? width,
    double? height,
  }) {
    return {
      'type': 'map',
      'latitude': latitude,
      'longitude': longitude,
      'zoom': zoom,
      if (markers != null) 'markers': markers,
      'interactive': interactive,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
    };
  }

  /// Create a media player widget
  static Map<String, dynamic> mediaPlayer({
    required String source,
    String mediaType = 'video',
    bool autoplay = false,
    bool controls = true,
    bool loop = false,
    double? width,
    double? height,
  }) {
    return {
      'type': 'mediaPlayer',
      'source': source,
      'mediaType': mediaType,
      'autoplay': autoplay,
      'controls': controls,
      'loop': loop,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
    };
  }

  /// Create a calendar widget
  static Map<String, dynamic> calendar({
    String view = 'month',
    String? selectedDate,
    List<Map<String, dynamic>>? events,
    bool showHeader = true,
    double? width,
    double? height,
  }) {
    return {
      'type': 'calendar',
      'view': view,
      if (selectedDate != null) 'selectedDate': selectedDate,
      if (events != null) 'events': events,
      'showHeader': showHeader,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
    };
  }

  /// Create a tree widget
  static Map<String, dynamic> tree({
    required List<Map<String, dynamic>> data,
    bool expandAll = false,
    bool showLines = true,
    double? width,
    double? height,
  }) {
    return {
      'type': 'tree',
      'data': data,
      'expandAll': expandAll,
      'showLines': showLines,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
    };
  }

  // ===== Action Builders =====

  /// Create a tool action (MCP UI DSL v1.0 spec)
  static Map<String, dynamic> toolAction(
    String name, {
    Map<String, dynamic>? params,
  }) {
    return {
      'type': 'tool',
      'name': name, // Changed from 'tool' to 'name' per spec
      if (params != null)
        'params': params, // Changed from 'args' to 'params' per spec
    };
  }

  /// Create a state action (MCP UI DSL v1.0 spec)
  static Map<String, dynamic> stateAction({
    required String action,
    required String binding, // MCP UI DSL v1.0 uses 'binding' for state actions
    dynamic value,
    num? amount,
  }) {
    return {
      'type': 'state',
      'action': action,
      'binding': binding, // MCP UI DSL v1.0 uses 'binding' for state actions
      if (value != null) 'value': value,
      if (amount != null) 'amount': amount, // Added amount parameter per spec
    };
  }

  /// Create a navigation action (MCP UI DSL v1.0 spec)
  static Map<String, dynamic> navigationAction({
    required String action,
    String? route,
    Map<String, dynamic>? params,
    String? index, // Added index parameter for setIndex action
  }) {
    return {
      'type': 'navigation',
      'action': action,
      if (route != null) 'route': route,
      if (params != null) 'params': params,
      if (index != null) 'index': index, // Added index parameter per spec
    };
  }

  /// Create a resource action (MCP UI DSL v1.0 spec)
  static Map<String, dynamic> resourceAction({
    required String action,
    String? uri,
    String? pattern,
    String? target, // Changed from 'binding' to 'target' per spec
  }) {
    return {
      'type': 'resource',
      'action': action,
      if (uri != null) 'uri': uri,
      if (pattern != null)
        'pattern': pattern, // Added pattern parameter per spec
      if (target != null)
        'target': target, // Changed from 'binding' to 'target' per spec
    };
  }

  /// Create a batch action (MCP UI DSL v1.0 spec)
  static Map<String, dynamic> batchAction({
    required List<Map<String, dynamic>> actions,
    bool parallel = false, // Added parallel parameter per spec
  }) {
    return {
      'type': 'batch',
      'actions': actions,
      'parallel': parallel, // Added parallel parameter per spec
    };
  }

  /// Create a conditional action (MCP UI DSL v1.0 spec)
  static Map<String, dynamic> conditionalAction({
    required String condition,
    required Map<String, dynamic> then,
    Map<String, dynamic>? orElse,
  }) {
    return {
      'type': 'conditional',
      'condition': condition,
      'then': then,
      if (orElse != null) 'else': orElse, // 'else' is correct per spec
    };
  }

  // ===== Theme Builders =====

  /// Create a complete theme definition
  static Map<String, dynamic> theme({
    String mode = 'light',
    Map<String, dynamic>? colors,
    Map<String, dynamic>? typography,
    Map<String, dynamic>? spacing,
    Map<String, dynamic>? borderRadius,
    Map<String, dynamic>? elevation,
    Map<String, dynamic>? light,
    Map<String, dynamic>? dark,
  }) {
    final theme = <String, dynamic>{
      'mode': mode,
    };

    // Add theme sections
    if (colors != null) theme['colors'] = colors;
    if (typography != null) theme['typography'] = typography;
    if (spacing != null) theme['spacing'] = spacing;
    if (borderRadius != null) theme['borderRadius'] = borderRadius;
    if (elevation != null) theme['elevation'] = elevation;

    // Add light/dark mode themes
    if (light != null) theme['light'] = light;
    if (dark != null) theme['dark'] = dark;

    return theme;
  }

  /// Create theme colors (MCP UI DSL v1.0)
  static Map<String, dynamic> themeColors({
    String primary = '#FF2196F3',
    String secondary = '#FFFF4081',
    String background = '#FFFFFFFF',
    String surface = '#FFF5F5F5',
    String error = '#FFF44336',
    String textOnPrimary = '#FFFFFFFF',
    String textOnSecondary = '#FF000000',
    String textOnBackground = '#FF000000',
    String textOnSurface = '#FF000000',
    String textOnError = '#FFFFFFFF',
  }) {
    return {
      'primary': primary,
      'secondary': secondary,
      'background': background,
      'surface': surface,
      'error': error,
      'textOnPrimary': textOnPrimary,
      'textOnSecondary': textOnSecondary,
      'textOnBackground': textOnBackground,
      'textOnSurface': textOnSurface,
      'textOnError': textOnError,
    };
  }

  /// Create theme typography
  static Map<String, dynamic> themeTypography({
    Map<String, dynamic>? h1,
    Map<String, dynamic>? h2,
    Map<String, dynamic>? h3,
    Map<String, dynamic>? h4,
    Map<String, dynamic>? h5,
    Map<String, dynamic>? h6,
    Map<String, dynamic>? body1,
    Map<String, dynamic>? body2,
    Map<String, dynamic>? caption,
    Map<String, dynamic>? button,
  }) {
    return {
      'h1': h1 ?? {'fontSize': 32, 'fontWeight': 'bold', 'letterSpacing': -1.5},
      'h2': h2 ?? {'fontSize': 28, 'fontWeight': 'bold', 'letterSpacing': -0.5},
      'h3': h3 ?? {'fontSize': 24, 'fontWeight': 'bold', 'letterSpacing': 0},
      'h4': h4 ?? {'fontSize': 20, 'fontWeight': 'bold', 'letterSpacing': 0.25},
      'h5': h5 ?? {'fontSize': 18, 'fontWeight': 'bold', 'letterSpacing': 0},
      'h6': h6 ?? {'fontSize': 16, 'fontWeight': 'bold', 'letterSpacing': 0.15},
      'body1': body1 ??
          {'fontSize': 16, 'fontWeight': 'normal', 'letterSpacing': 0.5},
      'body2': body2 ??
          {'fontSize': 14, 'fontWeight': 'normal', 'letterSpacing': 0.25},
      'caption': caption ??
          {'fontSize': 12, 'fontWeight': 'normal', 'letterSpacing': 0.4},
      'button': button ??
          {
            'fontSize': 14,
            'fontWeight': 'medium',
            'letterSpacing': 1.25,
            'textTransform': 'uppercase'
          },
    };
  }

  /// Create theme spacing
  static Map<String, dynamic> themeSpacing({
    int xs = 4,
    int sm = 8,
    int md = 16,
    int lg = 24,
    int xl = 32,
    int xxl = 48,
  }) {
    return {
      'xs': xs,
      'sm': sm,
      'md': md,
      'lg': lg,
      'xl': xl,
      'xxl': xxl,
    };
  }

  /// Create theme border radius
  static Map<String, dynamic> themeBorderRadius({
    int sm = 4,
    int md = 8,
    int lg = 16,
    int xl = 24,
    int round = 9999,
  }) {
    return {
      'sm': sm,
      'md': md,
      'lg': lg,
      'xl': xl,
      'round': round,
    };
  }

  /// Create theme elevation
  static Map<String, dynamic> themeElevation({
    int none = 0,
    int sm = 2,
    int md = 4,
    int lg = 8,
    int xl = 16,
  }) {
    return {
      'none': none,
      'sm': sm,
      'md': md,
      'lg': lg,
      'xl': xl,
    };
  }

  // ===== Style Builders =====

  static Map<String, dynamic> textStyle({
    double? fontSize,
    String? fontWeight,
    String? fontStyle,
    String? color,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    String? decoration,
  }) {
    return {
      if (fontSize != null) 'fontSize': fontSize,
      if (fontWeight != null) 'fontWeight': fontWeight,
      if (fontStyle != null) 'fontStyle': fontStyle,
      if (color != null) 'color': color,
      if (letterSpacing != null) 'letterSpacing': letterSpacing,
      if (wordSpacing != null) 'wordSpacing': wordSpacing,
      if (height != null) 'height': height,
      if (decoration != null) 'decoration': decoration,
    };
  }

  static Map<String, dynamic> edgeInsets({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    if (all != null) {
      return {'all': all};
    }

    final insets = <String, dynamic>{};
    if (horizontal != null) insets['horizontal'] = horizontal;
    if (vertical != null) insets['vertical'] = vertical;
    if (left != null) insets['left'] = left;
    if (top != null) insets['top'] = top;
    if (right != null) insets['right'] = right;
    if (bottom != null) insets['bottom'] = bottom;

    return insets;
  }

  static Map<String, dynamic> decoration({
    String? color,
    double? borderRadius,
    Map<String, dynamic>? border,
    List<Map<String, dynamic>>? boxShadow,
    Map<String, dynamic>? gradient,
  }) {
    return {
      if (color != null) 'color': color,
      if (borderRadius != null) 'borderRadius': borderRadius,
      if (border != null) 'border': border,
      if (boxShadow != null) 'boxShadow': boxShadow,
      if (gradient != null) 'gradient': gradient,
    };
  }

  static Map<String, dynamic> border({
    String? color,
    double width = 1,
    String style = 'solid',
  }) {
    return {
      if (color != null) 'color': color,
      'width': width,
      'style': style,
    };
  }

  // ===== Helper Methods =====

  /// Convert definition to pretty JSON string
  static String toPrettyJson(Map<String, dynamic> definition) {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(definition);
  }

  /// Create binding expression
  static String binding(String path) => '{{$path}}';

  /// Create local state binding
  static String localState(String path) => '{{local.$path}}';

  /// Create app state binding
  static String appState(String path) => '{{app.$path}}';

  /// Create theme binding expression
  static String themeBinding(String path) => '{{theme.$path}}';

  /// Create conditional expression
  static String conditional(String condition, String ifTrue, String ifFalse) {
    return '{{$condition ? $ifTrue : $ifFalse}}';
  }

  /// Create a computed property binding
  static String computed(String expression) => '{{$expression}}';

  /// Create a route state binding
  static String routeState(String path) => '{{route.$path}}';

  /// Create a user preference binding
  static String preference(String key) => '{{preferences.$key}}';

  // ===== Theme Binding Helpers =====

  /// Get theme color binding
  static String themeColor(String colorName) =>
      themeBinding('colors.$colorName');

  /// Get theme typography binding
  static String themeTypographyProperty(String style, String property) =>
      themeBinding('typography.$style.$property');

  /// Get theme spacing binding
  static String themeSpacingValue(String size) => themeBinding('spacing.$size');

  /// Get theme border radius binding
  static String themeBorderRadiusValue(String size) =>
      themeBinding('borderRadius.$size');

  /// Get theme elevation binding
  static String themeElevationValue(String level) =>
      themeBinding('elevation.$level');

  // ===== Size Unit Helpers =====

  /// Create a percentage size
  static String percent(double value) => '$value%';

  /// Create a viewport width size
  static String vw(double value) => '${value}vw';

  /// Create a viewport height size
  static String vh(double value) => '${value}vh';

  /// Create a size with unit
  static dynamic size(double value, {String? unit}) {
    if (unit == null) return value;
    switch (unit) {
      case '%':
        return percent(value);
      case 'vw':
        return vw(value);
      case 'vh':
        return vh(value);
      default:
        return value;
    }
  }

  // ===== Event Helpers =====

  /// Create an event value binding
  static String eventValue() => '{{event.value}}';

  /// Create an event index binding
  static String eventIndex() => '{{event.index}}';

  /// Create an event checked binding
  static String eventChecked() => '{{event.checked}}';

  /// Create an event data binding
  static String eventData(String field) => '{{event.$field}}';

  // ===== Route Helpers =====

  /// Create a route definition with parameters
  static Map<String, dynamic> route({
    required String path,
    required Map<String, dynamic> page,
    List<String>? params,
    Map<String, dynamic>? guards,
  }) {
    return {
      'path': path,
      'page': page,
      if (params != null) 'params': params,
      if (guards != null) 'guards': guards,
    };
  }

  /// Create a route parameter binding expression
  static String routeParam(String paramName) {
    return '{{route.params.$paramName}}';
  }

  /// Create a route query parameter binding expression
  static String routeQuery(String queryName) {
    return '{{route.query.$queryName}}';
  }

  // ===== Lifecycle Helpers =====

  /// Create lifecycle hooks for a page
  static Map<String, dynamic> lifecycle({
    List<Map<String, dynamic>>? onInit,
    List<Map<String, dynamic>>? onDestroy,
    List<Map<String, dynamic>>? onResume,
    List<Map<String, dynamic>>? onPause,
  }) {
    return {
      if (onInit != null) 'onInit': onInit,
      if (onDestroy != null) 'onDestroy': onDestroy,
      if (onResume != null) 'onResume': onResume,
      if (onPause != null) 'onPause': onPause,
    };
  }

  /// Create an onInit lifecycle hook
  static Map<String, dynamic> onInit(List<Map<String, dynamic>> actions) {
    return {'onInit': actions};
  }

  /// Create an onDestroy lifecycle hook
  static Map<String, dynamic> onDestroy(List<Map<String, dynamic>> actions) {
    return {'onDestroy': actions};
  }

  /// Create an onResume lifecycle hook
  static Map<String, dynamic> onResume(List<Map<String, dynamic>> actions) {
    return {'onResume': actions};
  }

  /// Create an onPause lifecycle hook
  static Map<String, dynamic> onPause(List<Map<String, dynamic>> actions) {
    return {'onPause': actions};
  }

  // ===== Accessibility Helpers =====

  /// Add accessibility properties to a widget
  static Map<String, dynamic> withAccessibility(
    Map<String, dynamic> widget, {
    String? ariaLabel,
    String? ariaRole,
    String? ariaDescription,
    bool? ariaHidden,
    String? ariaLive,
  }) {
    final updatedWidget = Map<String, dynamic>.from(widget);

    if (ariaLabel != null) updatedWidget['aria-label'] = ariaLabel;
    if (ariaRole != null) updatedWidget['aria-role'] = ariaRole;
    if (ariaDescription != null) {
      updatedWidget['aria-description'] = ariaDescription;
    }
    if (ariaHidden != null) updatedWidget['aria-hidden'] = ariaHidden;
    if (ariaLive != null) updatedWidget['aria-live'] = ariaLive;

    return updatedWidget;
  }

  /// Create an accessible button
  static Map<String, dynamic> accessibleButton({
    required String label,
    required Map<String, dynamic> click,
    String? ariaLabel,
    String? ariaRole = 'button',
    String style = 'elevated',
    String? icon,
    bool disabled = false,
  }) {
    return withAccessibility(
      button(
        label: label,
        click: click,
        style: style,
        icon: icon,
        disabled: disabled,
      ),
      ariaLabel: ariaLabel ?? label,
      ariaRole: ariaRole,
    );
  }

  /// Create an accessible text input
  static Map<String, dynamic> accessibleTextInput({
    required String label,
    required String value,
    required Map<String, dynamic> change,
    String? ariaLabel,
    String? ariaRole = 'textbox',
    String? ariaDescription,
    String? placeholder,
    String? helperText,
    String? errorText,
    bool obscureText = false,
    int? maxLines,
  }) {
    return withAccessibility(
      textInput(
        label: label,
        value: value,
        change: change,
        placeholder: placeholder,
        helperText: helperText,
        errorText: errorText,
        obscureText: obscureText,
        maxLines: maxLines,
      ),
      ariaLabel: ariaLabel ?? label,
      ariaRole: ariaRole,
      ariaDescription: ariaDescription ?? helperText,
    );
  }

  // ===== Validation Helpers =====

  /// Create validation rules
  static Map<String, dynamic> validation({
    bool? required,
    int? minLength,
    int? maxLength,
    String? pattern,
    String? message,
    double? min,
    double? max,
    String? email,
    String? url,
    List<String>? oneOf,
  }) {
    final rules = <String, dynamic>{};

    if (required != null) rules['required'] = required;
    if (minLength != null) rules['minLength'] = minLength;
    if (maxLength != null) rules['maxLength'] = maxLength;
    if (pattern != null) rules['pattern'] = pattern;
    if (message != null) rules['message'] = message;
    if (min != null) rules['min'] = min;
    if (max != null) rules['max'] = max;
    if (email != null) rules['email'] = email;
    if (url != null) rules['url'] = url;
    if (oneOf != null) rules['oneOf'] = oneOf;

    return rules;
  }

  /// Create a required field validation
  static Map<String, dynamic> requiredValidation({String? message}) {
    return validation(
      required: true,
      message: message ?? 'This field is required',
    );
  }

  /// Create an email validation
  static Map<String, dynamic> emailValidation({String? message}) {
    return validation(
      email: 'true',
      message: message ?? 'Please enter a valid email',
    );
  }

  // ===== I18n Helpers =====

  /// Create an i18n string reference
  static String i18n(String key, {Map<String, String>? args}) {
    if (args == null || args.isEmpty) {
      return 'i18n:$key';
    }

    // Format: i18n:key:arg1=value1,arg2=value2
    final argString = args.entries.map((e) => '${e.key}=${e.value}').join(',');
    return 'i18n:$key:$argString';
  }

  /// Create an i18n configuration
  static Map<String, dynamic> i18nConfig({
    required List<String> locales,
    required String defaultLocale,
    required Map<String, Map<String, String>> translations,
  }) {
    return {
      'locales': locales,
      'defaultLocale': defaultLocale,
      'translations': translations,
    };
  }

  /// Create translations for a locale
  static Map<String, String> i18nTranslations(
      Map<String, String> translations) {
    return translations;
  }

  /// Create a text widget with i18n support
  static Map<String, dynamic> i18nText(
    String key, {
    Map<String, String>? args,
    Map<String, dynamic>? style,
    String? textAlign,
    int? maxLines,
    String? overflow,
  }) {
    return text(
      i18n(key, args: args),
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Create a button with i18n label
  static Map<String, dynamic> i18nButton({
    required String labelKey,
    Map<String, String>? labelArgs,
    required Map<String, dynamic> click,
    String style = 'elevated',
    String? icon,
    bool disabled = false,
  }) {
    return button(
      label: i18n(labelKey, args: labelArgs),
      click: click,
      style: style,
      icon: icon,
      disabled: disabled,
    );
  }

  // ===== Core Model Converters =====

  /// Convert application JSON to ApplicationConfig
  static core.ApplicationConfig applicationConfig({
    required String title,
    required String version,
    required Map<String, dynamic> routes,
    String initialRoute = '/',
    Map<String, dynamic>? theme,
    Map<String, dynamic>? navigation,
    Map<String, dynamic>? state,
  }) {
    return core.ApplicationConfig(
      title: title,
      version: version,
      routes: routes,
      initialRoute: initialRoute,
      theme: theme,
      navigation: navigation,
      state: state,
    );
  }

  /// Convert page JSON to PageConfig
  static core.PageConfig pageConfig({
    required String title,
    required Map<String, dynamic> content,
    String? route,
    Map<String, dynamic>? state,
    Map<String, dynamic>? lifecycle,
    Map<String, dynamic>? themeOverride,
  }) {
    return core.PageConfig(
      title: title,
      content: content,
      route: route,
      state: state,
      lifecycle: lifecycle,
      themeOverride: themeOverride,
    );
  }

  /// Create ThemeConfig
  static core.ThemeConfig themeConfig({
    String mode = 'light',
    Map<String, dynamic>? colors,
    Map<String, dynamic>? typography,
    Map<String, dynamic>? spacing,
    Map<String, dynamic>? borderRadius,
    Map<String, dynamic>? elevation,
    Map<String, dynamic>? light,
    Map<String, dynamic>? dark,
  }) {
    return core.ThemeConfig(
      mode: mode,
      colors: colors,
      typography: typography,
      spacing: spacing,
      borderRadius: borderRadius,
      elevation: elevation,
      light: light,
      dark: dark,
    );
  }
}
