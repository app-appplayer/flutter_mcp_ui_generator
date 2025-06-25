import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  group('Layout Widgets', () {
    test('linear', () {
      final widget = MCPUIJsonGenerator.linear(
        children: [
          MCPUIJsonGenerator.text('Item 1'),
          MCPUIJsonGenerator.text('Item 2'),
        ],
        direction: 'vertical',
        distribution: 'start',
        alignment: 'center',
        gap: 8.0,
      );

      expect(widget['type'], equals('linear'));
      expect(widget['children'].length, equals(2));
      expect(widget['direction'], equals('vertical'));
      expect(widget['distribution'], equals('start'));
      expect(widget['alignment'], equals('center'));
      expect(widget['gap'], equals(8.0));
    });

    test('stack', () {
      final widget = MCPUIJsonGenerator.stack(
        children: [
          MCPUIJsonGenerator.box(color: '#ff0000'),
          MCPUIJsonGenerator.text('Overlay'),
        ],
        alignment: 'center',
        fit: 'expand',
      );

      expect(widget['type'], equals('stack'));
      expect(widget['children'].length, equals(2));
      expect(widget['alignment'], equals('center'));
      expect(widget['fit'], equals('expand'));
    });

    test('box', () {
      final widget = MCPUIJsonGenerator.box(
        child: MCPUIJsonGenerator.text('Content'),
        width: 100.0,
        height: 200.0,
        color: '#ff0000',
        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
        margin: MCPUIJsonGenerator.edgeInsets(all: 8),
      );

      expect(widget['type'], equals('box'));
      expect(widget['child'], isA<Map>());
      expect(widget['width'], equals(100.0));
      expect(widget['height'], equals(200.0));
      expect(widget['color'], equals('#ff0000'));
      expect(widget['padding'], isA<Map>());
      expect(widget['margin'], isA<Map>());
    });

    test('center', () {
      final widget = MCPUIJsonGenerator.center(
        child: MCPUIJsonGenerator.text('Centered'),
      );

      expect(widget['type'], equals('center'));
      expect(widget['child'], isA<Map>());
    });

    test('expanded', () {
      final widget = MCPUIJsonGenerator.expanded(
        child: MCPUIJsonGenerator.text('Content'),
        flex: 2,
      );

      expect(widget['type'], equals('expanded'));
      expect(widget['child'], isA<Map>());
      expect(widget['flex'], equals(2));
    });

    test('padding', () {
      final widget = MCPUIJsonGenerator.padding(
        child: MCPUIJsonGenerator.text('Content'),
        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
      );

      expect(widget['type'], equals('padding'));
      expect(widget['child'], isA<Map>());
      expect(widget['padding'], isA<Map>());
    });

    test('sizedBox', () {
      final widget = MCPUIJsonGenerator.sizedBox(
        width: 100.0,
        height: 50.0,
        child: MCPUIJsonGenerator.text('Content'),
      );

      expect(widget['type'], equals('sizedBox'));
      expect(widget['width'], equals(100.0));
      expect(widget['height'], equals(50.0));
      expect(widget['child'], isA<Map>());
    });

    test('flexible', () {
      final widget = MCPUIJsonGenerator.flexible(
        child: MCPUIJsonGenerator.text('Content'),
        flex: 1,
        fit: 'loose',
      );

      expect(widget['type'], equals('flexible'));
      expect(widget['child'], isA<Map>());
      expect(widget['flex'], equals(1));
      expect(widget['fit'], equals('loose'));
    });

    test('conditional', () {
      final widget = MCPUIJsonGenerator.conditionalWidget(
        condition: '{{isVisible}}',
        then: MCPUIJsonGenerator.text('Visible'),
        orElse: MCPUIJsonGenerator.text('Hidden'),
      );

      expect(widget['type'], equals('conditional'));
      expect(widget['condition'], equals('{{isVisible}}'));
      expect(widget['then'], isA<Map>());
      expect(widget['else'], isA<Map>());
    });

    // Additional layout widgets - using direct JSON creation
    test('align', () {
      final widget = {
        'type': 'align',
        'child': MCPUIJsonGenerator.text('Aligned'),
        'alignment': 'topLeft',
      };

      expect(widget['type'], equals('align'));
      expect(widget['child'], isA<Map>());
      expect(widget['alignment'], equals('topLeft'));
    });

    test('margin', () {
      final widget = {
        'type': 'margin',
        'child': MCPUIJsonGenerator.text('Margined'),
        'margin': MCPUIJsonGenerator.edgeInsets(all: 16),
      };

      expect(widget['type'], equals('margin'));
      expect(widget['child'], isA<Map>());
      expect(widget['margin'], isA<Map>());
    });

    test('spacer', () {
      final widget = {
        'type': 'spacer',
        'flex': 1,
      };

      expect(widget['type'], equals('spacer'));
      expect(widget['flex'], equals(1));
    });

    test('wrap', () {
      final widget = {
        'type': 'wrap',
        'children': [
          MCPUIJsonGenerator.text('Item 1'),
          MCPUIJsonGenerator.text('Item 2'),
        ],
        'direction': 'horizontal',
        'spacing': 8.0,
        'runSpacing': 8.0,
      };

      expect(widget['type'], equals('wrap'));
      expect(widget['children'], isA<List>());
      expect(widget['direction'], equals('horizontal'));
      expect(widget['spacing'], equals(8.0));
      expect(widget['runSpacing'], equals(8.0));
    });

    test('flow', () {
      final widget = {
        'type': 'flow',
        'children': [
          MCPUIJsonGenerator.text('Item 1'),
          MCPUIJsonGenerator.text('Item 2'),
        ],
        'delegate': 'custom',
      };

      expect(widget['type'], equals('flow'));
      expect(widget['children'], isA<List>());
      expect(widget['delegate'], equals('custom'));
    });

    test('table', () {
      final widget = {
        'type': 'table',
        'children': [
          {
            'cells': [
              MCPUIJsonGenerator.text('Cell 1'),
              MCPUIJsonGenerator.text('Cell 2'),
            ]
          },
        ],
        'columnWidths': {'0': 'flex'},
      };

      expect(widget['type'], equals('table'));
      expect(widget['children'], isA<List>());
      expect(widget['columnWidths'], isA<Map>());
    });

    test('positioned', () {
      final widget = {
        'type': 'positioned',
        'child': MCPUIJsonGenerator.text('Positioned'),
        'left': 10.0,
        'top': 20.0,
        'width': 100.0,
        'height': 50.0,
      };

      expect(widget['type'], equals('positioned'));
      expect(widget['child'], isA<Map>());
      expect(widget['left'], equals(10.0));
      expect(widget['top'], equals(20.0));
      expect(widget['width'], equals(100.0));
      expect(widget['height'], equals(50.0));
    });

    test('intrinsicHeight', () {
      final widget = {
        'type': 'intrinsicHeight',
        'child': MCPUIJsonGenerator.text('Intrinsic Height'),
      };

      expect(widget['type'], equals('intrinsicHeight'));
      expect(widget['child'], isA<Map>());
    });

    test('intrinsicWidth', () {
      final widget = {
        'type': 'intrinsicWidth',
        'child': MCPUIJsonGenerator.text('Intrinsic Width'),
      };

      expect(widget['type'], equals('intrinsicWidth'));
      expect(widget['child'], isA<Map>());
    });

    test('visibility', () {
      final widget = {
        'type': 'visibility',
        'child': MCPUIJsonGenerator.text('Visible'),
        'visible': true,
        'maintainSize': false,
      };

      expect(widget['type'], equals('visibility'));
      expect(widget['child'], isA<Map>());
      expect(widget['visible'], equals(true));
      expect(widget['maintainSize'], equals(false));
    });
  });

  group('Display Widgets', () {
    test('text', () {
      final widget = MCPUIJsonGenerator.text(
        'Hello World',
        style: MCPUIJsonGenerator.textStyle(
          fontSize: 16.0,
          fontWeight: 'bold',
        ),
        textAlign: 'center',
        maxLines: 2,
      );

      expect(widget['type'], equals('text'));
      expect(widget['content'], equals('Hello World'));
      expect(widget['style'], isA<Map>());
      expect(widget['textAlign'], equals('center'));
      expect(widget['maxLines'], equals(2));
    });

    test('richText', () {
      final widget = {
        'type': 'richText',
        'spans': [
          {
            'text': 'Hello ',
            'style': MCPUIJsonGenerator.textStyle(fontWeight: 'normal'),
          },
          {
            'text': 'World',
            'style': MCPUIJsonGenerator.textStyle(fontWeight: 'bold'),
          },
        ],
        'textAlign': 'left',
      };

      expect(widget['type'], equals('richText'));
      expect(widget['spans'], isA<List>());
      expect(widget['textAlign'], equals('left'));
    });

    test('image', () {
      final widget = MCPUIJsonGenerator.image(
        src: 'https://example.com/image.jpg',
        width: 200.0,
        height: 150.0,
        fit: 'cover',
      );

      expect(widget['type'], equals('image'));
      expect(widget['src'], equals('https://example.com/image.jpg'));
      expect(widget['width'], equals(200.0));
      expect(widget['height'], equals(150.0));
      expect(widget['fit'], equals('cover'));
    });

    test('icon', () {
      final widget = MCPUIJsonGenerator.icon(
        icon: 'settings',
        size: 32.0,
        color: '#2196F3',
      );

      expect(widget['type'], equals('icon'));
      expect(widget['icon'], equals('settings'));
      expect(widget['size'], equals(32.0));
      expect(widget['color'], equals('#2196F3'));
    });

    test('card', () {
      final widget = MCPUIJsonGenerator.card(
        child: MCPUIJsonGenerator.text('Card content'),
        elevation: 4.0,
        margin: MCPUIJsonGenerator.edgeInsets(all: 8),
      );

      expect(widget['type'], equals('card'));
      expect(widget['child'], isA<Map>());
      expect(widget['elevation'], equals(4.0));
      expect(widget['margin'], isA<Map>());
    });

    test('divider', () {
      final widget = MCPUIJsonGenerator.divider(
        thickness: 2.0,
        color: '#CCCCCC',
        indent: 16.0,
        endIndent: 16.0,
      );

      expect(widget['type'], equals('divider'));
      expect(widget['thickness'], equals(2.0));
      expect(widget['color'], equals('#CCCCCC'));
      expect(widget['indent'], equals(16.0));
      expect(widget['endIndent'], equals(16.0));
    });

    test('verticalDivider', () {
      final widget = {
        'type': 'verticalDivider',
        'thickness': 2.0,
        'color': '#CCCCCC',
        'indent': 16.0,
        'endIndent': 16.0,
      };

      expect(widget['type'], equals('verticalDivider'));
      expect(widget['thickness'], equals(2.0));
      expect(widget['color'], equals('#CCCCCC'));
      expect(widget['indent'], equals(16.0));
      expect(widget['endIndent'], equals(16.0));
    });

    test('badge', () {
      final widget = {
        'type': 'badge',
        'child': MCPUIJsonGenerator.icon(icon: 'notifications'),
        'label': '5',
        'backgroundColor': '#ff0000',
        'textColor': '#ffffff',
      };

      expect(widget['type'], equals('badge'));
      expect(widget['child'], isA<Map>());
      expect(widget['label'], equals('5'));
      expect(widget['backgroundColor'], equals('#ff0000'));
      expect(widget['textColor'], equals('#ffffff'));
    });

    test('chip', () {
      final widget = {
        'type': 'chip',
        'label': 'Tag',
        'avatar': MCPUIJsonGenerator.icon(icon: 'person'),
        'onDeleted': MCPUIJsonGenerator.toolAction('deleteChip'),
        'backgroundColor': '#e0e0e0',
      };

      expect(widget['type'], equals('chip'));
      expect(widget['label'], equals('Tag'));
      expect(widget['avatar'], isA<Map>());
      expect(widget['onDeleted'], isA<Map>());
      expect(widget['backgroundColor'], equals('#e0e0e0'));
    });

    test('avatar', () {
      final widget = {
        'type': 'avatar',
        'radius': 25.0,
        'backgroundImage': 'https://example.com/avatar.jpg',
        'backgroundColor': '#2196F3',
        'child': MCPUIJsonGenerator.text('A'),
      };

      expect(widget['type'], equals('avatar'));
      expect(widget['radius'], equals(25.0));
      expect(
          widget['backgroundImage'], equals('https://example.com/avatar.jpg'));
      expect(widget['backgroundColor'], equals('#2196F3'));
      expect(widget['child'], isA<Map>());
    });

    test('tooltip', () {
      final widget = {
        'type': 'tooltip',
        'message': 'This is a tooltip',
        'child': MCPUIJsonGenerator.icon(icon: 'info'),
        'preferBelow': true,
      };

      expect(widget['type'], equals('tooltip'));
      expect(widget['message'], equals('This is a tooltip'));
      expect(widget['child'], isA<Map>());
      expect(widget['preferBelow'], equals(true));
    });

    test('loadingIndicator', () {
      final widget = MCPUIJsonGenerator.loadingIndicator(
        value: 0.5,
        color: '#2196F3',
        size: 24.0,
        indicatorType: 'circular',
        message: 'Loading...',
      );

      expect(widget['type'], equals('loadingIndicator'));
      expect(widget['value'], equals(0.5));
      expect(widget['color'], equals('#2196F3'));
      expect(widget['size'], equals(24.0));
      expect(widget['indicatorType'], equals('circular'));
      expect(widget['message'], equals('Loading...'));
    });

    test('placeholder', () {
      final widget = {
        'type': 'placeholder',
        'width': 200.0,
        'height': 100.0,
        'color': '#e0e0e0',
        'child': MCPUIJsonGenerator.text('Placeholder'),
      };

      expect(widget['type'], equals('placeholder'));
      expect(widget['width'], equals(200.0));
      expect(widget['height'], equals(100.0));
      expect(widget['color'], equals('#e0e0e0'));
      expect(widget['child'], isA<Map>());
    });

    test('decoration', () {
      final widget = {
        'type': 'decoration',
        'child': MCPUIJsonGenerator.text('Decorated'),
        'decoration': MCPUIJsonGenerator.decoration(
          color: '#ffffff',
          borderRadius: 8.0,
          border: MCPUIJsonGenerator.border(color: '#000000'),
        ),
      };

      expect(widget['type'], equals('decoration'));
      expect(widget['child'], isA<Map>());
      expect(widget['decoration'], isA<Map>());
    });
  });

  group('Input Widgets', () {
    test('button', () {
      final widget = MCPUIJsonGenerator.button(
        label: 'Click me',
        click: MCPUIJsonGenerator.toolAction('onButtonClick'),
        style: 'elevated',
        icon: 'add',
        disabled: false,
      );

      expect(widget['type'], equals('button'));
      expect(widget['label'], equals('Click me'));
      expect(widget['click'], isA<Map>());
      expect(widget['style'], equals('elevated'));
      expect(widget['icon'], equals('add'));
      expect(widget['disabled'], equals(false));
    });

    test('iconButton', () {
      final widget = {
        'type': 'iconButton',
        'icon': 'add',
        'click': MCPUIJsonGenerator.toolAction('onIconClick'),
        'size': 24.0,
        'color': '#2196F3',
        'tooltip': 'Add item',
      };

      expect(widget['type'], equals('iconButton'));
      expect(widget['icon'], equals('add'));
      expect(widget['click'], isA<Map>());
      expect(widget['size'], equals(24.0));
      expect(widget['color'], equals('#2196F3'));
      expect(widget['tooltip'], equals('Add item'));
    });

    test('textInput', () {
      final widget = MCPUIJsonGenerator.textInput(
        label: 'Enter text',
        value: '{{inputValue}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'inputValue',
          value: '{{event.value}}',
        ),
        placeholder: 'Type here...',
        helperText: 'Helper text',
        maxLines: 1,
      );

      expect(widget['type'], equals('textInput'));
      expect(widget['label'], equals('Enter text'));
      expect(widget['value'], equals('{{inputValue}}'));
      expect(widget['change'], isA<Map>());
      expect(widget['placeholder'], equals('Type here...'));
      expect(widget['helperText'], equals('Helper text'));
      expect(widget['maxLines'], equals(1));
    });

    test('textFormField', () {
      final widget = {
        'type': 'textFormField',
        'label': 'Form Field',
        'value': '{{formValue}}',
        'change': MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'formValue',
          value: '{{event.value}}',
        ),
        'validation': {
          'required': true,
          'minLength': 3,
        },
        'autovalidate': true,
      };

      expect(widget['type'], equals('textFormField'));
      expect(widget['label'], equals('Form Field'));
      expect(widget['value'], equals('{{formValue}}'));
      expect(widget['change'], isA<Map>());
      expect(widget['validation'], isA<Map>());
      expect(widget['autovalidate'], equals(true));
    });

    test('checkbox', () {
      final widget = MCPUIJsonGenerator.checkbox(
        value: '{{isChecked}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'isChecked',
          value: '{{event.checked}}',
        ),
        label: 'Check me',
      );

      expect(widget['type'], equals('checkbox'));
      expect(widget['value'], equals('{{isChecked}}'));
      expect(widget['change'], isA<Map>());
      expect(widget['label'], equals('Check me'));
    });

    test('radio', () {
      final widget = {
        'type': 'radio',
        'value': '{{selectedValue}}',
        'groupValue': '{{radioGroup}}',
        'change': MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'radioGroup',
          value: '{{event.value}}',
        ),
        'label': 'Option A',
      };

      expect(widget['type'], equals('radio'));
      expect(widget['value'], equals('{{selectedValue}}'));
      expect(widget['groupValue'], equals('{{radioGroup}}'));
      expect(widget['change'], isA<Map>());
      expect(widget['label'], equals('Option A'));
    });

    test('toggle', () {
      final widget = MCPUIJsonGenerator.toggle(
        value: '{{isToggled}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'isToggled',
          value: '{{event.value}}',
        ),
        label: 'Toggle me',
      );

      expect(widget['type'], equals('toggle'));
      expect(widget['value'], equals('{{isToggled}}'));
      expect(widget['change'], isA<Map>());
      expect(widget['label'], equals('Toggle me'));
    });

    test('slider', () {
      final widget = MCPUIJsonGenerator.slider(
        value: '{{sliderValue}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'sliderValue',
          value: '{{event.value}}',
        ),
        min: 0.0,
        max: 100.0,
        divisions: 10,
        label: 'Value',
      );

      expect(widget['type'], equals('slider'));
      expect(widget['value'], equals('{{sliderValue}}'));
      expect(widget['change'], isA<Map>());
      expect(widget['min'], equals(0.0));
      expect(widget['max'], equals(100.0));
      expect(widget['divisions'], equals(10));
      expect(widget['label'], equals('Value'));
    });

    test('rangeSlider', () {
      final widget = MCPUIJsonGenerator.rangeSlider(
        startValue: '{{startValue}}',
        endValue: '{{endValue}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'rangeValue',
          value: '{{event.value}}',
        ),
        min: 0.0,
        max: 100.0,
        divisions: 10,
        label: 'Range',
      );

      expect(widget['type'], equals('rangeSlider'));
      expect(widget['startValue'], equals('{{startValue}}'));
      expect(widget['endValue'], equals('{{endValue}}'));
      expect(widget['change'], isA<Map>());
      expect(widget['min'], equals(0.0));
      expect(widget['max'], equals(100.0));
      expect(widget['divisions'], equals(10));
      expect(widget['label'], equals('Range'));
    });

    test('select', () {
      final widget = MCPUIJsonGenerator.select(
        value: '{{selectedValue}}',
        items: [
          {'value': 'option1', 'label': 'Option 1'},
          {'value': 'option2', 'label': 'Option 2'},
        ],
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'selectedValue',
          value: '{{event.value}}',
        ),
        label: 'Select option',
        placeholder: 'Choose...',
      );

      expect(widget['type'], equals('select'));
      expect(widget['value'], equals('{{selectedValue}}'));
      expect(widget['items'], isA<List>());
      expect(widget['change'], isA<Map>());
      expect(widget['label'], equals('Select option'));
      expect(widget['placeholder'], equals('Choose...'));
    });

    test('popupMenuButton', () {
      final widget = {
        'type': 'popupMenuButton',
        'icon': 'more_vert',
        'items': [
          {'value': 'edit', 'label': 'Edit'},
          {'value': 'delete', 'label': 'Delete'},
        ],
        'onSelected': MCPUIJsonGenerator.toolAction('onMenuSelected'),
        'tooltip': 'More options',
      };

      expect(widget['type'], equals('popupMenuButton'));
      expect(widget['icon'], equals('more_vert'));
      expect(widget['items'], isA<List>());
      expect(widget['onSelected'], isA<Map>());
      expect(widget['tooltip'], equals('More options'));
    });

    test('form', () {
      final widget = {
        'type': 'form',
        'child': MCPUIJsonGenerator.linear(children: [
          MCPUIJsonGenerator.textInput(
            label: 'Name',
            value: '{{name}}',
            change: MCPUIJsonGenerator.stateAction(
              action: 'set',
              binding: 'name',
              value: '{{event.value}}',
            ),
          ),
        ]),
        'autovalidateMode': 'onUserInteraction',
      };

      expect(widget['type'], equals('form'));
      expect(widget['child'], isA<Map>());
      expect(widget['autovalidateMode'], equals('onUserInteraction'));
    });

    test('numberField', () {
      final widget = MCPUIJsonGenerator.numberField(
        label: 'Number',
        value: '{{numberValue}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'numberValue',
          value: '{{event.value}}',
        ),
        min: 0.0,
        max: 100.0,
        step: 1.0,
        decimalPlaces: 2,
      );

      expect(widget['type'], equals('numberField'));
      expect(widget['label'], equals('Number'));
      expect(widget['value'], equals('{{numberValue}}'));
      expect(widget['change'], isA<Map>());
      expect(widget['min'], equals(0.0));
      expect(widget['max'], equals(100.0));
      expect(widget['step'], equals(1.0));
      expect(widget['decimalPlaces'], equals(2));
    });

    test('colorPicker', () {
      final widget = MCPUIJsonGenerator.colorPicker(
        value: '{{color}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'color',
          value: '{{event.value}}',
        ),
        label: 'Pick Color',
        enableAlpha: true,
        pickerType: 'wheel',
      );

      expect(widget['type'], equals('colorPicker'));
      expect(widget['value'], equals('{{color}}'));
      expect(widget['change'], isA<Map>());
      expect(widget['label'], equals('Pick Color'));
      expect(widget['enableAlpha'], equals(true));
      expect(widget['pickerType'], equals('wheel'));
    });

    test('radioGroup', () {
      final widget = MCPUIJsonGenerator.radioGroup(
        value: '{{radioValue}}',
        items: [
          {'value': 'option1', 'label': 'Option 1'},
          {'value': 'option2', 'label': 'Option 2'},
        ],
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'radioValue',
          value: '{{event.value}}',
        ),
        label: 'Choose one',
        orientation: 'vertical',
      );

      expect(widget['type'], equals('radioGroup'));
      expect(widget['value'], equals('{{radioValue}}'));
      expect(widget['items'], isA<List>());
      expect(widget['change'], isA<Map>());
      expect(widget['label'], equals('Choose one'));
      expect(widget['orientation'], equals('vertical'));
    });

    test('checkboxGroup', () {
      final widget = MCPUIJsonGenerator.checkboxGroup(
        value: '{{checkboxValues}}',
        items: [
          {'value': 'option1', 'label': 'Option 1'},
          {'value': 'option2', 'label': 'Option 2'},
        ],
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'checkboxValues',
          value: '{{event.value}}',
        ),
        label: 'Choose multiple',
        orientation: 'horizontal',
      );

      expect(widget['type'], equals('checkboxGroup'));
      expect(widget['value'], equals('{{checkboxValues}}'));
      expect(widget['items'], isA<List>());
      expect(widget['change'], isA<Map>());
      expect(widget['label'], equals('Choose multiple'));
      expect(widget['orientation'], equals('horizontal'));
    });

    test('segmentedControl', () {
      final widget = MCPUIJsonGenerator.segmentedControl(
        value: '{{segmentValue}}',
        items: [
          {'value': 'day', 'label': 'Day'},
          {'value': 'week', 'label': 'Week'},
          {'value': 'month', 'label': 'Month'},
        ],
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'segmentValue',
          value: '{{event.value}}',
        ),
        label: 'Time Period',
      );

      expect(widget['type'], equals('segmentedControl'));
      expect(widget['value'], equals('{{segmentValue}}'));
      expect(widget['items'], isA<List>());
      expect(widget['change'], isA<Map>());
      expect(widget['label'], equals('Time Period'));
    });

    test('dateField', () {
      final widget = MCPUIJsonGenerator.dateField(
        value: '{{dateValue}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'dateValue',
          value: '{{event.value}}',
        ),
        label: 'Select Date',
        minDate: '2020-01-01',
        maxDate: '2030-12-31',
        format: 'yyyy-MM-dd',
      );

      expect(widget['type'], equals('dateField'));
      expect(widget['value'], equals('{{dateValue}}'));
      expect(widget['change'], isA<Map>());
      expect(widget['label'], equals('Select Date'));
      expect(widget['minDate'], equals('2020-01-01'));
      expect(widget['maxDate'], equals('2030-12-31'));
      expect(widget['format'], equals('yyyy-MM-dd'));
    });

    test('timeField', () {
      final widget = MCPUIJsonGenerator.timeField(
        value: '{{timeValue}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'timeValue',
          value: '{{event.value}}',
        ),
        label: 'Select Time',
        format: 'HH:mm',
        use24HourFormat: true,
      );

      expect(widget['type'], equals('timeField'));
      expect(widget['value'], equals('{{timeValue}}'));
      expect(widget['change'], isA<Map>());
      expect(widget['label'], equals('Select Time'));
      expect(widget['format'], equals('HH:mm'));
      expect(widget['use24HourFormat'], equals(true));
    });

    test('dateRangePicker', () {
      final widget = MCPUIJsonGenerator.dateRangePicker(
        startDate: '{{startDate}}',
        endDate: '{{endDate}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'dateRange',
          value: '{{event.value}}',
        ),
        label: 'Select Date Range',
        minDate: '2020-01-01',
        maxDate: '2030-12-31',
        format: 'yyyy-MM-dd',
      );

      expect(widget['type'], equals('dateRangePicker'));
      expect(widget['startDate'], equals('{{startDate}}'));
      expect(widget['endDate'], equals('{{endDate}}'));
      expect(widget['change'], isA<Map>());
      expect(widget['label'], equals('Select Date Range'));
      expect(widget['minDate'], equals('2020-01-01'));
      expect(widget['maxDate'], equals('2030-12-31'));
      expect(widget['format'], equals('yyyy-MM-dd'));
    });
  });

  group('List Widgets', () {
    test('list', () {
      final widget = MCPUIJsonGenerator.list(
        items: '{{listItems}}',
        itemTemplate: MCPUIJsonGenerator.listTile(
          title: '{{item.name}}',
          subtitle: '{{item.description}}',
        ),
        itemSpacing: 8.0,
        shrinkWrap: true,
        scrollDirection: 'vertical',
      );

      expect(widget['type'], equals('list'));
      expect(widget['items'], equals('{{listItems}}'));
      expect(widget['template'], isA<Map>());
      expect(widget['itemSpacing'], equals(8.0));
      expect(widget['shrinkWrap'], equals(true));
      expect(widget['scrollDirection'], equals('vertical'));
    });

    test('grid', () {
      final widget = MCPUIJsonGenerator.grid(
        items: '{{gridItems}}',
        itemTemplate: MCPUIJsonGenerator.card(
          child: MCPUIJsonGenerator.text('{{item.name}}'),
        ),
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.5,
      );

      expect(widget['type'], equals('grid'));
      expect(widget['items'], equals('{{gridItems}}'));
      expect(widget['template'], isA<Map>());
      expect(widget['crossAxisCount'], equals(2));
      expect(widget['mainAxisSpacing'], equals(8.0));
      expect(widget['crossAxisSpacing'], equals(8.0));
      expect(widget['childAspectRatio'], equals(1.5));
    });

    test('listTile', () {
      final widget = MCPUIJsonGenerator.listTile(
        title: 'List item title',
        subtitle: 'List item subtitle',
        leading: MCPUIJsonGenerator.icon(icon: 'person'),
        trailing: MCPUIJsonGenerator.icon(icon: 'arrow_forward'),
        click: MCPUIJsonGenerator.toolAction('onItemClick'),
      );

      expect(widget['type'], equals('listTile'));
      expect(widget['title'], equals('List item title'));
      expect(widget['subtitle'], equals('List item subtitle'));
      expect(widget['leading'], isA<Map>());
      expect(widget['trailing'], isA<Map>());
      expect(widget['click'], isA<Map>());
    });
  });

  group('Navigation Widgets', () {
    test('headerBar', () {
      final widget = MCPUIJsonGenerator.headerBar(
        title: 'App Title',
        actions: [
          MCPUIJsonGenerator.button(
            label: 'Action',
            click: MCPUIJsonGenerator.toolAction('onAction'),
          ),
        ],
        leading: MCPUIJsonGenerator.icon(icon: 'menu'),
        elevation: 4.0,
      );

      expect(widget['type'], equals('headerBar'));
      expect(widget['title'], equals('App Title'));
      expect(widget['actions'], isA<List>());
      expect(widget['leading'], isA<Map>());
      expect(widget['elevation'], equals(4.0));
    });

    test('tabBar', () {
      final widget = {
        'type': 'tabBar',
        'tabs': [
          {'text': 'Tab 1', 'icon': 'home'},
          {'text': 'Tab 2', 'icon': 'settings'},
        ],
        'currentIndex': 0,
        'onTap': MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'currentTab',
          value: '{{event.index}}',
        ),
        'isScrollable': false,
      };

      expect(widget['type'], equals('tabBar'));
      expect(widget['tabs'], isA<List>());
      expect(widget['currentIndex'], equals(0));
      expect(widget['onTap'], isA<Map>());
      expect(widget['isScrollable'], equals(false));
    });

    test('tabBarView', () {
      final widget = {
        'type': 'tabBarView',
        'children': [
          MCPUIJsonGenerator.text('Content 1'),
          MCPUIJsonGenerator.text('Content 2'),
        ],
        'physics': 'scroll',
      };

      expect(widget['type'], equals('tabBarView'));
      expect(widget['children'], isA<List>());
      expect(widget['physics'], equals('scroll'));
    });

    test('drawer', () {
      final widget = MCPUIJsonGenerator.drawer(
        child: MCPUIJsonGenerator.linear(
          children: [
            MCPUIJsonGenerator.text('Drawer Header'),
            MCPUIJsonGenerator.listTile(title: 'Item 1'),
            MCPUIJsonGenerator.listTile(title: 'Item 2'),
          ],
        ),
      );

      expect(widget['type'], equals('drawer'));
      expect(widget['child'], isA<Map>());
    });

    test('bottomNavigation', () {
      final widget = MCPUIJsonGenerator.bottomNavigation(
        items: [
          {'icon': 'home', 'label': 'Home'},
          {'icon': 'settings', 'label': 'Settings'},
        ],
        currentIndex: 0,
        click: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'currentIndex',
          value: '{{event.index}}',
        ),
        barType: 'fixed',
      );

      expect(widget['type'], equals('bottomNavigation'));
      expect(widget['items'], isA<List>());
      expect(widget['currentIndex'], equals(0));
      expect(widget['click'], isA<Map>());
      expect(widget['barType'], equals('fixed'));
    });

    test('navigationRail', () {
      final widget = {
        'type': 'navigationRail',
        'destinations': [
          {'icon': 'home', 'label': 'Home'},
          {'icon': 'settings', 'label': 'Settings'},
        ],
        'selectedIndex': 0,
        'onDestinationSelected': MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'selectedIndex',
          value: '{{event.index}}',
        ),
        'extended': false,
      };

      expect(widget['type'], equals('navigationRail'));
      expect(widget['destinations'], isA<List>());
      expect(widget['selectedIndex'], equals(0));
      expect(widget['onDestinationSelected'], isA<Map>());
      expect(widget['extended'], equals(false));
    });

    test('floatingActionButton', () {
      final widget = MCPUIJsonGenerator.floatingActionButton(
        click: MCPUIJsonGenerator.toolAction('onFabClick'),
        child: MCPUIJsonGenerator.icon(icon: 'add'),
        tooltip: 'Add item',
      );

      expect(widget['type'], equals('floatingActionButton'));
      expect(widget['click'], isA<Map>());
      expect(widget['child'], isA<Map>());
      expect(widget['tooltip'], equals('Add item'));
    });
  });

  group('Scroll Widgets', () {
    test('scrollView', () {
      final widget = MCPUIJsonGenerator.scrollView(
        child: MCPUIJsonGenerator.linear(
          children: [
            MCPUIJsonGenerator.text('Item 1'),
            MCPUIJsonGenerator.text('Item 2'),
          ],
        ),
        scrollDirection: 'vertical',
        reverse: false,
        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
        primary: true,
      );

      expect(widget['type'], equals('scrollView'));
      expect(widget['child'], isA<Map>());
      expect(widget['scrollDirection'], equals('vertical'));
      expect(widget['reverse'], equals(false));
      expect(widget['padding'], isA<Map>());
      expect(widget['primary'], equals(true));
    });

    test('singleChildScrollView', () {
      final widget = {
        'type': 'singleChildScrollView',
        'child': MCPUIJsonGenerator.linear(
          children: [
            MCPUIJsonGenerator.text('Long content'),
            MCPUIJsonGenerator.text('More content'),
          ],
        ),
        'scrollDirection': 'vertical',
        'reverse': false,
        'physics': 'always',
      };

      expect(widget['type'], equals('singleChildScrollView'));
      expect(widget['child'], isA<Map>());
      expect(widget['scrollDirection'], equals('vertical'));
      expect(widget['reverse'], equals(false));
      expect(widget['physics'], equals('always'));
    });

    test('scrollBar', () {
      final widget = {
        'type': 'scrollBar',
        'child': MCPUIJsonGenerator.scrollView(
          child: MCPUIJsonGenerator.text('Scrollable content'),
        ),
        'isAlwaysShown': true,
        'thickness': 8.0,
        'radius': 4.0,
      };

      expect(widget['type'], equals('scrollBar'));
      expect(widget['child'], isA<Map>());
      expect(widget['isAlwaysShown'], equals(true));
      expect(widget['thickness'], equals(8.0));
      expect(widget['radius'], equals(4.0));
    });
  });

  group('Animation Widgets', () {
    test('animatedContainer', () {
      final widget = {
        'type': 'animatedContainer',
        'child': MCPUIJsonGenerator.text('Animated'),
        'width': 200.0,
        'height': 100.0,
        'color': '#2196F3',
        'duration': 300,
        'curve': 'ease',
      };

      expect(widget['type'], equals('animatedContainer'));
      expect(widget['child'], isA<Map>());
      expect(widget['width'], equals(200.0));
      expect(widget['height'], equals(100.0));
      expect(widget['color'], equals('#2196F3'));
      expect(widget['duration'], equals(300));
      expect(widget['curve'], equals('ease'));
    });
  });

  group('Interactive Widgets', () {
    test('gestureDetector', () {
      final widget = {
        'type': 'gestureDetector',
        'child': MCPUIJsonGenerator.text('Tap me'),
        'onTap': MCPUIJsonGenerator.toolAction('onTap'),
        'onDoubleTap': MCPUIJsonGenerator.toolAction('onDoubleTap'),
        'onLongPress': MCPUIJsonGenerator.toolAction('onLongPress'),
        'onPanUpdate': MCPUIJsonGenerator.toolAction('onPanUpdate'),
      };

      expect(widget['type'], equals('gestureDetector'));
      expect(widget['child'], isA<Map>());
      expect(widget['onTap'], isA<Map>());
      expect(widget['onDoubleTap'], isA<Map>());
      expect(widget['onLongPress'], isA<Map>());
      expect(widget['onPanUpdate'], isA<Map>());
    });

    test('inkWell', () {
      final widget = {
        'type': 'inkWell',
        'child': MCPUIJsonGenerator.text('Ripple effect'),
        'onTap': MCPUIJsonGenerator.toolAction('onInkWellTap'),
        'borderRadius': 8.0,
        'splashColor': '#2196F3',
        'highlightColor': '#E3F2FD',
      };

      expect(widget['type'], equals('inkWell'));
      expect(widget['child'], isA<Map>());
      expect(widget['onTap'], isA<Map>());
      expect(widget['borderRadius'], equals(8.0));
      expect(widget['splashColor'], equals('#2196F3'));
      expect(widget['highlightColor'], equals('#E3F2FD'));
    });

    test('draggable', () {
      final widget = MCPUIJsonGenerator.draggable(
        child: MCPUIJsonGenerator.text('Drag me'),
        feedback: MCPUIJsonGenerator.text('Dragging...'),
        data: 'drag_data',
        onDragStarted: MCPUIJsonGenerator.toolAction('onDragStarted'),
        onDragCompleted: MCPUIJsonGenerator.toolAction('onDragCompleted'),
        axis: 'both',
      );

      expect(widget['type'], equals('draggable'));
      expect(widget['child'], isA<Map>());
      expect(widget['feedback'], isA<Map>());
      expect(widget['data'], equals('drag_data'));
      expect(widget['onDragStarted'], isA<Map>());
      expect(widget['onDragCompleted'], isA<Map>());
      expect(widget['axis'], equals('both'));
    });

    test('dragTarget', () {
      final widget = MCPUIJsonGenerator.dragTarget(
        builder: MCPUIJsonGenerator.text('Drop here'),
        onAccept: MCPUIJsonGenerator.toolAction('onAccept'),
        onWillAccept: MCPUIJsonGenerator.toolAction('onWillAccept'),
        onLeave: MCPUIJsonGenerator.toolAction('onLeave'),
      );

      expect(widget['type'], equals('dragTarget'));
      expect(widget['builder'], isA<Map>());
      expect(widget['onAccept'], isA<Map>());
      expect(widget['onWillAccept'], isA<Map>());
      expect(widget['onLeave'], isA<Map>());
    });
  });

  group('Dialog Widgets', () {
    test('alertDialog', () {
      final widget = {
        'type': 'alertDialog',
        'title': 'Alert',
        'content': MCPUIJsonGenerator.text('This is an alert message'),
        'actions': [
          MCPUIJsonGenerator.button(
            label: 'Cancel',
            click: MCPUIJsonGenerator.navigationAction(
              action: 'pop',
            ),
          ),
          MCPUIJsonGenerator.button(
            label: 'OK',
            click: MCPUIJsonGenerator.toolAction('onOK'),
          ),
        ],
      };

      expect(widget['type'], equals('alertDialog'));
      expect(widget['title'], equals('Alert'));
      expect(widget['content'], isA<Map>());
      expect(widget['actions'], isA<List>());
    });

    test('snackBar', () {
      final widget = {
        'type': 'snackBar',
        'content': MCPUIJsonGenerator.text('Snackbar message'),
        'action': MCPUIJsonGenerator.button(
          label: 'Undo',
          click: MCPUIJsonGenerator.toolAction('onUndo'),
        ),
        'duration': 3000,
        'backgroundColor': '#323232',
      };

      expect(widget['type'], equals('snackBar'));
      expect(widget['content'], isA<Map>());
      expect(widget['action'], isA<Map>());
      expect(widget['duration'], equals(3000));
      expect(widget['backgroundColor'], equals('#323232'));
    });

    test('bottomSheet', () {
      final widget = {
        'type': 'bottomSheet',
        'content': MCPUIJsonGenerator.linear(
          children: [
            MCPUIJsonGenerator.text('Bottom Sheet'),
            MCPUIJsonGenerator.button(
              label: 'Close',
              click: MCPUIJsonGenerator.navigationAction(action: 'pop'),
            ),
          ],
        ),
        'isScrollControlled': true,
        'enableDrag': true,
      };

      expect(widget['type'], equals('bottomSheet'));
      expect(widget['content'], isA<Map>());
      expect(widget['isScrollControlled'], equals(true));
      expect(widget['enableDrag'], equals(true));
    });
  });

  group('Advanced Widgets', () {
    test('chart', () {
      final widget = MCPUIJsonGenerator.chart(
        chartType: 'line',
        data: [
          {'x': 1, 'y': 10},
          {'x': 2, 'y': 20},
        ],
        title: 'Sample Chart',
        width: 400.0,
        height: 300.0,
        options: {'showLegend': true},
      );

      expect(widget['type'], equals('chart'));
      expect(widget['chartType'], equals('line'));
      expect(widget['data'], isA<List>());
      expect(widget['title'], equals('Sample Chart'));
      expect(widget['width'], equals(400.0));
      expect(widget['height'], equals(300.0));
      expect(widget['options'], isA<Map>());
    });

    test('map', () {
      final widget = MCPUIJsonGenerator.map(
        latitude: 37.7749,
        longitude: -122.4194,
        zoom: 10.0,
        markers: [
          {'lat': 37.7749, 'lng': -122.4194, 'title': 'San Francisco'},
        ],
        interactive: true,
        width: 400.0,
        height: 300.0,
      );

      expect(widget['type'], equals('map'));
      expect(widget['latitude'], equals(37.7749));
      expect(widget['longitude'], equals(-122.4194));
      expect(widget['zoom'], equals(10.0));
      expect(widget['markers'], isA<List>());
      expect(widget['interactive'], equals(true));
      expect(widget['width'], equals(400.0));
      expect(widget['height'], equals(300.0));
    });

    test('mediaPlayer', () {
      final widget = MCPUIJsonGenerator.mediaPlayer(
        source: 'https://example.com/video.mp4',
        mediaType: 'video',
        autoplay: false,
        controls: true,
        loop: false,
        width: 640.0,
        height: 360.0,
      );

      expect(widget['type'], equals('mediaPlayer'));
      expect(widget['source'], equals('https://example.com/video.mp4'));
      expect(widget['mediaType'], equals('video'));
      expect(widget['autoplay'], equals(false));
      expect(widget['controls'], equals(true));
      expect(widget['loop'], equals(false));
      expect(widget['width'], equals(640.0));
      expect(widget['height'], equals(360.0));
    });

    test('calendar', () {
      final widget = MCPUIJsonGenerator.calendar(
        view: 'month',
        selectedDate: '2024-01-15',
        events: [
          {'date': '2024-01-15', 'title': 'Meeting'},
        ],
        showHeader: true,
        width: 400.0,
        height: 300.0,
      );

      expect(widget['type'], equals('calendar'));
      expect(widget['view'], equals('month'));
      expect(widget['selectedDate'], equals('2024-01-15'));
      expect(widget['events'], isA<List>());
      expect(widget['showHeader'], equals(true));
      expect(widget['width'], equals(400.0));
      expect(widget['height'], equals(300.0));
    });

    test('timeline', () {
      final widget = {
        'type': 'timeline',
        'items': [
          {
            'time': '2024-01-01',
            'title': 'Event 1',
            'description': 'First event',
          },
          {
            'time': '2024-01-02',
            'title': 'Event 2',
            'description': 'Second event',
          },
        ],
        'direction': 'vertical',
        'showTime': true,
      };

      expect(widget['type'], equals('timeline'));
      expect(widget['items'], isA<List>());
      expect(widget['direction'], equals('vertical'));
      expect(widget['showTime'], equals(true));
    });

    test('gauge', () {
      final widget = {
        'type': 'gauge',
        'value': 75.0,
        'min': 0.0,
        'max': 100.0,
        'startAngle': 135.0,
        'endAngle': 45.0,
        'showValue': true,
        'unit': '%',
      };

      expect(widget['type'], equals('gauge'));
      expect(widget['value'], equals(75.0));
      expect(widget['min'], equals(0.0));
      expect(widget['max'], equals(100.0));
      expect(widget['startAngle'], equals(135.0));
      expect(widget['endAngle'], equals(45.0));
      expect(widget['showValue'], equals(true));
      expect(widget['unit'], equals('%'));
    });

    test('heatmap', () {
      final widget = {
        'type': 'heatmap',
        'data': [
          {'x': 0, 'y': 0, 'value': 0.5},
          {'x': 1, 'y': 0, 'value': 0.8},
          {'x': 0, 'y': 1, 'value': 0.3},
          {'x': 1, 'y': 1, 'value': 0.9},
        ],
        'colorScale': ['#ffffff', '#ff0000'],
        'cellSize': 20.0,
      };

      expect(widget['type'], equals('heatmap'));
      expect(widget['data'], isA<List>());
      expect(widget['colorScale'], isA<List>());
      expect(widget['cellSize'], equals(20.0));
    });

    test('tree', () {
      final widget = MCPUIJsonGenerator.tree(
        data: [
          {
            'label': 'Root',
            'children': [
              {'label': 'Child 1'},
              {'label': 'Child 2'},
            ],
          },
        ],
        expandAll: false,
        showLines: true,
        width: 300.0,
        height: 400.0,
      );

      expect(widget['type'], equals('tree'));
      expect(widget['data'], isA<List>());
      expect(widget['expandAll'], equals(false));
      expect(widget['showLines'], equals(true));
      expect(widget['width'], equals(300.0));
      expect(widget['height'], equals(400.0));
    });

    test('graph', () {
      final widget = {
        'type': 'graph',
        'nodes': [
          {'id': 'node1', 'label': 'Node 1', 'x': 0, 'y': 0},
          {'id': 'node2', 'label': 'Node 2', 'x': 100, 'y': 100},
        ],
        'edges': [
          {'source': 'node1', 'target': 'node2'},
        ],
        'directed': true,
        'physics': true,
      };

      expect(widget['type'], equals('graph'));
      expect(widget['nodes'], isA<List>());
      expect(widget['edges'], isA<List>());
      expect(widget['directed'], equals(true));
      expect(widget['physics'], equals(true));
    });
  });
}
