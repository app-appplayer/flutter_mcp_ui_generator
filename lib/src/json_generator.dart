import 'dart:convert';
import 'dart:io';
import 'package:flutter_mcp_ui_core/flutter_mcp_ui_core.dart' as core;

/// MCP UI JSON Generator v1.0
/// 
/// Generates JSON UI definitions for MCP UI DSL v1.0 specification
/// Compatible with flutter_mcp_ui_runtime
class MCPUIJsonGenerator {
  
  // ===== Application & Page Builders =====
  
  /// Create an application definition
  static Map<String, dynamic> application({
    required String title,
    required String version,
    required Map<String, dynamic> routes,
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
  
  static Map<String, dynamic> container({
    Map<String, dynamic>? child,
    double? width,
    double? height,
    Map<String, dynamic>? padding,
    Map<String, dynamic>? margin,
    Map<String, dynamic>? decoration,
    String? color,
  }) {
    return {
      'type': 'container',
      if (child != null) 'child': child,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (padding != null) 'padding': padding,
      if (margin != null) 'margin': margin,
      if (decoration != null) 'decoration': decoration,
      if (color != null) 'color': color,
    };
  }
  
  static Map<String, dynamic> column({
    required List<Map<String, dynamic>> children,
    String mainAxisAlignment = 'start',
    String crossAxisAlignment = 'center',
    String mainAxisSize = 'max',
  }) {
    return {
      'type': 'column',
      'children': children,
      'mainAxisAlignment': mainAxisAlignment,
      'crossAxisAlignment': crossAxisAlignment,
      'mainAxisSize': mainAxisSize,
    };
  }
  
  static Map<String, dynamic> row({
    required List<Map<String, dynamic>> children,
    String mainAxisAlignment = 'start',
    String crossAxisAlignment = 'center',
    String mainAxisSize = 'max',
  }) {
    return {
      'type': 'row',
      'children': children,
      'mainAxisAlignment': mainAxisAlignment,
      'crossAxisAlignment': crossAxisAlignment,
      'mainAxisSize': mainAxisSize,
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
    int flex = 1,
  }) {
    return {
      'type': 'expanded',
      'child': child,
      'flex': flex,
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
      'type': 'sizedbox',
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
  
  static Map<String, dynamic> scrollView({
    required Map<String, dynamic> child,
    String scrollDirection = 'vertical',
    bool reverse = false,
    Map<String, dynamic>? padding,
    bool primary = true,
    String? physics,
  }) {
    return {
      'type': 'scrollview',
      'child': child,
      'scrollDirection': scrollDirection,
      'reverse': reverse,
      if (padding != null) 'padding': padding,
      'primary': primary,
      if (physics != null) 'physics': physics,
    };
  }
  
  // ===== Display Widgets =====
  
  static Map<String, dynamic> text(
    String content, {
    Map<String, dynamic>? style,
    String? textAlign,
    int? maxLines,
    String? overflow,
  }) {
    return {
      'type': 'text',
      'value': content, // Note: runtime expects 'value' or 'content'
      if (style != null) 'style': style,
      if (textAlign != null) 'textAlign': textAlign,
      if (maxLines != null) 'maxLines': maxLines,
      if (overflow != null) 'overflow': overflow,
    };
  }
  
  static Map<String, dynamic> image({
    required String src,
    double? width,
    double? height,
    String fit = 'cover',
  }) {
    return {
      'type': 'image',
      'src': src,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      'fit': fit,
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
  
  // ===== Input Widgets =====
  
  static Map<String, dynamic> button({
    required String label,
    required Map<String, dynamic> onTap,
    String style = 'elevated',
    String? icon,
    bool disabled = false,
  }) {
    return {
      'type': 'button',
      'label': label,
      'onTap': onTap,
      'style': style,
      if (icon != null) 'icon': icon,
      'disabled': disabled,
    };
  }
  
  static Map<String, dynamic> textField({
    required String label,
    required String value,
    required Map<String, dynamic> onChange,
    String? placeholder,
    String? helperText,
    String? errorText,
    bool obscureText = false,
    int? maxLines,
  }) {
    return {
      'type': 'textfield',
      'label': label,
      'value': value,
      'onChange': onChange,
      if (placeholder != null) 'placeholder': placeholder,
      if (helperText != null) 'helperText': helperText,
      if (errorText != null) 'errorText': errorText,
      'obscureText': obscureText,
      if (maxLines != null) 'maxLines': maxLines,
    };
  }
  
  static Map<String, dynamic> checkbox({
    required String value,
    required Map<String, dynamic> onChange,
    String? label,
  }) {
    return {
      'type': 'checkbox',
      'value': value,
      'onChange': onChange,
      if (label != null) 'label': label,
    };
  }
  
  static Map<String, dynamic> switchWidget({
    required String value,
    required Map<String, dynamic> onChange,
    String? label,
  }) {
    return {
      'type': 'switch',
      'value': value,
      'onChange': onChange,
      if (label != null) 'label': label,
    };
  }
  
  static Map<String, dynamic> slider({
    required String value,
    required Map<String, dynamic> onChange,
    double min = 0,
    double max = 100,
    int? divisions,
    String? label,
  }) {
    return {
      'type': 'slider',
      'value': value,
      'onChange': onChange,
      'min': min,
      'max': max,
      if (divisions != null) 'divisions': divisions,
      if (label != null) 'label': label,
    };
  }
  
  static Map<String, dynamic> dropdown({
    required String value,
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> onChange,
    String? label,
    String? placeholder,
  }) {
    return {
      'type': 'dropdown',
      'value': value,
      'items': items,
      'onChange': onChange,
      if (label != null) 'label': label,
      if (placeholder != null) 'placeholder': placeholder,
    };
  }
  
  static Map<String, dynamic> numberField({
    required String label,
    required String value,
    required Map<String, dynamic> onChange,
    double? min,
    double? max,
    double? step,
    String? placeholder,
    String? helperText,
    String? errorText,
  }) {
    return {
      'type': 'numberfield',
      'label': label,
      'value': value,
      'onChange': onChange,
      if (min != null) 'min': min,
      if (max != null) 'max': max,
      if (step != null) 'step': step,
      if (placeholder != null) 'placeholder': placeholder,
      if (helperText != null) 'helperText': helperText,
      if (errorText != null) 'errorText': errorText,
    };
  }
  
  static Map<String, dynamic> colorPicker({
    required String value,
    required Map<String, dynamic> onChange,
    String? label,
    bool enableAlpha = true,
    List<String>? swatchColors,
  }) {
    return {
      'type': 'colorpicker',
      'value': value,
      'onChange': onChange,
      if (label != null) 'label': label,
      'enableAlpha': enableAlpha,
      if (swatchColors != null) 'swatchColors': swatchColors,
    };
  }
  
  static Map<String, dynamic> radioGroup({
    required String value,
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> onChange,
    String? label,
    String orientation = 'vertical',
  }) {
    return {
      'type': 'radiogroup',
      'value': value,
      'items': items,
      'onChange': onChange,
      if (label != null) 'label': label,
      'orientation': orientation,
    };
  }
  
  static Map<String, dynamic> checkboxGroup({
    required String value,
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> onChange,
    String? label,
    String orientation = 'vertical',
  }) {
    return {
      'type': 'checkboxgroup',
      'value': value,
      'items': items,
      'onChange': onChange,
      if (label != null) 'label': label,
      'orientation': orientation,
    };
  }
  
  static Map<String, dynamic> segmentedControl({
    required String value,
    required List<Map<String, dynamic>> items,
    required Map<String, dynamic> onChange,
    String? label,
  }) {
    return {
      'type': 'segmentedcontrol',
      'value': value,
      'items': items,
      'onChange': onChange,
      if (label != null) 'label': label,
    };
  }
  
  static Map<String, dynamic> dateField({
    required String value,
    required Map<String, dynamic> onChange,
    String? label,
    String? minDate,
    String? maxDate,
    String format = 'yyyy-MM-dd',
    String? placeholder,
  }) {
    return {
      'type': 'datefield',
      'value': value,
      'onChange': onChange,
      if (label != null) 'label': label,
      if (minDate != null) 'minDate': minDate,
      if (maxDate != null) 'maxDate': maxDate,
      'format': format,
      if (placeholder != null) 'placeholder': placeholder,
    };
  }
  
  static Map<String, dynamic> timeField({
    required String value,
    required Map<String, dynamic> onChange,
    String? label,
    String format = 'HH:mm',
    bool use24HourFormat = true,
    String? placeholder,
  }) {
    return {
      'type': 'timefield',
      'value': value,
      'onChange': onChange,
      if (label != null) 'label': label,
      'format': format,
      'use24HourFormat': use24HourFormat,
      if (placeholder != null) 'placeholder': placeholder,
    };
  }
  
  static Map<String, dynamic> dateRangePicker({
    required String startDate,
    required String endDate,
    required Map<String, dynamic> onChange,
    String? label,
    String? minDate,
    String? maxDate,
    String format = 'yyyy-MM-dd',
  }) {
    return {
      'type': 'daterangepicker',
      'startDate': startDate,
      'endDate': endDate,
      'onChange': onChange,
      if (label != null) 'label': label,
      if (minDate != null) 'minDate': minDate,
      if (maxDate != null) 'maxDate': maxDate,
      'format': format,
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
      'type': 'dragtarget',
      'builder': builder,
      'onAccept': onAccept,
      if (onWillAccept != null) 'onWillAccept': onWillAccept,
      if (onLeave != null) 'onLeave': onLeave,
      if (onMove != null) 'onMove': onMove,
    };
  }
  
  // ===== List Widgets =====
  
  static Map<String, dynamic> listView({
    required String items,
    required Map<String, dynamic> itemTemplate,
    double itemSpacing = 0,
    bool shrinkWrap = false,
    String scrollDirection = 'vertical',
  }) {
    return {
      'type': 'listview',
      'items': items,
      'itemTemplate': itemTemplate,
      'itemSpacing': itemSpacing,
      'shrinkWrap': shrinkWrap,
      'scrollDirection': scrollDirection,
    };
  }
  
  static Map<String, dynamic> gridView({
    required String items,
    required Map<String, dynamic> itemTemplate,
    int crossAxisCount = 2,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    double childAspectRatio = 1,
  }) {
    return {
      'type': 'gridview',
      'items': items,
      'itemTemplate': itemTemplate,
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
    Map<String, dynamic>? onTap,
  }) {
    return {
      'type': 'listtile',
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (leading != null) 'leading': leading,
      if (trailing != null) 'trailing': trailing,
      if (onTap != null) 'onTap': onTap,
    };
  }
  
  // ===== Navigation Widgets =====
  
  static Map<String, dynamic> appBar({
    required String title,
    List<Map<String, dynamic>>? actions,
    Map<String, dynamic>? leading,
    double elevation = 4,
  }) {
    return {
      'type': 'appbar',
      'title': title,
      if (actions != null) 'actions': actions,
      if (leading != null) 'leading': leading,
      'elevation': elevation,
    };
  }
  
  static Map<String, dynamic> bottomNavigationBar({
    required List<Map<String, dynamic>> items,
    required int currentIndex,
    required Map<String, dynamic> onTap,
    String barType = 'fixed',
  }) {
    return {
      'type': 'bottomnavigationbar',
      'items': items,
      'currentIndex': currentIndex,
      'onTap': onTap,
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
    required Map<String, dynamic> onPressed,
    required Map<String, dynamic> child,
    String? tooltip,
  }) {
    return {
      'type': 'floatingactionbutton',
      'onPressed': onPressed,
      'child': child,
      if (tooltip != null) 'tooltip': tooltip,
    };
  }
  
  // ===== Action Builders =====
  
  static Map<String, dynamic> toolAction(
    String tool, {
    Map<String, dynamic>? args,
    Map<String, dynamic>? onSuccess,
    Map<String, dynamic>? onError,
  }) {
    return {
      'type': 'tool',
      'tool': tool,
      if (args != null) 'args': args,
      if (onSuccess != null) 'onSuccess': onSuccess,
      if (onError != null) 'onError': onError,
    };
  }
  
  static Map<String, dynamic> stateAction({
    required String action,
    required String binding,
    dynamic value,
  }) {
    return {
      'type': 'state',
      'action': action,
      'binding': binding,
      if (value != null) 'value': value,
    };
  }
  
  static Map<String, dynamic> navigationAction({
    required String action,
    String? route,
    Map<String, dynamic>? params,
  }) {
    return {
      'type': 'navigation',
      'action': action,
      if (route != null) 'route': route,
      if (params != null) 'params': params,
    };
  }
  
  static Map<String, dynamic> resourceAction({
    required String action,
    required String uri,
    String? binding,
  }) {
    return {
      'type': 'resource',
      'action': action,
      'uri': uri,
      if (binding != null) 'binding': binding,
    };
  }
  
  static Map<String, dynamic> batchAction({
    required List<Map<String, dynamic>> actions,
  }) {
    return {
      'type': 'batch',
      'actions': actions,
    };
  }
  
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
  
  /// Create theme colors
  static Map<String, dynamic> themeColors({
    String primary = '#2196F3',
    String secondary = '#FF4081',
    String background = '#FFFFFF',
    String surface = '#F5F5F5',
    String error = '#F44336',
    String onPrimary = '#FFFFFF',
    String onSecondary = '#000000',
    String onBackground = '#000000',
    String onSurface = '#000000',
    String onError = '#FFFFFF',
  }) {
    return {
      'primary': primary,
      'secondary': secondary,
      'background': background,
      'surface': surface,
      'error': error,
      'onPrimary': onPrimary,
      'onSecondary': onSecondary,
      'onBackground': onBackground,
      'onSurface': onSurface,
      'onError': onError,
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
      'body1': body1 ?? {'fontSize': 16, 'fontWeight': 'normal', 'letterSpacing': 0.5},
      'body2': body2 ?? {'fontSize': 14, 'fontWeight': 'normal', 'letterSpacing': 0.25},
      'caption': caption ?? {'fontSize': 12, 'fontWeight': 'normal', 'letterSpacing': 0.4},
      'button': button ?? {'fontSize': 14, 'fontWeight': 'medium', 'letterSpacing': 1.25, 'textTransform': 'uppercase'},
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
  
  /// Generate JSON file
  static void generateJsonFile(
    Map<String, dynamic> definition,
    String filename,
  ) {
    final jsonString = toPrettyJson(definition);
    File(filename).writeAsStringSync(jsonString);
  }
  
  /// Create binding expression
  static String binding(String path) => '{{$path}}';
  
  /// Create theme binding expression
  static String themeBinding(String path) => '{{theme.$path}}';
  
  /// Create conditional expression
  static String conditional(String condition, String ifTrue, String ifFalse) {
    return '{{$condition ? $ifTrue : $ifFalse}}';
  }
  
  // ===== Theme Binding Helpers =====
  
  /// Get theme color binding
  static String themeColor(String colorName) => themeBinding('colors.$colorName');
  
  /// Get theme typography binding
  static String themeTypographyProperty(String style, String property) => 
      themeBinding('typography.$style.$property');
  
  /// Get theme spacing binding
  static String themeSpacingValue(String size) => themeBinding('spacing.$size');
  
  /// Get theme border radius binding
  static String themeBorderRadiusValue(String size) => themeBinding('borderRadius.$size');
  
  /// Get theme elevation binding
  static String themeElevationValue(String level) => themeBinding('elevation.$level');
  
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