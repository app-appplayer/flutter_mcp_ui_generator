import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('MCPUIJsonGenerator - Comprehensive Tests', () {
    group('Display Widgets', () {
      test('should create text with all properties', () {
        final text = MCPUIJsonGenerator.text(
          'Hello World',
          style: {'fontSize': 20},
          textAlign: 'center',
          maxLines: 2,
          overflow: 'ellipsis',
        );

        expect(text['type'], 'text');
        expect(text['value'], 'Hello World');
        expect(text['style'], {'fontSize': 20});
        expect(text['textAlign'], 'center');
        expect(text['maxLines'], 2);
        expect(text['overflow'], 'ellipsis');
      });

      test('should create text with minimal properties', () {
        final text = MCPUIJsonGenerator.text('Simple Text');

        expect(text['type'], 'text');
        expect(text['value'], 'Simple Text');
        expect(text.length, 2);
      });

      test('should create image with all properties', () {
        final image = MCPUIJsonGenerator.image(
          src: 'https://example.com/image.png',
          width: 200,
          height: 150,
          fit: 'contain',
        );

        expect(image['type'], 'image');
        expect(image['src'], 'https://example.com/image.png');
        expect(image['width'], 200);
        expect(image['height'], 150);
        expect(image['fit'], 'contain');
      });

      test('should create icon with properties', () {
        final icon = MCPUIJsonGenerator.icon(
          icon: 'home',
          size: 32,
          color: '#FF0000',
        );

        expect(icon['type'], 'icon');
        expect(icon['icon'], 'home');
        expect(icon['size'], 32);
        expect(icon['color'], '#FF0000');
      });

      test('should create card with all properties', () {
        final card = MCPUIJsonGenerator.card(
          child: {'type': 'text', 'value': 'Card Content'},
          elevation: 4,
          margin: {'all': 8},
          shape: {'borderRadius': 12},
        );

        expect(card['type'], 'card');
        expect(card['child'], isNotNull);
        expect(card['elevation'], 4);
        expect(card['margin'], {'all': 8});
        expect(card['shape'], {'borderRadius': 12});
      });

      test('should create divider with all properties', () {
        final divider = MCPUIJsonGenerator.divider(
          thickness: 2,
          color: '#CCCCCC',
          indent: 16,
          endIndent: 16,
        );

        expect(divider['type'], 'divider');
        expect(divider['thickness'], 2);
        expect(divider['color'], '#CCCCCC');
        expect(divider['indent'], 16);
        expect(divider['endIndent'], 16);
      });
    });

    group('Input Widgets', () {
      test('should create button with all properties', () {
        final button = MCPUIJsonGenerator.button(
          label: 'Click Me',
          onTap: {'type': 'tool', 'tool': 'handleClick'},
          style: 'outlined',
          icon: 'send',
          disabled: true,
        );

        expect(button['type'], 'button');
        expect(button['label'], 'Click Me');
        expect(button['onTap'], isNotNull);
        expect(button['style'], 'outlined');
        expect(button['icon'], 'send');
        expect(button['disabled'], true);
      });

      test('should create textField with all properties', () {
        final textField = MCPUIJsonGenerator.textField(
          label: 'Username',
          value: '{{username}}',
          onChange: {'type': 'state', 'action': 'set'},
          placeholder: 'Enter username',
          helperText: 'Your unique username',
          errorText: 'Username is required',
          obscureText: true,
          maxLines: 1,
        );

        expect(textField['type'], 'textfield');
        expect(textField['label'], 'Username');
        expect(textField['value'], '{{username}}');
        expect(textField['onChange'], isNotNull);
        expect(textField['placeholder'], 'Enter username');
        expect(textField['helperText'], 'Your unique username');
        expect(textField['errorText'], 'Username is required');
        expect(textField['obscureText'], true);
        expect(textField['maxLines'], 1);
      });

      test('should create checkbox with properties', () {
        final checkbox = MCPUIJsonGenerator.checkbox(
          value: '{{isChecked}}',
          onChange: {'type': 'state', 'action': 'toggle'},
          label: 'Agree to terms',
        );

        expect(checkbox['type'], 'checkbox');
        expect(checkbox['value'], '{{isChecked}}');
        expect(checkbox['onChange'], isNotNull);
        expect(checkbox['label'], 'Agree to terms');
      });

      test('should create switch with properties', () {
        final switchWidget = MCPUIJsonGenerator.switchWidget(
          value: '{{isEnabled}}',
          onChange: {'type': 'state', 'action': 'toggle'},
          label: 'Enable notifications',
        );

        expect(switchWidget['type'], 'switch');
        expect(switchWidget['value'], '{{isEnabled}}');
        expect(switchWidget['onChange'], isNotNull);
        expect(switchWidget['label'], 'Enable notifications');
      });

      test('should create slider with all properties', () {
        final slider = MCPUIJsonGenerator.slider(
          value: '{{sliderValue}}',
          onChange: {'type': 'state', 'action': 'set'},
          min: 0,
          max: 100,
          divisions: 10,
          label: 'Volume',
        );

        expect(slider['type'], 'slider');
        expect(slider['value'], '{{sliderValue}}');
        expect(slider['onChange'], isNotNull);
        expect(slider['min'], 0);
        expect(slider['max'], 100);
        expect(slider['divisions'], 10);
        expect(slider['label'], 'Volume');
      });

      test('should create dropdown with all properties', () {
        final dropdown = MCPUIJsonGenerator.dropdown(
          value: '{{selectedValue}}',
          items: [
            {'value': '1', 'label': 'Option 1'},
            {'value': '2', 'label': 'Option 2'},
          ],
          onChange: {'type': 'state', 'action': 'set'},
          label: 'Select Option',
          placeholder: 'Choose one',
        );

        expect(dropdown['type'], 'dropdown');
        expect(dropdown['value'], '{{selectedValue}}');
        expect(dropdown['items'].length, 2);
        expect(dropdown['onChange'], isNotNull);
        expect(dropdown['label'], 'Select Option');
        expect(dropdown['placeholder'], 'Choose one');
      });
    });

    group('List Widgets', () {
      test('should create listView with all properties', () {
        final listView = MCPUIJsonGenerator.listView(
          items: '{{items}}',
          itemTemplate: {'type': 'text', 'value': '{{item.name}}'},
          itemSpacing: 8,
          shrinkWrap: true,
          scrollDirection: 'horizontal',
        );

        expect(listView['type'], 'listview');
        expect(listView['items'], '{{items}}');
        expect(listView['itemTemplate'], isNotNull);
        expect(listView['itemSpacing'], 8);
        expect(listView['shrinkWrap'], true);
        expect(listView['scrollDirection'], 'horizontal');
      });

      test('should create gridView with all properties', () {
        final gridView = MCPUIJsonGenerator.gridView(
          items: '{{products}}',
          itemTemplate: {'type': 'card', 'child': {'type': 'text'}},
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
        );

        expect(gridView['type'], 'gridview');
        expect(gridView['items'], '{{products}}');
        expect(gridView['itemTemplate'], isNotNull);
        expect(gridView['crossAxisCount'], 3);
        expect(gridView['mainAxisSpacing'], 16);
        expect(gridView['crossAxisSpacing'], 16);
        expect(gridView['childAspectRatio'], 0.75);
      });

      test('should create listTile with all properties', () {
        final listTile = MCPUIJsonGenerator.listTile(
          title: 'Item Title',
          subtitle: 'Item subtitle',
          leading: {'type': 'icon', 'icon': 'folder'},
          trailing: {'type': 'icon', 'icon': 'arrow_forward'},
          onTap: {'type': 'navigation', 'action': 'push'},
        );

        expect(listTile['type'], 'listtile');
        expect(listTile['title'], 'Item Title');
        expect(listTile['subtitle'], 'Item subtitle');
        expect(listTile['leading'], isNotNull);
        expect(listTile['trailing'], isNotNull);
        expect(listTile['onTap'], isNotNull);
      });

      test('should create listTile with minimal properties', () {
        final listTile = MCPUIJsonGenerator.listTile();

        expect(listTile['type'], 'listtile');
        expect(listTile.length, 1);
      });
    });

    group('Navigation Widgets', () {
      test('should create appBar with all properties', () {
        final appBar = MCPUIJsonGenerator.appBar(
          title: 'My App',
          actions: [
            {'type': 'icon', 'icon': 'search'},
            {'type': 'icon', 'icon': 'more_vert'},
          ],
          leading: {'type': 'icon', 'icon': 'menu'},
          elevation: 8,
        );

        expect(appBar['type'], 'appbar');
        expect(appBar['title'], 'My App');
        expect(appBar['actions'].length, 2);
        expect(appBar['leading'], isNotNull);
        expect(appBar['elevation'], 8);
      });

      test('should create bottomNavigationBar with all properties', () {
        final bottomNav = MCPUIJsonGenerator.bottomNavigationBar(
          items: [
            {'icon': 'home', 'label': 'Home'},
            {'icon': 'search', 'label': 'Search'},
          ],
          currentIndex: 0,
          onTap: {'type': 'state', 'action': 'set'},
          barType: 'shifting',
        );

        expect(bottomNav['type'], 'bottomnavigationbar');
        expect(bottomNav['items'].length, 2);
        expect(bottomNav['currentIndex'], 0);
        expect(bottomNav['onTap'], isNotNull);
        expect(bottomNav['barType'], 'shifting');
      });

      test('should create drawer', () {
        final drawer = MCPUIJsonGenerator.drawer(
          child: {'type': 'column', 'children': []},
        );

        expect(drawer['type'], 'drawer');
        expect(drawer['child'], isNotNull);
      });

      test('should create floatingActionButton with all properties', () {
        final fab = MCPUIJsonGenerator.floatingActionButton(
          onPressed: {'type': 'tool', 'tool': 'addItem'},
          child: {'type': 'icon', 'icon': 'add'},
          tooltip: 'Add new item',
        );

        expect(fab['type'], 'floatingactionbutton');
        expect(fab['onPressed'], isNotNull);
        expect(fab['child'], isNotNull);
        expect(fab['tooltip'], 'Add new item');
      });
    });

    group('Action Builders', () {
      test('should create tool action with all properties', () {
        final action = MCPUIJsonGenerator.toolAction(
          'submitForm',
          args: {'name': '{{name}}', 'email': '{{email}}'},
          onSuccess: {'type': 'navigation', 'action': 'push'},
          onError: {'type': 'state', 'action': 'set'},
        );

        expect(action['type'], 'tool');
        expect(action['tool'], 'submitForm');
        expect(action['args'], isNotNull);
        expect(action['onSuccess'], isNotNull);
        expect(action['onError'], isNotNull);
      });

      test('should create tool action with minimal properties', () {
        final action = MCPUIJsonGenerator.toolAction('refresh');

        expect(action['type'], 'tool');
        expect(action['tool'], 'refresh');
        expect(action.containsKey('args'), false);
        expect(action.containsKey('onSuccess'), false);
        expect(action.containsKey('onError'), false);
      });

      test('should create state action with all properties', () {
        final action = MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'username',
          value: 'John Doe',
        );

        expect(action['type'], 'state');
        expect(action['action'], 'set');
        expect(action['binding'], 'username');
        expect(action['value'], 'John Doe');
      });

      test('should create state action without value', () {
        final action = MCPUIJsonGenerator.stateAction(
          action: 'toggle',
          binding: 'isEnabled',
        );

        expect(action['type'], 'state');
        expect(action['action'], 'toggle');
        expect(action['binding'], 'isEnabled');
        expect(action.containsKey('value'), false);
      });

      test('should create navigation action with all properties', () {
        final action = MCPUIJsonGenerator.navigationAction(
          action: 'push',
          route: '/details',
          params: {'id': '123', 'name': 'Item'},
        );

        expect(action['type'], 'navigation');
        expect(action['action'], 'push');
        expect(action['route'], '/details');
        expect(action['params'], {'id': '123', 'name': 'Item'});
      });

      test('should create navigation action without route', () {
        final action = MCPUIJsonGenerator.navigationAction(
          action: 'pop',
        );

        expect(action['type'], 'navigation');
        expect(action['action'], 'pop');
        expect(action.containsKey('route'), false);
        expect(action.containsKey('params'), false);
      });

      test('should create resource action with all properties', () {
        final action = MCPUIJsonGenerator.resourceAction(
          action: 'subscribe',
          uri: 'data://temperature',
          binding: 'currentTemp',
        );

        expect(action['type'], 'resource');
        expect(action['action'], 'subscribe');
        expect(action['uri'], 'data://temperature');
        expect(action['binding'], 'currentTemp');
      });

      test('should create resource action without binding', () {
        final action = MCPUIJsonGenerator.resourceAction(
          action: 'unsubscribe',
          uri: 'data://temperature',
        );

        expect(action['type'], 'resource');
        expect(action['action'], 'unsubscribe');
        expect(action['uri'], 'data://temperature');
        expect(action.containsKey('binding'), false);
      });

      test('should create batch action', () {
        final action = MCPUIJsonGenerator.batchAction(
          actions: [
            {'type': 'state', 'action': 'set'},
            {'type': 'tool', 'tool': 'save'},
          ],
        );

        expect(action['type'], 'batch');
        expect(action['actions'].length, 2);
      });

      test('should create conditional action with else', () {
        final action = MCPUIJsonGenerator.conditionalAction(
          condition: '{{isLoggedIn}}',
          then: {'type': 'navigation', 'action': 'push', 'route': '/home'},
          orElse: {'type': 'navigation', 'action': 'push', 'route': '/login'},
        );

        expect(action['type'], 'conditional');
        expect(action['condition'], '{{isLoggedIn}}');
        expect(action['then'], isNotNull);
        expect(action['else'], isNotNull);
      });

      test('should create conditional action without else', () {
        final action = MCPUIJsonGenerator.conditionalAction(
          condition: '{{hasData}}',
          then: {'type': 'state', 'action': 'set'},
        );

        expect(action['type'], 'conditional');
        expect(action['condition'], '{{hasData}}');
        expect(action['then'], isNotNull);
        expect(action.containsKey('else'), false);
      });
    });

    group('Style Builders', () {
      test('should create textStyle with all properties', () {
        final style = MCPUIJsonGenerator.textStyle(
          fontSize: 16,
          fontWeight: 'bold',
          fontStyle: 'italic',
          color: '#FF0000',
          letterSpacing: 1.2,
          wordSpacing: 2.0,
          height: 1.5,
          decoration: 'underline',
        );

        expect(style['fontSize'], 16);
        expect(style['fontWeight'], 'bold');
        expect(style['fontStyle'], 'italic');
        expect(style['color'], '#FF0000');
        expect(style['letterSpacing'], 1.2);
        expect(style['wordSpacing'], 2.0);
        expect(style['height'], 1.5);
        expect(style['decoration'], 'underline');
      });

      test('should create textStyle with minimal properties', () {
        final style = MCPUIJsonGenerator.textStyle(fontSize: 14);

        expect(style['fontSize'], 14);
        expect(style.length, 1);
      });

      test('should create empty textStyle', () {
        final style = MCPUIJsonGenerator.textStyle();

        expect(style, {});
      });

      test('should create edgeInsets with all', () {
        final insets = MCPUIJsonGenerator.edgeInsets(all: 16);

        expect(insets, {'all': 16});
      });

      test('should create edgeInsets with horizontal and vertical', () {
        final insets = MCPUIJsonGenerator.edgeInsets(
          horizontal: 20,
          vertical: 10,
        );

        expect(insets['horizontal'], 20);
        expect(insets['vertical'], 10);
      });

      test('should create edgeInsets with individual values', () {
        final insets = MCPUIJsonGenerator.edgeInsets(
          left: 10,
          top: 20,
          right: 30,
          bottom: 40,
        );

        expect(insets['left'], 10);
        expect(insets['top'], 20);
        expect(insets['right'], 30);
        expect(insets['bottom'], 40);
      });

      test('should create empty edgeInsets', () {
        final insets = MCPUIJsonGenerator.edgeInsets();

        expect(insets, {});
      });

      test('should create decoration with all properties', () {
        final decoration = MCPUIJsonGenerator.decoration(
          color: '#FFFFFF',
          borderRadius: 8,
          border: {'color': '#000000', 'width': 1},
          boxShadow: [{'color': '#888888', 'blur': 4}],
          gradient: {'type': 'linear', 'colors': ['#FF0000', '#00FF00']},
        );

        expect(decoration['color'], '#FFFFFF');
        expect(decoration['borderRadius'], 8);
        expect(decoration['border'], isNotNull);
        expect(decoration['boxShadow'], isNotNull);
        expect(decoration['gradient'], isNotNull);
      });

      test('should create border with all properties', () {
        final border = MCPUIJsonGenerator.border(
          color: '#FF0000',
          width: 2,
          style: 'dashed',
        );

        expect(border['color'], '#FF0000');
        expect(border['width'], 2);
        expect(border['style'], 'dashed');
      });

      test('should create border with defaults', () {
        final border = MCPUIJsonGenerator.border();

        expect(border['width'], 1);
        expect(border['style'], 'solid');
        expect(border.containsKey('color'), false);
      });
    });

    group('Helper Methods', () {
      test('should convert to pretty JSON', () {
        final widget = {'type': 'text', 'value': 'Hello'};
        final json = MCPUIJsonGenerator.toPrettyJson(widget);

        expect(json.contains('{\n'), true);
        expect(json.contains('"type": "text"'), true);
        expect(json.contains('"value": "Hello"'), true);
      });

      test('should generate JSON file', () {
        final testFile = 'test_output.json';
        final widget = {'type': 'text', 'value': 'Test'};

        MCPUIJsonGenerator.generateJsonFile(widget, testFile);

        final file = File(testFile);
        expect(file.existsSync(), true);

        final content = file.readAsStringSync();
        expect(content.contains('"type": "text"'), true);

        // Cleanup
        file.deleteSync();
      });

      test('should create binding expression', () {
        final binding = MCPUIJsonGenerator.binding('user.name');

        expect(binding, '{{user.name}}');
      });

      test('should create conditional expression', () {
        final conditional = MCPUIJsonGenerator.conditional(
          'isLoggedIn',
          'Welcome',
          'Please login',
        );

        expect(conditional, '{{isLoggedIn ? Welcome : Please login}}');
      });
    });
  });
}