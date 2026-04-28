import 'dart:convert';
import 'package:flutter_mcp_ui_core/flutter_mcp_ui_core.dart' as core;

/// MCP UI JSON Generator v1.0
///
/// Generates JSON UI definitions for MCP UI DSL v1.0 specification
/// Compatible with flutter_mcp_ui_runtime
class MCPUIJsonGenerator {
  // ===== MCP UI DSL v1.0 Dimension Helpers =====
  
  /// Create a dimension value in MCP UI DSL v1.0 format
  /// Format: {"value": 100, "unit": "px"}
  static Map<String, dynamic> dimension(double value, [String unit = 'px']) {
    return {
      'value': value,
      'unit': unit,
    };
  }
  
  /// Helper to convert direct number to dimension format if needed
  /// Returns either the direct number or the MCP UI DSL v1.0 format
  /// Set useMCPFormat to true to always use MCP UI DSL v1.0 format
  static dynamic toDimension(double? value, {bool useMCPFormat = false, String unit = 'px'}) {
    if (value == null) return null;
    return useMCPFormat ? dimension(value, unit) : value;
  }

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
    Map<String, dynamic>? dashboard,
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
      if (dashboard != null) 'dashboard': dashboard,
    };
  }

  /// Create a dashboard configuration (v1.3)
  static Map<String, dynamic> dashboard({
    required Map<String, dynamic> content,
    int? refreshInterval,
    Map<String, dynamic>? onTap,
  }) {
    return {
      'content': content,
      if (refreshInterval != null) 'refreshInterval': refreshInterval,
      if (onTap != null) 'onTap': onTap,
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
    String alignment = 'start',
    double? spacing,
    @Deprecated('Use spacing instead') double? gap,
    bool wrap = false,
  }) {
    return {
      'type': 'linear',
      'children': children,
      'direction': direction,
      'distribution': distribution,
      'alignment': alignment,
      if (spacing != null) 'spacing': spacing
      else if (gap != null) 'spacing': gap,
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

  /// Create a mediaQuery conditional renderer (MCP UI DSL v1.1)
  ///
  /// Renders different widget subtrees based on media query conditions.
  /// Condition examples: "minWidth: 600", "orientation: landscape", "platform: desktop"
  static Map<String, dynamic> mediaQuery({
    required String condition,
    required Map<String, dynamic> then,
    Map<String, dynamic>? orElse,
  }) {
    return {
      'type': 'mediaQuery',
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
      'content': content, // MCP UI DSL callback uses 'content'
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
    String fit = 'contain',
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

  /// Create a progressBar (canonical per spec 17_Naming §17.2.1).
  static Map<String, dynamic> progressBar({
    double? value,
    String? color,
    double size = 24,
    String indicatorType = 'circular',
    String? message,
  }) {
    return {
      'type': 'progressBar',
      if (value != null) 'value': value,
      if (color != null) 'color': color,
      'size': size,
      'indicatorType': indicatorType,
      if (message != null) 'message': message,
    };
  }

  /// Alias for progressBar (legacy name per spec §17.3.1). Emits the canonical
  /// `'type': 'progressBar'` to comply with §17.5.2 canonical emission.
  static Map<String, dynamic> loadingIndicator({
    double? value,
    String? color,
    double size = 24,
    String indicatorType = 'circular',
    String? message,
  }) {
    return progressBar(
      value: value,
      color: color,
      size: size,
      indicatorType: indicatorType,
      message: message,
    );
  }

  // ===== Input Widgets =====

  static Map<String, dynamic> button({
    required String label,
    required Map<String, dynamic> click, // MCP UI DSL callback
    Map<String, dynamic>? doubleClick,
    Map<String, dynamic>? longPress,
    Map<String, dynamic>? rightClick,
    Map<String, dynamic>? hover,
    Map<String, dynamic>? focus,
    Map<String, dynamic>? blur,
    String variant = 'elevated',
    String? icon,
    bool disabled = false,
    bool loading = false,
    String? loadingText,
    String? testId,
  }) {
    return {
      'type': 'button',
      'label': label,
      'onTap': click,
      if (doubleClick != null) 'onDoubleTap': doubleClick,
      if (longPress != null) 'onLongPress': longPress,
      if (rightClick != null) 'onRightClick': rightClick,
      if (hover != null) 'onHover': hover,
      if (focus != null) 'onFocus': focus,
      if (blur != null) 'onBlur': blur,
      'variant': variant,
      if (icon != null) 'icon': icon,
      'disabled': disabled,
      'loading': loading,
      if (loadingText != null) 'loadingText': loadingText,
      if (testId != null) 'testId': testId,
    };
  }

  /// Create a text-input widget (MCP UI DSL v1.0)
  /// Canonical text input widget per spec §2.6.3.
  ///
  /// Either [value]+[change] OR [binding] MUST be provided. [binding] declares
  /// a two-way state path; [value]+[change] gives explicit control. When both
  /// are present, [value]/[change] take precedence (spec §2.6.3).
  ///
  /// [validation] accepts both shapes defined in spec §7.2.1:
  /// * `Map<String, dynamic>` — constraint object `{kind, sanitize, maxLength, pattern, message}`
  /// * `List<Map<String, dynamic>>` — rule array `[{rule, value, message}, ...]`
  static Map<String, dynamic> textInput({
    String? label,
    String? value,
    Map<String, dynamic>? change,
    String? binding,
    Map<String, dynamic>? submit,
    Map<String, dynamic>? focus,
    Map<String, dynamic>? blur,
    String? placeholder,
    String? helperText,
    String? errorText,
    bool obscureText = false,
    int? maxLines,
    String? inputType,
    Object? validation,
    bool? error,
    String? testId,
  }) {
    assert(
      (value != null && change != null) || binding != null,
      'textInput requires either (value + change) or binding (spec §2.6.3).',
    );
    assert(
      validation == null ||
          validation is Map<String, dynamic> ||
          validation is List,
      'textInput validation must be a Map (Shape A) or List (Shape B) per spec §7.2.1.',
    );
    return {
      'type': 'textInput',
      if (label != null) 'label': label,
      if (value != null) 'value': value,
      if (change != null) 'onChange': change,
      if (binding != null) 'binding': binding,
      if (submit != null) 'onSubmit': submit,
      if (focus != null) 'onFocus': focus,
      if (blur != null) 'onBlur': blur,
      if (placeholder != null) 'placeholder': placeholder,
      if (helperText != null) 'helperText': helperText,
      if (errorText != null) 'errorText': errorText,
      'obscureText': obscureText,
      if (maxLines != null) 'maxLines': maxLines,
      if (inputType != null) 'inputType': inputType,
      if (validation != null) 'validation': validation,
      if (error != null) 'error': error,
      if (testId != null) 'testId': testId,
    };
  }

  /// Legacy alias — emits canonical `textInput` per spec §17.3.1, §17.5.2.
  ///
  /// Deprecated in favor of [textInput]. Form-aware behavior is folded into
  /// `textInput` via [binding] and [validation].
  @Deprecated('Use textInput(); textFormField is a legacy alias per spec §17.3.1.')
  static Map<String, dynamic> textFormField({
    String? label,
    String? binding,
    String? value,
    Map<String, dynamic>? change,
    String? placeholder,
    String? helperText,
    String? errorText,
    bool obscureText = false,
    int? maxLines,
    String? inputType,
    Object? validation,
    String? testId,
  }) {
    return textInput(
      label: label,
      binding: binding,
      value: value,
      change: change,
      placeholder: placeholder,
      helperText: helperText,
      errorText: errorText,
      obscureText: obscureText,
      maxLines: maxLines,
      inputType: inputType,
      validation: validation,
      testId: testId,
    );
  }

  static Map<String, dynamic> checkbox({
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL callback
    String? label,
  }) {
    return {
      'type': 'checkbox',
      'value': value,
      'onChange': change,
      if (label != null) 'label': label,
    };
  }

  /// Create a toggle widget (MCP UI DSL v1.0)
  static Map<String, dynamic> toggle({
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL callback
    String? label,
  }) {
    return {
      'type': 'toggle',
      'value': value,
      'onChange': change,
      if (label != null) 'label': label,
    };
  }

  static Map<String, dynamic> slider({
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL callback
    double min = 0,
    double max = 100,
    int? divisions,
    String? label,
  }) {
    return {
      'type': 'slider',
      'value': value,
      'onChange': change,
      'min': min,
      'max': max,
      if (divisions != null) 'divisions': divisions,
      if (label != null) 'label': label,
    };
  }

  /// Create a select widget (MCP UI DSL v1.0)
  static Map<String, dynamic> select({
    required String value,
    required List<Map<String, dynamic>> options,
    required Map<String, dynamic> change,
    String? label,
    String? placeholder,
  }) {
    return {
      'type': 'select',
      'value': value,
      'options': options,
      'onChange': change,
      if (label != null) 'label': label,
      if (placeholder != null) 'placeholder': placeholder,
    };
  }

  static Map<String, dynamic> numberField({
    required String label,
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL callback
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
      'onChange': change,
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
    required Map<String, dynamic> change,
    String? label,
    bool enableAlpha = true,
    bool showAlpha = true,
    bool showLabel = true,
    String pickerType = 'wheel',
    bool enableHistory = false,
    List<String>? swatches,
    String? testId,
  }) {
    return {
      'type': 'colorPicker',
      'value': value,
      'onChange': change,
      if (label != null) 'label': label,
      'enableAlpha': enableAlpha,
      'showAlpha': showAlpha,
      'showLabel': showLabel,
      'pickerType': pickerType,
      'enableHistory': enableHistory,
      if (swatches != null) 'swatches': swatches,
      if (testId != null) 'testId': testId,
    };
  }

  static Map<String, dynamic> radioGroup({
    required String value,
    required List<Map<String, dynamic>> options,
    required Map<String, dynamic> change, // MCP UI DSL callback
    String? label,
    String orientation = 'vertical',
  }) {
    return {
      'type': 'radioGroup',
      'value': value,
      'options': options,
      'onChange': change,
      if (label != null) 'label': label,
      'orientation': orientation,
    };
  }

  static Map<String, dynamic> checkboxGroup({
    required String value,
    required List<Map<String, dynamic>> options,
    required Map<String, dynamic> change, // MCP UI DSL callback
    String? label,
    String orientation = 'vertical',
  }) {
    return {
      'type': 'checkboxGroup',
      'value': value,
      'options': options,
      'onChange': change,
      if (label != null) 'label': label,
      'orientation': orientation,
    };
  }

  static Map<String, dynamic> segmentedControl({
    required String value,
    required List<Map<String, dynamic>> options,
    required Map<String, dynamic> change, // MCP UI DSL callback
    String? label,
  }) {
    return {
      'type': 'segmentedControl',
      'value': value,
      'options': options,
      'onChange': change,
      if (label != null) 'label': label,
    };
  }

  static Map<String, dynamic> dateField({
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL callback
    String? label,
    String? minDate,
    String? maxDate,
    String format = 'yyyy-MM-dd',
    String? placeholder,
  }) {
    return {
      'type': 'dateField',
      'value': value,
      'onChange': change,
      if (label != null) 'label': label,
      if (minDate != null) 'minDate': minDate,
      if (maxDate != null) 'maxDate': maxDate,
      'format': format,
      if (placeholder != null) 'placeholder': placeholder,
    };
  }

  static Map<String, dynamic> timeField({
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL callback
    String? label,
    String format = 'HH:mm',
    bool use24HourFormat = true,
    String? placeholder,
  }) {
    return {
      'type': 'timeField',
      'value': value,
      'onChange': change,
      if (label != null) 'label': label,
      'format': format,
      'use24HourFormat': use24HourFormat,
      if (placeholder != null) 'placeholder': placeholder,
    };
  }

  static Map<String, dynamic> dateRangePicker({
    required String startDate,
    required String endDate,
    required Map<String, dynamic> change, // MCP UI DSL callback
    String? label,
    String? minDate,
    String? maxDate,
    String format = 'yyyy-MM-dd',
  }) {
    return {
      'type': 'dateRangePicker',
      'startDate': startDate,
      'endDate': endDate,
      'onChange': change,
      if (label != null) 'label': label,
      if (minDate != null) 'minDate': minDate,
      if (maxDate != null) 'maxDate': maxDate,
      'format': format,
    };
  }

  static Map<String, dynamic> rangeSlider({
    required String value,
    required Map<String, dynamic> change, // MCP UI DSL callback
    double min = 0,
    double max = 100,
    int? divisions,
    String? label,
  }) {
    return {
      'type': 'rangeSlider',
      'value': value,
      'onChange': change,
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
    required Map<String, dynamic> drop,
    String? canDrop,
    Map<String, dynamic>? dragEnter,
    Map<String, dynamic>? dragLeave,
  }) {
    return {
      'type': 'dragTarget',
      'builder': builder,
      'onDrop': drop,
      if (canDrop != null) 'canDrop': canDrop,
      if (dragEnter != null) 'onDragEnter': dragEnter,
      if (dragLeave != null) 'onDragLeave': dragLeave,
    };
  }

  // ===== List Widgets =====

  /// Create a list widget (MCP UI DSL v1.0)
  static Map<String, dynamic> list({
    required String items,
    required Map<String, dynamic> itemTemplate,
    Map<String, dynamic>? itemTap,
    double spacing = 0,
    bool shrinkWrap = false,
    String orientation = 'vertical',
    Map<String, dynamic>? pagination,
  }) {
    return {
      'type': 'list',
      'items': items,
      'itemTemplate': itemTemplate,
      if (itemTap != null) 'onItemTap': itemTap,
      'spacing': spacing,
      'shrinkWrap': shrinkWrap,
      'orientation': orientation,
      if (pagination != null) 'pagination': pagination,
    };
  }

  /// Create a grid widget (MCP UI DSL v1.0)
  static Map<String, dynamic> grid({
    required String items,
    required Map<String, dynamic>
        itemTemplate, // MCP UI DSL callback uses 'itemTemplate'
    Map<String, dynamic>? itemTap,
    int crossAxisCount = 2,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    double childAspectRatio = 1.0,
  }) {
    return {
      'type': 'grid',
      'items': items,
      'itemTemplate': itemTemplate, // MCP UI DSL callback uses 'itemTemplate'
      if (itemTap != null) 'onItemTap': itemTap,
      'crossAxisCount': crossAxisCount,
      'mainAxisSpacing': mainAxisSpacing,
      'crossAxisSpacing': crossAxisSpacing,
      'childAspectRatio': childAspectRatio,
    };
  }

  /// Create a listItem (canonical per spec 17_Naming §17.2.1).
  /// [title] and [subtitle] accept either a String or a widget Map for rich content.
  static Map<String, dynamic> listItem({
    dynamic title,
    dynamic subtitle,
    Map<String, dynamic>? leading,
    Map<String, dynamic>? trailing,
    Map<String, dynamic>? click,
  }) {
    return {
      'type': 'listItem',
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (leading != null) 'leading': leading,
      if (trailing != null) 'trailing': trailing,
      if (click != null) 'onTap': click,
    };
  }

  /// Alias for listItem (legacy name per spec §17.3.1). Emits the canonical
  /// `'type': 'listItem'` to comply with §17.5.2 canonical emission.
  static Map<String, dynamic> listTile({
    dynamic title,
    dynamic subtitle,
    Map<String, dynamic>? leading,
    Map<String, dynamic>? trailing,
    Map<String, dynamic>? click,
  }) {
    return listItem(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      click: click,
    );
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
    required Map<String, dynamic> change,
    String barType = 'fixed',
  }) {
    return {
      'type': 'bottomNavigation',
      'items': items,
      'currentIndex': currentIndex,
      'onChange': change,
      'barType': barType,
    };
  }

  /// Creates a drawer widget with arbitrary child content.
  /// For navigation-oriented drawers with item lists, use [drawerNavigation].
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
    String? icon,
    String? label,
    String? tooltip,
  }) {
    return {
      'type': 'floatingActionButton',
      'onTap': click,
      if (icon != null) 'icon': icon,
      if (label != null) 'label': label,
      if (tooltip != null) 'tooltip': tooltip,
    };
  }

  // ===== Navigation Structure Helpers =====

  /// Creates a drawer with a navigation items list, optional header and footer.
  /// For drawers with arbitrary child content, use [MCPWidgets.drawer].
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
    String? firstDate,
    String? lastDate,
    Map<String, dynamic>? change,
    List<Map<String, dynamic>>? events,
    bool showHeader = true,
    double? width,
    double? height,
  }) {
    return {
      'type': 'calendar',
      'view': view,
      if (selectedDate != null) 'selectedDate': selectedDate,
      if (firstDate != null) 'firstDate': firstDate,
      if (lastDate != null) 'lastDate': lastDate,
      if (change != null) 'onChange': change,
      if (events != null) 'events': events,
      'showHeader': showHeader,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
    };
  }

  /// Create a tree widget. [data] accepts a binding string or a literal list.
  static Map<String, dynamic> tree({
    required dynamic data,
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
    String tool, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? onSuccess,
    Map<String, dynamic>? onError,
  }) {
    return {
      'type': 'tool',
      'tool': tool,
      if (params != null) 'params': params,
      if (onSuccess != null) 'onSuccess': onSuccess,
      if (onError != null) 'onError': onError,
    };
  }

  /// Create a state action (MCP UI DSL v1.0 spec)
  static Map<String, dynamic> stateAction({
    required String action,
    String? binding,
    @Deprecated('Use binding instead') String? path,
    dynamic value,
    num? amount,
  }) {
    final effectiveBinding = binding ?? path;
    return {
      'type': 'state',
      'action': action,
      if (effectiveBinding != null) 'binding': effectiveBinding,
      if (value != null) 'value': value,
      if (amount != null) 'amount': amount,
    };
  }

  /// Create a navigation action (MCP UI DSL v1.0 spec)
  static Map<String, dynamic> navigationAction({
    required String action,
    String? route,
    Map<String, dynamic>? params,
    int? index, // Tab/page index for setIndex action
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
    required String uri,
    String? binding,
    @Deprecated('Use binding instead') String? target,
    Duration? refreshInterval,
    Map<String, dynamic>? onUpdate,
    Map<String, dynamic>? onError,
  }) {
    final effectiveBinding = binding ?? target;
    return {
      'type': 'resource',
      'uri': uri,
      if (effectiveBinding != null) 'binding': effectiveBinding,
      if (refreshInterval != null)
        'refreshInterval': refreshInterval.inMilliseconds,
      if (onUpdate != null) 'onUpdate': onUpdate,
      if (onError != null) 'onError': onError,
    };
  }

  /// Create a batch action (MCP UI DSL v1.0 spec)
  static Map<String, dynamic> batchAction({
    required List<Map<String, dynamic>> actions,
    bool? sequential,
  }) {
    return {
      'type': 'batch',
      'actions': actions,
      if (sequential != null) 'sequential': sequential,
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
      if (orElse != null) 'else': orElse,
    };
  }

  // ===== Theme Builders =====

  /// Create a complete 1.3 theme definition map (M3 14-domain).
  static Map<String, dynamic> theme({
    String mode = 'system',
    Map<String, dynamic>? color,
    Map<String, dynamic>? typography,
    Map<String, dynamic>? spacing,
    Map<String, dynamic>? shape,
    Map<String, dynamic>? elevation,
    Map<String, dynamic>? motion,
    Map<String, dynamic>? density,
    Map<String, dynamic>? breakpoints,
    Map<String, dynamic>? border,
    Map<String, dynamic>? opacity,
    Map<String, dynamic>? focusRing,
    Map<String, dynamic>? zIndex,
    Map<String, dynamic>? component,
    Map<String, dynamic>? light,
    Map<String, dynamic>? dark,
  }) {
    final theme = <String, dynamic>{
      'mode': mode,
    };

    if (color != null) theme['color'] = color;
    if (typography != null) theme['typography'] = typography;
    if (spacing != null) theme['spacing'] = spacing;
    if (shape != null) theme['shape'] = shape;
    if (elevation != null) theme['elevation'] = elevation;
    if (motion != null) theme['motion'] = motion;
    if (density != null) theme['density'] = density;
    if (breakpoints != null) theme['breakpoints'] = breakpoints;
    if (border != null) theme['border'] = border;
    if (opacity != null) theme['opacity'] = opacity;
    if (focusRing != null) theme['focusRing'] = focusRing;
    if (zIndex != null) theme['zIndex'] = zIndex;
    if (component != null) theme['component'] = component;

    if (light != null) theme['light'] = light;
    if (dark != null) theme['dark'] = dark;

    return theme;
  }

  /// Build a 1.3 [color] block (Material 3 28-role) — accepts only the
  /// values you want to override, falling back to seed-derived defaults
  /// at runtime when [seed] is provided.
  static Map<String, dynamic> themeColors({
    String? seed,
    String? primary,
    String? onPrimary,
    String? primaryContainer,
    String? onPrimaryContainer,
    String? secondary,
    String? onSecondary,
    String? secondaryContainer,
    String? onSecondaryContainer,
    String? tertiary,
    String? onTertiary,
    String? tertiaryContainer,
    String? onTertiaryContainer,
    String? error,
    String? onError,
    String? errorContainer,
    String? onErrorContainer,
    String? surface,
    String? onSurface,
    String? onSurfaceVariant,
    String? surfaceTint,
    String? surfaceBright,
    String? surfaceDim,
    String? surfaceContainerLowest,
    String? surfaceContainerLow,
    String? surfaceContainer,
    String? surfaceContainerHigh,
    String? surfaceContainerHighest,
    String? outline,
    String? outlineVariant,
    String? inverseSurface,
    String? onInverseSurface,
    String? inversePrimary,
    String? scrim,
    String? shadow,
    String? success,
    String? onSuccess,
    String? warning,
    String? onWarning,
    String? info,
    String? onInfo,
    Map<String, dynamic>? stateLayer,
  }) {
    final out = <String, dynamic>{};
    void put(String k, Object? v) {
      if (v != null) out[k] = v;
    }

    put('seed', seed);
    put('primary', primary);
    put('onPrimary', onPrimary);
    put('primaryContainer', primaryContainer);
    put('onPrimaryContainer', onPrimaryContainer);
    put('secondary', secondary);
    put('onSecondary', onSecondary);
    put('secondaryContainer', secondaryContainer);
    put('onSecondaryContainer', onSecondaryContainer);
    put('tertiary', tertiary);
    put('onTertiary', onTertiary);
    put('tertiaryContainer', tertiaryContainer);
    put('onTertiaryContainer', onTertiaryContainer);
    put('error', error);
    put('onError', onError);
    put('errorContainer', errorContainer);
    put('onErrorContainer', onErrorContainer);
    put('surface', surface);
    put('onSurface', onSurface);
    put('onSurfaceVariant', onSurfaceVariant);
    put('surfaceTint', surfaceTint);
    put('surfaceBright', surfaceBright);
    put('surfaceDim', surfaceDim);
    put('surfaceContainerLowest', surfaceContainerLowest);
    put('surfaceContainerLow', surfaceContainerLow);
    put('surfaceContainer', surfaceContainer);
    put('surfaceContainerHigh', surfaceContainerHigh);
    put('surfaceContainerHighest', surfaceContainerHighest);
    put('outline', outline);
    put('outlineVariant', outlineVariant);
    put('inverseSurface', inverseSurface);
    put('onInverseSurface', onInverseSurface);
    put('inversePrimary', inversePrimary);
    put('scrim', scrim);
    put('shadow', shadow);
    put('success', success);
    put('onSuccess', onSuccess);
    put('warning', warning);
    put('onWarning', onWarning);
    put('info', info);
    put('onInfo', onInfo);
    put('stateLayer', stateLayer);
    return out;
  }

  /// Build a 1.3 typography block (Material 3 — 15 role).
  ///
  /// Roles: `displayLarge/Medium/Small`, `headlineLarge/Medium/Small`,
  /// `titleLarge/Medium/Small`, `bodyLarge/Medium/Small`,
  /// `labelLarge/Medium/Small`. Defaults follow M3 type scale.
  static Map<String, dynamic> themeTypography({
    Map<String, dynamic>? displayLarge,
    Map<String, dynamic>? displayMedium,
    Map<String, dynamic>? displaySmall,
    Map<String, dynamic>? headlineLarge,
    Map<String, dynamic>? headlineMedium,
    Map<String, dynamic>? headlineSmall,
    Map<String, dynamic>? titleLarge,
    Map<String, dynamic>? titleMedium,
    Map<String, dynamic>? titleSmall,
    Map<String, dynamic>? bodyLarge,
    Map<String, dynamic>? bodyMedium,
    Map<String, dynamic>? bodySmall,
    Map<String, dynamic>? labelLarge,
    Map<String, dynamic>? labelMedium,
    Map<String, dynamic>? labelSmall,
  }) {
    Map<String, dynamic> ts(
            num size, String w, num lh, num spacing) =>
        {'fontSize': size, 'fontWeight': w, 'lineHeight': lh, 'letterSpacing': spacing};
    return {
      'displayLarge': displayLarge ?? ts(57, 'regular', 64, -0.25),
      'displayMedium': displayMedium ?? ts(45, 'regular', 52, 0),
      'displaySmall': displaySmall ?? ts(36, 'regular', 44, 0),
      'headlineLarge': headlineLarge ?? ts(32, 'regular', 40, 0),
      'headlineMedium': headlineMedium ?? ts(28, 'regular', 36, 0),
      'headlineSmall': headlineSmall ?? ts(24, 'regular', 32, 0),
      'titleLarge': titleLarge ?? ts(22, 'medium', 28, 0),
      'titleMedium': titleMedium ?? ts(16, 'medium', 24, 0.15),
      'titleSmall': titleSmall ?? ts(14, 'medium', 20, 0.1),
      'bodyLarge': bodyLarge ?? ts(16, 'regular', 24, 0.5),
      'bodyMedium': bodyMedium ?? ts(14, 'regular', 20, 0.25),
      'bodySmall': bodySmall ?? ts(12, 'regular', 16, 0.4),
      'labelLarge': labelLarge ?? ts(14, 'medium', 20, 0.1),
      'labelMedium': labelMedium ?? ts(12, 'medium', 16, 0.5),
      'labelSmall': labelSmall ?? ts(11, 'medium', 16, 0.5),
    };
  }

  /// Build a 1.3 spacing block (8pt grid · 9 primitives + 4 layout aliases).
  ///
  /// Wire keys for 2xl/3xl/4xl follow MCP UI DSL canonical form.
  static Map<String, dynamic> themeSpacing({
    num xxs = 2,
    num xs = 4,
    num sm = 8,
    num md = 16,
    num lg = 24,
    num xl = 32,
    num xxl = 48,
    num xxxl = 64,
    num xxxxl = 96,
    num? screenPadding,
    num? cardPadding,
    num? sectionGap,
    num? inlineGap,
  }) {
    final m = <String, dynamic>{
      'xxs': xxs,
      'xs': xs,
      'sm': sm,
      'md': md,
      'lg': lg,
      'xl': xl,
      '2xl': xxl,
      '3xl': xxxl,
      '4xl': xxxxl,
    };
    if (screenPadding != null) m['screenPadding'] = screenPadding;
    if (cardPadding != null) m['cardPadding'] = cardPadding;
    if (sectionGap != null) m['sectionGap'] = sectionGap;
    if (inlineGap != null) m['inlineGap'] = inlineGap;
    return m;
  }

  /// Build a 1.3 shape block (Material 3 — 7 family + per-corner override).
  static Map<String, dynamic> themeShape({
    Object none = 0,
    Object extraSmall = 4,
    Object small = 8,
    Object medium = 12,
    Object large = 16,
    Object extraLarge = 28,
    Object full = 9999,
  }) {
    return {
      'none': none,
      'extraSmall': extraSmall,
      'small': small,
      'medium': medium,
      'large': large,
      'extraLarge': extraLarge,
      'full': full,
    };
  }

  /// Build a 1.3 elevation block (Material 3 — 6 levels: 0/1/3/6/8/12).
  static Map<String, dynamic> themeElevation({
    num level0Shadow = 0,
    num level1Shadow = 1,
    num level2Shadow = 3,
    num level3Shadow = 6,
    num level4Shadow = 8,
    num level5Shadow = 12,
    String? tint,
  }) {
    Map<String, dynamic> level(num shadow) => tint == null
        ? {'shadow': shadow}
        : {'shadow': shadow, 'tint': tint};
    return {
      'level0': level(level0Shadow),
      'level1': level(level1Shadow),
      'level2': level(level2Shadow),
      'level3': level(level3Shadow),
      'level4': level(level4Shadow),
      'level5': level(level5Shadow),
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

  /// Get theme color binding (M3 28-role slot: `primary`, `surface`, ...).
  static String themeColor(String slot) => themeBinding('color.$slot');

  /// Get theme typography binding (e.g. `('bodyLarge', 'fontSize')`).
  static String themeTypographyProperty(String role, String property) =>
      themeBinding('typography.$role.$property');

  /// Get theme spacing binding (`xxs/xs/sm/md/lg/xl/2xl/3xl/4xl`).
  static String themeSpacingValue(String token) =>
      themeBinding('spacing.$token');

  /// Get theme shape binding
  /// (`none/extraSmall/small/medium/large/extraLarge/full`).
  static String themeShapeValue(String family) =>
      themeBinding('shape.$family');

  /// Get theme elevation binding (`level0/level1/level2/level3/level4/level5`).
  static String themeElevationValue(String level) =>
      themeBinding('elevation.$level.shadow');

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

  /// Add accessibility properties to a widget (platform-agnostic naming per P3)
  static Map<String, dynamic> withAccessibility(
    Map<String, dynamic> widget, {
    String? label,
    String? role,
    String? description,
    bool? hidden,
    String? live,
    // Legacy parameter names for backward compatibility
    @Deprecated('Use label instead') String? ariaLabel,
    @Deprecated('Use role instead') String? ariaRole,
    @Deprecated('Use description instead') String? ariaDescription,
    @Deprecated('Use hidden instead') bool? ariaHidden,
    @Deprecated('Use live instead') String? ariaLive,
  }) {
    final updatedWidget = Map<String, dynamic>.from(widget);

    // Platform-agnostic names (preferred)
    final effectiveLabel = label ?? ariaLabel;
    final effectiveRole = role ?? ariaRole;
    final effectiveDescription = description ?? ariaDescription;
    final effectiveHidden = hidden ?? ariaHidden;
    final effectiveLive = live ?? ariaLive;

    if (effectiveLabel != null) updatedWidget['label'] = effectiveLabel;
    if (effectiveRole != null) updatedWidget['role'] = effectiveRole;
    if (effectiveDescription != null) {
      updatedWidget['description'] = effectiveDescription;
    }
    if (effectiveHidden != null) updatedWidget['hidden'] = effectiveHidden;
    if (effectiveLive != null) updatedWidget['live'] = effectiveLive;

    return updatedWidget;
  }

  /// Create an accessible button
  static Map<String, dynamic> accessibleButton({
    required String label,
    required Map<String, dynamic> click,
    String? accessibilityLabel,
    String? accessibilityRole = 'button',
    String variant = 'elevated',
    String? icon,
    bool disabled = false,
  }) {
    return withAccessibility(
      button(
        label: label,
        click: click,
        variant: variant,
        icon: icon,
        disabled: disabled,
      ),
      label: accessibilityLabel ?? label,
      role: accessibilityRole,
    );
  }

  /// Create an accessible text input
  static Map<String, dynamic> accessibleTextInput({
    required String label,
    required String value,
    required Map<String, dynamic> change,
    String? accessibilityLabel,
    String? accessibilityRole = 'textbox',
    String? accessibilityDescription,
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
      label: accessibilityLabel ?? label,
      role: accessibilityRole,
      description: accessibilityDescription ?? helperText,
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
  static Map<String, dynamic> i18nTranslations(
      Map<String, dynamic> translations) {
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
    String variant = 'elevated',
    String? icon,
    bool disabled = false,
  }) {
    return button(
      label: i18n(labelKey, args: labelArgs),
      click: click,
      variant: variant,
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

  /// Build a 1.3 [core.ThemeDefinition] from a JSON map covering any of the
  /// 14 M3 token domains (color, typography, spacing, shape, elevation, motion,
  /// density, breakpoints, border, opacity, focusRing, zIndex, component) plus
  /// optional `light` / `dark` mode-specific overrides.
  static core.ThemeDefinition themeDefinition({
    String mode = 'system',
    Map<String, dynamic>? color,
    Map<String, dynamic>? typography,
    Map<String, dynamic>? spacing,
    Map<String, dynamic>? shape,
    Map<String, dynamic>? elevation,
    Map<String, dynamic>? motion,
    Map<String, dynamic>? density,
    Map<String, dynamic>? breakpoints,
    Map<String, dynamic>? border,
    Map<String, dynamic>? opacity,
    Map<String, dynamic>? focusRing,
    Map<String, dynamic>? zIndex,
    Map<String, dynamic>? component,
    Map<String, dynamic>? light,
    Map<String, dynamic>? dark,
  }) {
    final json = <String, dynamic>{'mode': mode};
    if (color != null) json['color'] = color;
    if (typography != null) json['typography'] = typography;
    if (spacing != null) json['spacing'] = spacing;
    if (shape != null) json['shape'] = shape;
    if (elevation != null) json['elevation'] = elevation;
    if (motion != null) json['motion'] = motion;
    if (density != null) json['density'] = density;
    if (breakpoints != null) json['breakpoints'] = breakpoints;
    if (border != null) json['border'] = border;
    if (opacity != null) json['opacity'] = opacity;
    if (focusRing != null) json['focusRing'] = focusRing;
    if (zIndex != null) json['zIndex'] = zIndex;
    if (component != null) json['component'] = component;
    if (light != null) json['light'] = light;
    if (dark != null) json['dark'] = dark;
    return core.ThemeDefinition.fromJson(json);
  }

  // ===== Convenience Aliases (for backward compatibility) =====
  
  /// Alias for linear with vertical direction
  static Map<String, dynamic> column({
    required List<Map<String, dynamic>> children,
    String distribution = 'start',
    String alignment = 'center',
    double? gap,
    bool wrap = false,
  }) {
    return linear(
      children: children,
      direction: 'vertical',
      distribution: distribution,
      alignment: alignment,
      gap: gap,
      wrap: wrap,
    );
  }

  /// Alias for linear with horizontal direction
  static Map<String, dynamic> row({
    required List<Map<String, dynamic>> children,
    String distribution = 'start',
    String alignment = 'center',
    double? gap,
    bool wrap = false,
  }) {
    return linear(
      children: children,
      direction: 'horizontal',
      distribution: distribution,
      alignment: alignment,
      gap: gap,
      wrap: wrap,
    );
  }

  /// Alias for box widget
  static Map<String, dynamic> container({
    Map<String, dynamic>? child,
    double? width,
    double? height,
    Map<String, dynamic>? padding,
    Map<String, dynamic>? margin,
    Map<String, dynamic>? decoration,
    String? color,
  }) {
    return box(
      child: child,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration,
      color: color,
    );
  }

  /// Alias for headerBar widget
  static Map<String, dynamic> appBar({
    required String title,
    List<Map<String, dynamic>>? actions,
    Map<String, dynamic>? leading,
    double elevation = 4,
  }) {
    return headerBar(
      title: title,
      actions: actions,
      leading: leading,
      elevation: elevation,
    );
  }

  // ===== v1.1 Client Action Helpers =====

  /// Generate client.selectFile action (v1.1)
  static Map<String, dynamic> clientSelectFile({
    String? title,
    List<Map<String, dynamic>>? filters,
    String? defaultPath,
    bool multiple = false,
    Map<String, dynamic>? onSuccess,
    Map<String, dynamic>? onError,
  }) {
    return {
      'type': 'client.selectFile',
      if (title != null) 'title': title,
      if (filters != null) 'filters': filters,
      if (defaultPath != null) 'defaultPath': defaultPath,
      'multiple': multiple,
      if (onSuccess != null) 'onSuccess': onSuccess,
      if (onError != null) 'onError': onError,
    };
  }

  /// Generate client.readFile action (v1.1)
  static Map<String, dynamic> clientReadFile({
    required String path,
    String encoding = 'utf-8',
    Map<String, dynamic>? onSuccess,
    Map<String, dynamic>? onError,
  }) {
    return {
      'type': 'client.readFile',
      'path': path,
      'encoding': encoding,
      if (onSuccess != null) 'onSuccess': onSuccess,
      if (onError != null) 'onError': onError,
    };
  }

  /// Generate client.writeFile action (v1.1)
  static Map<String, dynamic> clientWriteFile({
    required String path,
    required String content,
    String? confirmMessage,
    Map<String, dynamic>? onSuccess,
    Map<String, dynamic>? onError,
  }) {
    return {
      'type': 'client.writeFile',
      'path': path,
      'content': content,
      if (confirmMessage != null) 'confirmMessage': confirmMessage,
      if (onSuccess != null) 'onSuccess': onSuccess,
      if (onError != null) 'onError': onError,
    };
  }

  /// Generate client.saveFile action (save-as dialog) (v1.1)
  static Map<String, dynamic> clientSaveFile({
    required String content,
    String? defaultName,
    List<Map<String, dynamic>>? filters,
    Map<String, dynamic>? onSuccess,
    Map<String, dynamic>? onError,
  }) {
    return {
      'type': 'client.saveFile',
      'content': content,
      if (defaultName != null) 'defaultName': defaultName,
      if (filters != null) 'filters': filters,
      if (onSuccess != null) 'onSuccess': onSuccess,
      if (onError != null) 'onError': onError,
    };
  }

  /// Generate client.listFiles action (v1.1)
  static Map<String, dynamic> clientListFiles({
    required String path,
    String? pattern,
    bool recursive = false,
    Map<String, dynamic>? onSuccess,
    Map<String, dynamic>? onError,
  }) {
    return {
      'type': 'client.listFiles',
      'path': path,
      if (pattern != null) 'pattern': pattern,
      'recursive': recursive,
      if (onSuccess != null) 'onSuccess': onSuccess,
      if (onError != null) 'onError': onError,
    };
  }

  /// Generate client.httpRequest action (v1.1)
  static Map<String, dynamic> clientHttpRequest({
    required String url,
    String method = 'GET',
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? onSuccess,
    Map<String, dynamic>? onError,
  }) {
    return {
      'type': 'client.httpRequest',
      'url': url,
      'method': method,
      if (headers != null) 'headers': headers,
      if (body != null) 'body': body,
      if (onSuccess != null) 'onSuccess': onSuccess,
      if (onError != null) 'onError': onError,
    };
  }

  /// Generate client.getSystemInfo action (v1.1)
  static Map<String, dynamic> clientGetSystemInfo({
    List<String>? properties,
    Map<String, dynamic>? onSuccess,
    Map<String, dynamic>? onError,
  }) {
    return {
      'type': 'client.getSystemInfo',
      if (properties != null) 'properties': properties,
      if (onSuccess != null) 'onSuccess': onSuccess,
      if (onError != null) 'onError': onError,
    };
  }

  /// Generate client.exec action (v1.1)
  static Map<String, dynamic> clientExec({
    required String command,
    List<String>? args,
    String? cwd,
    int? timeout,
    bool requireConfirmation = true,
    Map<String, dynamic>? onSuccess,
    Map<String, dynamic>? onError,
  }) {
    return {
      'type': 'client.exec',
      'command': command,
      if (args != null) 'args': args,
      if (cwd != null) 'cwd': cwd,
      if (timeout != null) 'timeout': timeout,
      'requireConfirmation': requireConfirmation,
      if (onSuccess != null) 'onSuccess': onSuccess,
      if (onError != null) 'onError': onError,
    };
  }

  // ===== v1.1 Permission Helpers =====

  /// Generate permissions declaration for screen/page level (v1.1)
  static Map<String, dynamic> permissions({
    Map<String, dynamic>? file,
    Map<String, dynamic>? network,
    Map<String, dynamic>? system,
  }) {
    return {
      'permissions': {
        if (file != null) 'file': file,
        if (network != null) 'network': network,
        if (system != null) 'system': system,
      },
    };
  }

  /// Generate file permission definition (v1.1)
  static Map<String, dynamic> filePermissions({
    Map<String, dynamic>? read,
    Map<String, dynamic>? write,
  }) {
    return {
      if (read != null) 'read': read,
      if (write != null) 'write': write,
    };
  }

  /// Generate network permission definition (v1.1)
  static Map<String, dynamic> networkPermissions({
    Map<String, dynamic>? http,
  }) {
    return {
      if (http != null) 'http': http,
    };
  }

  /// Generate system permission definition (v1.1)
  static Map<String, dynamic> systemPermissions({
    List<String>? info,
    Map<String, dynamic>? exec,
  }) {
    return {
      if (info != null) 'info': info,
      if (exec != null) 'exec': exec,
    };
  }

  /// Generate permissionPrompt widget definition (v1.1)
  static Map<String, dynamic> permissionPrompt({
    required List<String> permissions,
    String? title,
    String? message,
    bool? remember,
  }) {
    return {
      'type': 'permissionPrompt',
      'permissions': permissions,
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (remember != null) 'remember': remember,
    };
  }

  // ===== v1.1 Channel Helpers =====

  /// Generate channels declaration for screen/page level (v1.1)
  static Map<String, dynamic> channels(
      Map<String, Map<String, dynamic>> channelDefs) {
    return {
      'channels': channelDefs,
    };
  }

  /// Generate client.watchFile channel definition (v1.1)
  static Map<String, dynamic> watchFileChannel({
    required String path,
    List<String>? events,
  }) {
    return {
      'type': 'client.watchFile',
      'path': path,
      if (events != null) 'events': events,
    };
  }

  /// Generate client.watchDirectory channel definition (v1.1)
  static Map<String, dynamic> watchDirectoryChannel({
    required String path,
    bool recursive = false,
    List<String>? events,
  }) {
    return {
      'type': 'client.watchDirectory',
      'path': path,
      'recursive': recursive,
      if (events != null) 'events': events,
    };
  }

  /// Generate client.systemMonitor channel definition (v1.1)
  static Map<String, dynamic> systemMonitorChannel({
    required List<String> metrics,
    int interval = 1000,
  }) {
    return {
      'type': 'client.systemMonitor',
      'metrics': metrics,
      'interval': interval,
    };
  }

  /// Generate client.poll channel definition (v1.1)
  static Map<String, dynamic> pollChannel({
    required Map<String, dynamic> action,
    required int interval,
    String? binding,
  }) {
    return {
      'type': 'client.poll',
      'action': action,
      'interval': interval,
      if (binding != null) 'binding': binding,
    };
  }

  /// Generate channel.start/stop/toggle action (v1.1)
  static Map<String, dynamic> channelAction({
    required String channel,
    required String action,
  }) {
    return {
      'type': 'channel.$action',
      'channel': channel,
    };
  }

  // ===== v1.1 Client Binding Helpers =====

  /// Client data binding (v1.1)
  static String clientBinding(String path) => '{{client.$path}}';

  /// Client working directory binding (v1.1)
  static String clientWorkingDirectory() => '{{client.workingDirectory}}';

  /// Client user name binding (v1.1)
  static String clientUserName() => '{{client.userName}}';

  /// Client platform binding (v1.1)
  static String clientPlatform() => '{{client.platform}}';

  /// Client locale binding (v1.1)
  static String clientLocale() => '{{client.locale}}';

  /// Client theme property binding (v1.1)
  static String clientTheme(String property) =>
      '{{client.theme.$property}}';

  /// Permission state binding (v1.1)
  static String permissionBinding(String path) =>
      '{{permissions.$path}}';

  /// Channel data binding (v1.1)
  static String channelBinding(String name, String property) =>
      '{{channels.$name.$property}}';

  // ===== v1.3 Widgets =====

  /// Create a canvas widget (v1.3)
  static Map<String, dynamic> canvas({
    required double width,
    required double height,
    required List<Map<String, dynamic>> commands,
    String? backgroundColor,
  }) {
    return {
      'type': 'canvas',
      'width': width,
      'height': height,
      'commands': commands,
      if (backgroundColor != null) 'backgroundColor': backgroundColor,
    };
  }

  /// Create an opacity widget (v1.3)
  static Map<String, dynamic> opacity({
    required double opacity,
    required Map<String, dynamic> child,
    bool? animated,
    int? duration,
    String? curve,
  }) {
    return {
      'type': 'opacity',
      'opacity': opacity,
      'child': child,
      if (animated != null) 'animated': animated,
      if (duration != null) 'duration': duration,
      if (curve != null) 'curve': curve,
    };
  }

  /// Create a transform widget (v1.3)
  static Map<String, dynamic> transform({
    required Map<String, dynamic> child,
    double? rotate,
    dynamic scale,
    Map<String, dynamic>? translate,
    Map<String, dynamic>? origin,
    bool? animated,
    int? duration,
    String? curve,
  }) {
    return {
      'type': 'transform',
      'child': child,
      if (rotate != null) 'rotate': rotate,
      if (scale != null) 'scale': scale,
      if (translate != null) 'translate': translate,
      if (origin != null) 'origin': origin,
      if (animated != null) 'animated': animated,
      if (duration != null) 'duration': duration,
      if (curve != null) 'curve': curve,
    };
  }
}
