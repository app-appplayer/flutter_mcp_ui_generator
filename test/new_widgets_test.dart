import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'package:test/test.dart';

void main() {
  group('MCPUIJsonGenerator - New Widgets Tests', () {
    group('New Input Widgets', () {
      test('should create numberField with all properties', () {
        final numberField = MCPUIJsonGenerator.numberField(
          label: 'Age',
          value: '{{age}}',
          onChange: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'age',
            value: '{{event.value}}',
          ),
          min: 0,
          max: 120,
          step: 1,
          placeholder: 'Enter age',
          helperText: 'Your age in years',
        );

        expect(numberField['type'], 'numberfield');
        expect(numberField['label'], 'Age');
        expect(numberField['value'], '{{age}}');
        expect(numberField['min'], 0);
        expect(numberField['max'], 120);
        expect(numberField['step'], 1);
        expect(numberField['placeholder'], 'Enter age');
        expect(numberField['helperText'], 'Your age in years');
      });

      test('should create colorPicker with all properties', () {
        final colorPicker = MCPUIJsonGenerator.colorPicker(
          value: '{{selectedColor}}',
          onChange: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'selectedColor',
            value: '{{event.value}}',
          ),
          label: 'Choose Color',
          enableAlpha: false,
          swatchColors: ['#FF0000', '#00FF00', '#0000FF'],
        );

        expect(colorPicker['type'], 'colorpicker');
        expect(colorPicker['value'], '{{selectedColor}}');
        expect(colorPicker['label'], 'Choose Color');
        expect(colorPicker['enableAlpha'], false);
        expect(colorPicker['swatchColors'], ['#FF0000', '#00FF00', '#0000FF']);
      });

      test('should create radioGroup with all properties', () {
        final radioGroup = MCPUIJsonGenerator.radioGroup(
          value: '{{selectedOption}}',
          items: [
            {'value': 'option1', 'label': 'Option 1'},
            {'value': 'option2', 'label': 'Option 2'},
          ],
          onChange: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'selectedOption',
            value: '{{event.value}}',
          ),
          label: 'Select Option',
          orientation: 'horizontal',
        );

        expect(radioGroup['type'], 'radiogroup');
        expect(radioGroup['value'], '{{selectedOption}}');
        expect(radioGroup['items'].length, 2);
        expect(radioGroup['label'], 'Select Option');
        expect(radioGroup['orientation'], 'horizontal');
      });

      test('should create checkboxGroup with all properties', () {
        final checkboxGroup = MCPUIJsonGenerator.checkboxGroup(
          value: '{{selectedItems}}',
          items: [
            {'value': 'item1', 'label': 'Item 1'},
            {'value': 'item2', 'label': 'Item 2'},
            {'value': 'item3', 'label': 'Item 3'},
          ],
          onChange: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'selectedItems',
            value: '{{event.value}}',
          ),
          label: 'Select Items',
        );

        expect(checkboxGroup['type'], 'checkboxgroup');
        expect(checkboxGroup['value'], '{{selectedItems}}');
        expect(checkboxGroup['items'].length, 3);
        expect(checkboxGroup['label'], 'Select Items');
        expect(checkboxGroup['orientation'], 'vertical');
      });

      test('should create segmentedControl with all properties', () {
        final segmentedControl = MCPUIJsonGenerator.segmentedControl(
          value: '{{selectedSegment}}',
          items: [
            {'value': 'day', 'label': 'Day'},
            {'value': 'week', 'label': 'Week'},
            {'value': 'month', 'label': 'Month'},
          ],
          onChange: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'selectedSegment',
            value: '{{event.value}}',
          ),
          label: 'Time Period',
        );

        expect(segmentedControl['type'], 'segmentedcontrol');
        expect(segmentedControl['value'], '{{selectedSegment}}');
        expect(segmentedControl['items'].length, 3);
        expect(segmentedControl['label'], 'Time Period');
      });
    });

    group('Date & Time Widgets', () {
      test('should create dateField with all properties', () {
        final dateField = MCPUIJsonGenerator.dateField(
          value: '{{selectedDate}}',
          onChange: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'selectedDate',
            value: '{{event.value}}',
          ),
          label: 'Birth Date',
          minDate: '1900-01-01',
          maxDate: '2025-12-31',
          format: 'dd/MM/yyyy',
          placeholder: 'Select date',
        );

        expect(dateField['type'], 'datefield');
        expect(dateField['value'], '{{selectedDate}}');
        expect(dateField['label'], 'Birth Date');
        expect(dateField['minDate'], '1900-01-01');
        expect(dateField['maxDate'], '2025-12-31');
        expect(dateField['format'], 'dd/MM/yyyy');
        expect(dateField['placeholder'], 'Select date');
      });

      test('should create timeField with all properties', () {
        final timeField = MCPUIJsonGenerator.timeField(
          value: '{{selectedTime}}',
          onChange: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'selectedTime',
            value: '{{event.value}}',
          ),
          label: 'Appointment Time',
          format: 'hh:mm a',
          use24HourFormat: false,
          placeholder: 'Select time',
        );

        expect(timeField['type'], 'timefield');
        expect(timeField['value'], '{{selectedTime}}');
        expect(timeField['label'], 'Appointment Time');
        expect(timeField['format'], 'hh:mm a');
        expect(timeField['use24HourFormat'], false);
        expect(timeField['placeholder'], 'Select time');
      });

      test('should create dateRangePicker with all properties', () {
        final dateRangePicker = MCPUIJsonGenerator.dateRangePicker(
          startDate: '{{startDate}}',
          endDate: '{{endDate}}',
          onChange: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'dateRange',
            value: '{{event.value}}',
          ),
          label: 'Vacation Period',
          minDate: '2024-01-01',
          maxDate: '2025-12-31',
          format: 'MMM dd, yyyy',
        );

        expect(dateRangePicker['type'], 'daterangepicker');
        expect(dateRangePicker['startDate'], '{{startDate}}');
        expect(dateRangePicker['endDate'], '{{endDate}}');
        expect(dateRangePicker['label'], 'Vacation Period');
        expect(dateRangePicker['minDate'], '2024-01-01');
        expect(dateRangePicker['maxDate'], '2025-12-31');
        expect(dateRangePicker['format'], 'MMM dd, yyyy');
      });
    });

    group('Layout & Control Widgets', () {
      test('should create conditional widget with all properties', () {
        final conditional = MCPUIJsonGenerator.conditionalWidget(
          condition: '{{isLoggedIn}}',
          then: MCPUIJsonGenerator.text('Welcome back!'),
          orElse: MCPUIJsonGenerator.button(
            label: 'Login',
            onTap: MCPUIJsonGenerator.navigationAction(
              action: 'push',
              route: '/login',
            ),
          ),
        );

        expect(conditional['type'], 'conditional');
        expect(conditional['condition'], '{{isLoggedIn}}');
        expect(conditional['then']['type'], 'text');
        expect(conditional['else']['type'], 'button');
      });

      test('should create scrollView with all properties', () {
        final scrollView = MCPUIJsonGenerator.scrollView(
          child: MCPUIJsonGenerator.column(
            children: List.generate(20, (i) => 
              MCPUIJsonGenerator.text('Item $i')
            ),
          ),
          scrollDirection: 'horizontal',
          reverse: true,
          padding: MCPUIJsonGenerator.edgeInsets(all: 16),
          physics: 'bouncingScroll',
        );

        expect(scrollView['type'], 'scrollview');
        expect(scrollView['child']['type'], 'column');
        expect(scrollView['scrollDirection'], 'horizontal');
        expect(scrollView['reverse'], true);
        expect(scrollView['padding'], {'all': 16});
        expect(scrollView['physics'], 'bouncingScroll');
      });
    });

    group('Drag & Drop Widgets', () {
      test('should create draggable with all properties', () {
        final draggable = MCPUIJsonGenerator.draggable(
          child: MCPUIJsonGenerator.container(
            color: '#2196F3',
            padding: MCPUIJsonGenerator.edgeInsets(all: 16),
            child: MCPUIJsonGenerator.text('Drag me'),
          ),
          feedback: MCPUIJsonGenerator.container(
            color: '#1976D2',
            padding: MCPUIJsonGenerator.edgeInsets(all: 16),
            child: MCPUIJsonGenerator.text('Dragging...'),
          ),
          data: {'id': 'item1', 'value': 100},
          onDragStarted: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'isDragging',
            value: true,
          ),
          onDragCompleted: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'isDragging',
            value: false,
          ),
          childWhenDragging: MCPUIJsonGenerator.container(
            color: '#E3F2FD',
            padding: MCPUIJsonGenerator.edgeInsets(all: 16),
            child: MCPUIJsonGenerator.text('...'),
          ),
          axis: 'vertical',
        );

        expect(draggable['type'], 'draggable');
        expect(draggable['child']['type'], 'container');
        expect(draggable['feedback']['type'], 'container');
        expect(draggable['data'], {'id': 'item1', 'value': 100});
        expect(draggable['onDragStarted'], isNotNull);
        expect(draggable['onDragCompleted'], isNotNull);
        expect(draggable['childWhenDragging']['type'], 'container');
        expect(draggable['axis'], 'vertical');
      });

      test('should create dragTarget with all properties', () {
        final dragTarget = MCPUIJsonGenerator.dragTarget(
          builder: MCPUIJsonGenerator.container(
            color: '{{isHovering ? "#E3F2FD" : "#FFFFFF"}}',
            padding: MCPUIJsonGenerator.edgeInsets(all: 32),
            child: MCPUIJsonGenerator.text('Drop here'),
          ),
          onAccept: MCPUIJsonGenerator.stateAction(
            action: 'append',
            binding: 'droppedItems',
            value: '{{event.data}}',
          ),
          onWillAccept: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'canAccept',
            value: '{{event.data.type == "valid"}}',
          ),
          onLeave: MCPUIJsonGenerator.stateAction(
            action: 'set',
            binding: 'isHovering',
            value: false,
          ),
        );

        expect(dragTarget['type'], 'dragtarget');
        expect(dragTarget['builder']['type'], 'container');
        expect(dragTarget['onAccept'], isNotNull);
        expect(dragTarget['onWillAccept'], isNotNull);
        expect(dragTarget['onLeave'], isNotNull);
      });
    });
  });
}