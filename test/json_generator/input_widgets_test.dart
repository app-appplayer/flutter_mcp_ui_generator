import 'package:test/test.dart';
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

void main() {
  // TC-074: MCPUIJsonGenerator.button
  group('TC-074: MCPUIJsonGenerator.button', () {
    test('Normal: produces button with label and click', () {
      final w = MCPUIJsonGenerator.button(
        label: 'Click',
        click: MCPUIJsonGenerator.toolAction('test'),
      );

      expect(w['type'], equals('button'));
      expect(w['label'], equals('Click'));
      expect(w['onTap'], isA<Map>());
    });

    test('Normal: with icon and variant', () {
      final w = MCPUIJsonGenerator.button(
        label: 'Add',
        icon: 'add',
        click: MCPUIJsonGenerator.toolAction('add'),
        variant: 'elevated',
      );

      expect(w['icon'], equals('add'));
      expect(w['variant'], equals('elevated'));
    });
  });

  // TC-075: MCPUIJsonGenerator.textInput
  group('TC-075: MCPUIJsonGenerator.textInput', () {
    test('Normal: produces text input with required params', () {
      final w = MCPUIJsonGenerator.textInput(
        label: 'Name',
        value: '{{state.name}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'name',
          value: '{{event.value}}',
        ),
      );

      expect(w['type'], equals('textInput'));
      expect(w['label'], equals('Name'));
      expect(w['value'], equals('{{state.name}}'));
      expect(w['onChange'], isA<Map>());
    });

    test('Normal: with optional params', () {
      final w = MCPUIJsonGenerator.textInput(
        label: 'Email',
        value: '{{email}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'email',
          value: '{{event.value}}',
        ),
        placeholder: 'Enter email',
        helperText: 'Your email address',
        obscureText: false,
        maxLines: 1,
      );

      expect(w['placeholder'], equals('Enter email'));
      expect(w['helperText'], equals('Your email address'));
    });
  });

  // TC-076: MCPUIJsonGenerator.select
  group('TC-076: MCPUIJsonGenerator.select', () {
    test('Normal: produces select with options', () {
      final w = MCPUIJsonGenerator.select(
        value: '{{state.choice}}',
        options: [
          {'value': 'a', 'label': 'Option A'},
          {'value': 'b', 'label': 'Option B'},
        ],
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'choice',
          value: '{{event.value}}',
        ),
      );

      expect(w['type'], equals('select'));
      expect(w['options'], isA<List>());
      expect((w['options'] as List).length, equals(2));
    });

    test('Boundary: empty options list', () {
      final w = MCPUIJsonGenerator.select(
        value: '{{v}}',
        options: [],
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 'v'),
      );

      expect(w['options'], isEmpty);
    });
  });

  // TC-077: MCPUIJsonGenerator.toggle
  group('TC-077: MCPUIJsonGenerator.toggle', () {
    test('Normal: produces toggle switch', () {
      final w = MCPUIJsonGenerator.toggle(
        value: '{{state.enabled}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'toggle',
          binding: 'enabled',
        ),
      );

      expect(w['type'], equals('toggle'));
      expect(w['value'], equals('{{state.enabled}}'));
      expect(w['onChange'], isA<Map>());
    });
  });

  // TC-078: MCPUIJsonGenerator.slider
  group('TC-078: MCPUIJsonGenerator.slider', () {
    test('Normal: produces slider with all params', () {
      final w = MCPUIJsonGenerator.slider(
        value: '{{state.val}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'val',
          value: '{{event.value}}',
        ),
        min: 0,
        max: 100,
        divisions: 10,
        label: 'Volume',
      );

      expect(w['type'], equals('slider'));
      expect(w['min'], equals(0));
      expect(w['max'], equals(100));
      expect(w['divisions'], equals(10));
      expect(w['label'], equals('Volume'));
    });

    test('Boundary: value and change only', () {
      final w = MCPUIJsonGenerator.slider(
        value: '{{v}}',
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 'v'),
      );

      expect(w['type'], equals('slider'));
    });
  });

  // TC-079: MCPUIJsonGenerator.checkbox
  group('TC-079: MCPUIJsonGenerator.checkbox', () {
    test('Normal: produces checkbox', () {
      final w = MCPUIJsonGenerator.checkbox(
        label: 'Accept Terms',
        value: '{{accepted}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'toggle',
          binding: 'accepted',
        ),
      );

      expect(w['type'], equals('checkbox'));
      expect(w['label'], equals('Accept Terms'));
      expect(w['value'], equals('{{accepted}}'));
    });
  });

  // TC-080: MCPUIJsonGenerator.numberField
  group('TC-080: MCPUIJsonGenerator.numberField', () {
    test('Normal: produces numeric input', () {
      final w = MCPUIJsonGenerator.numberField(
        label: 'Quantity',
        value: '{{qty}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'qty',
          value: '{{event.value}}',
        ),
        min: 0,
        max: 100,
        step: 1,
      );

      expect(w['type'], equals('numberField'));
      expect(w['min'], equals(0));
      expect(w['max'], equals(100));
      expect(w['step'], equals(1));
    });

    test('Boundary: no min/max constraints', () {
      final w = MCPUIJsonGenerator.numberField(
        label: 'Amount',
        value: '{{amt}}',
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 'amt'),
      );

      expect(w['type'], equals('numberField'));
    });
  });

  // TC-081: MCPUIJsonGenerator.dateField
  group('TC-081: MCPUIJsonGenerator.dateField', () {
    test('Normal: produces date picker', () {
      final w = MCPUIJsonGenerator.dateField(
        label: 'Date',
        value: '{{date}}',
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 'date'),
      );

      expect(w['type'], equals('dateField'));
      expect(w['label'], equals('Date'));
    });
  });

  // TC-082: MCPUIJsonGenerator.timeField
  group('TC-082: MCPUIJsonGenerator.timeField', () {
    test('Normal: produces time picker', () {
      final w = MCPUIJsonGenerator.timeField(
        label: 'Time',
        value: '{{time}}',
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 'time'),
      );

      expect(w['type'], equals('timeField'));
      expect(w['label'], equals('Time'));
    });
  });

  // TC-083: MCPUIJsonGenerator.colorPicker
  group('TC-083: MCPUIJsonGenerator.colorPicker', () {
    test('Normal: produces color picker with all params', () {
      final w = MCPUIJsonGenerator.colorPicker(
        value: '{{state.color}}',
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'color',
          value: '{{event.value}}',
        ),
        enableAlpha: true,
      );

      expect(w['type'], equals('colorPicker'));
      expect(w['enableAlpha'], isTrue);
    });

    test('Boundary: value and change only', () {
      final w = MCPUIJsonGenerator.colorPicker(
        value: '{{c}}',
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 'c'),
      );

      expect(w['type'], equals('colorPicker'));
    });
  });

  // TC-084: MCPUIJsonGenerator.dateRangePicker
  group('TC-084: MCPUIJsonGenerator.dateRangePicker', () {
    test('Normal: produces date range picker', () {
      final w = MCPUIJsonGenerator.dateRangePicker(
        startDate: '{{range.start}}',
        endDate: '{{range.end}}',
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 'range'),
      );

      expect(w['type'], equals('dateRangePicker'));
      expect(w['startDate'], equals('{{range.start}}'));
      expect(w['endDate'], equals('{{range.end}}'));
    });
  });

  // TC-085: MCPUIJsonGenerator.rangeSlider
  group('TC-085: MCPUIJsonGenerator.rangeSlider', () {
    test('Normal: produces range slider', () {
      final w = MCPUIJsonGenerator.rangeSlider(
        value: '{{range}}',
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 'range'),
        min: 0,
        max: 100,
      );

      expect(w['type'], equals('rangeSlider'));
      expect(w['min'], equals(0));
      expect(w['max'], equals(100));
    });
  });

  // TC-086: MCPUIJsonGenerator.radioGroup
  group('TC-086: MCPUIJsonGenerator.radioGroup', () {
    test('Normal: produces radio group', () {
      final w = MCPUIJsonGenerator.radioGroup(
        value: '{{selected}}',
        options: [
          {'value': 'a', 'label': 'A'},
          {'value': 'b', 'label': 'B'},
        ],
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'selected',
          value: '{{event.value}}',
        ),
      );

      expect(w['type'], equals('radioGroup'));
      expect((w['options'] as List).length, equals(2));
    });

    test('Boundary: single option', () {
      final w = MCPUIJsonGenerator.radioGroup(
        value: '{{v}}',
        options: [{'value': 'only', 'label': 'Only'}],
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 'v'),
      );

      expect((w['options'] as List).length, equals(1));
    });
  });

  // TC-087: MCPUIJsonGenerator.checkboxGroup
  group('TC-087: MCPUIJsonGenerator.checkboxGroup', () {
    test('Normal: produces checkbox group', () {
      final w = MCPUIJsonGenerator.checkboxGroup(
        value: '{{selected}}',
        options: [
          {'value': 'a', 'label': 'A'},
          {'value': 'b', 'label': 'B'},
        ],
        change: MCPUIJsonGenerator.stateAction(
          action: 'set',
          binding: 'selected',
        ),
      );

      expect(w['type'], equals('checkboxGroup'));
      expect((w['options'] as List).length, equals(2));
    });

    test('Boundary: single option', () {
      final w = MCPUIJsonGenerator.checkboxGroup(
        value: '{{v}}',
        options: [{'value': 'only', 'label': 'Only'}],
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 'v'),
      );

      expect((w['options'] as List).length, equals(1));
    });
  });

  // TC-088: MCPUIJsonGenerator.segmentedControl
  group('TC-088: MCPUIJsonGenerator.segmentedControl', () {
    test('Normal: produces segmented control', () {
      final w = MCPUIJsonGenerator.segmentedControl(
        value: '{{tab}}',
        options: [
          {'value': 'tab1', 'label': 'Tab 1'},
          {'value': 'tab2', 'label': 'Tab 2'},
        ],
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 'tab'),
      );

      expect(w['type'], equals('segmentedControl'));
      expect((w['options'] as List).length, equals(2));
    });

    test('Boundary: two options (minimum useful)', () {
      final w = MCPUIJsonGenerator.segmentedControl(
        value: '{{s}}',
        options: [
          {'value': 'a', 'label': 'A'},
          {'value': 'b', 'label': 'B'},
        ],
        change: MCPUIJsonGenerator.stateAction(action: 'set', binding: 's'),
      );

      expect((w['options'] as List).length, equals(2));
    });
  });
}
