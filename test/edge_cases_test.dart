import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import 'package:test/test.dart';

void main() {
  group('Edge Cases and Full Coverage Tests', () {
    group('MCPUIJsonGenerator - Edge Cases', () {
      test('creates sizedBox with only child', () {
        final sizedBox = MCPUIJsonGenerator.sizedBox(
          child: {'type': 'text', 'value': 'Test'},
        );

        expect(sizedBox['type'], 'sizedbox');
        expect(sizedBox['child'], isNotNull);
        expect(sizedBox.containsKey('width'), false);
        expect(sizedBox.containsKey('height'), false);
      });

      test('creates text without optional parameters', () {
        final text = MCPUIJsonGenerator.text('Simple');

        expect(text['type'], 'text');
        expect(text['value'], 'Simple');
        expect(text.containsKey('style'), false);
        expect(text.containsKey('textAlign'), false);
        expect(text.containsKey('maxLines'), false);
        expect(text.containsKey('overflow'), false);
      });

      test('creates image with minimal parameters', () {
        final image = MCPUIJsonGenerator.image(
          src: 'test.png',
        );

        expect(image['type'], 'image');
        expect(image['src'], 'test.png');
        expect(image['fit'], 'cover');
        expect(image.containsKey('width'), false);
        expect(image.containsKey('height'), false);
      });

      test('creates icon with minimal parameters', () {
        final icon = MCPUIJsonGenerator.icon(
          icon: 'star',
        );

        expect(icon['type'], 'icon');
        expect(icon['icon'], 'star');
        expect(icon['size'], 24);
        expect(icon.containsKey('color'), false);
      });

      test('creates card with minimal parameters', () {
        final card = MCPUIJsonGenerator.card(
          child: {'type': 'text', 'value': 'Content'},
        );

        expect(card['type'], 'card');
        expect(card['child'], isNotNull);
        expect(card['elevation'], 2);
        expect(card.containsKey('margin'), false);
        expect(card.containsKey('shape'), false);
      });

      test('creates divider with minimal parameters', () {
        final divider = MCPUIJsonGenerator.divider();

        expect(divider['type'], 'divider');
        expect(divider['thickness'], 1);
        expect(divider.containsKey('color'), false);
        expect(divider.containsKey('indent'), false);
        expect(divider.containsKey('endIndent'), false);
      });

      test('creates button with minimal parameters', () {
        final button = MCPUIJsonGenerator.button(
          label: 'Test',
          onTap: {'type': 'tool', 'tool': 'test'},
        );

        expect(button['type'], 'button');
        expect(button['label'], 'Test');
        expect(button['style'], 'elevated');
        expect(button['disabled'], false);
        expect(button.containsKey('icon'), false);
      });

      test('creates textField with minimal parameters', () {
        final textField = MCPUIJsonGenerator.textField(
          label: 'Test',
          value: '{{value}}',
          onChange: {'type': 'state', 'action': 'set'},
        );

        expect(textField['type'], 'textfield');
        expect(textField['label'], 'Test');
        expect(textField['obscureText'], false);
        expect(textField.containsKey('placeholder'), false);
        expect(textField.containsKey('helperText'), false);
        expect(textField.containsKey('errorText'), false);
        expect(textField.containsKey('maxLines'), false);
      });

      test('creates checkbox with minimal parameters', () {
        final checkbox = MCPUIJsonGenerator.checkbox(
          value: '{{checked}}',
          onChange: {'type': 'state', 'action': 'toggle'},
        );

        expect(checkbox['type'], 'checkbox');
        expect(checkbox.containsKey('label'), false);
      });

      test('creates switch with minimal parameters', () {
        final switchWidget = MCPUIJsonGenerator.switchWidget(
          value: '{{enabled}}',
          onChange: {'type': 'state', 'action': 'toggle'},
        );

        expect(switchWidget['type'], 'switch');
        expect(switchWidget.containsKey('label'), false);
      });

      test('creates slider with minimal parameters', () {
        final slider = MCPUIJsonGenerator.slider(
          value: '{{value}}',
          onChange: {'type': 'state', 'action': 'set'},
        );

        expect(slider['type'], 'slider');
        expect(slider['min'], 0);
        expect(slider['max'], 100);
        expect(slider.containsKey('divisions'), false);
        expect(slider.containsKey('label'), false);
      });

      test('creates dropdown with minimal parameters', () {
        final dropdown = MCPUIJsonGenerator.dropdown(
          value: '{{selected}}',
          items: [{'value': '1', 'label': 'One'}],
          onChange: {'type': 'state', 'action': 'set'},
        );

        expect(dropdown['type'], 'dropdown');
        expect(dropdown.containsKey('label'), false);
        expect(dropdown.containsKey('placeholder'), false);
      });

      test('creates listView with minimal parameters', () {
        final listView = MCPUIJsonGenerator.listView(
          items: '{{items}}',
          itemTemplate: {'type': 'text', 'value': '{{item}}'},
        );

        expect(listView['type'], 'listview');
        expect(listView['itemSpacing'], 0);
        expect(listView['shrinkWrap'], false);
        expect(listView['scrollDirection'], 'vertical');
      });

      test('creates gridView with minimal parameters', () {
        final gridView = MCPUIJsonGenerator.gridView(
          items: '{{items}}',
          itemTemplate: {'type': 'text', 'value': '{{item}}'},
        );

        expect(gridView['type'], 'gridview');
        expect(gridView['crossAxisCount'], 2);
        expect(gridView['mainAxisSpacing'], 0);
        expect(gridView['crossAxisSpacing'], 0);
        expect(gridView['childAspectRatio'], 1);
      });

      test('creates appBar with minimal parameters', () {
        final appBar = MCPUIJsonGenerator.appBar(
          title: 'Test',
        );

        expect(appBar['type'], 'appbar');
        expect(appBar['title'], 'Test');
        expect(appBar['elevation'], 4);
        expect(appBar.containsKey('actions'), false);
        expect(appBar.containsKey('leading'), false);
      });

      test('creates floatingActionButton with minimal parameters', () {
        final fab = MCPUIJsonGenerator.floatingActionButton(
          onPressed: {'type': 'tool', 'tool': 'test'},
          child: {'type': 'icon', 'icon': 'add'},
        );

        expect(fab['type'], 'floatingactionbutton');
        expect(fab.containsKey('tooltip'), false);
      });

      test('creates row with default alignment', () {
        final row = MCPUIJsonGenerator.row(
          children: [{'type': 'text', 'value': 'Test'}],
        );

        expect(row['type'], 'row');
        expect(row['mainAxisAlignment'], 'start');
        expect(row['crossAxisAlignment'], 'center');
        expect(row['mainAxisSize'], 'max');
      });

      test('creates column with default alignment', () {
        final column = MCPUIJsonGenerator.column(
          children: [{'type': 'text', 'value': 'Test'}],
        );

        expect(column['type'], 'column');
        expect(column['mainAxisAlignment'], 'start');
        expect(column['crossAxisAlignment'], 'center');
        expect(column['mainAxisSize'], 'max');
      });

      test('creates stack with default properties', () {
        final stack = MCPUIJsonGenerator.stack(
          children: [{'type': 'container'}],
        );

        expect(stack['type'], 'stack');
        expect(stack['alignment'], 'topLeft');
        expect(stack['fit'], 'loose');
      });

      test('creates expanded with default flex', () {
        final expanded = MCPUIJsonGenerator.expanded(
          child: {'type': 'container'},
        );

        expect(expanded['type'], 'expanded');
        expect(expanded['flex'], 1);
      });

      test('creates decoration without optional properties', () {
        final decoration = MCPUIJsonGenerator.decoration();

        expect(decoration, {});
      });

      test('creates border without color', () {
        final border = MCPUIJsonGenerator.border(
          width: 2,
        );

        expect(border['width'], 2);
        expect(border['style'], 'solid');
        expect(border.containsKey('color'), false);
      });
    });

    group('MCPUIBuilder - Edge Cases', () {
      test('creates container with multiple chained methods', () {
        final container = MCPUIBuilder.container()
          .width(100)
          .height(100)
          .color('#FF0000')
          .padding({'all': 8})
          .margin({'all': 4})
          .decoration({'borderRadius': 4})
          .child({'type': 'text', 'value': 'Test'})
          .build();

        expect(container['type'], 'container');
        expect(container['width'], 100);
        expect(container['height'], 100);
        expect(container['color'], '#FF0000');
        expect(container['padding'], {'all': 8});
        expect(container['margin'], {'all': 4});
        expect(container['decoration'], {'borderRadius': 4});
        expect(container['child'], isNotNull);
      });

      test('creates column with addAll and individual add', () {
        final column = MCPUIBuilder.column()
          .addAll([
            {'type': 'text', 'value': 'Item 1'},
            {'type': 'text', 'value': 'Item 2'},
          ])
          .add({'type': 'text', 'value': 'Item 3'})
          .mainAxisAlignment('center')
          .crossAxisAlignment('start')
          .mainAxisSize('min')
          .build();

        expect(column['children'].length, 3);
        expect(column['mainAxisAlignment'], 'center');
        expect(column['crossAxisAlignment'], 'start');
        expect(column['mainAxisSize'], 'min');
      });

      test('creates row with all properties', () {
        final row = MCPUIBuilder.row()
          .add({'type': 'icon', 'icon': 'home'})
          .addAll([
            {'type': 'text', 'value': 'Home'},
            {'type': 'icon', 'icon': 'arrow_forward'},
          ])
          .mainAxisAlignment('spaceBetween')
          .crossAxisAlignment('end')
          .mainAxisSize('min')
          .build();

        expect(row['children'].length, 3);
        expect(row['mainAxisAlignment'], 'spaceBetween');
        expect(row['crossAxisAlignment'], 'end');
        expect(row['mainAxisSize'], 'min');
      });

      test('creates stack with all properties', () {
        final stack = MCPUIBuilder.stack()
          .add({'type': 'container', 'color': '#000000'})
          .addAll([
            {'type': 'text', 'value': 'Overlay 1'},
            {'type': 'text', 'value': 'Overlay 2'},
          ])
          .alignment('center')
          .fit('expand')
          .build();

        expect(stack['children'].length, 3);
        expect(stack['alignment'], 'center');
        expect(stack['fit'], 'expand');
      });

      test('creates listView with all optional properties', () {
        final listView = MCPUIBuilder.listView(
          items: '{{items}}',
          itemTemplate: {'type': 'text', 'value': '{{item}}'},
        )
        .itemSpacing(16)
        .shrinkWrap(true)
        .scrollDirection('horizontal')
        .build();

        expect(listView['itemSpacing'], 16);
        expect(listView['shrinkWrap'], true);
        expect(listView['scrollDirection'], 'horizontal');
      });

      test('creates gridView with all optional properties', () {
        final gridView = MCPUIBuilder.gridView(
          items: '{{items}}',
          itemTemplate: {'type': 'text', 'value': '{{item}}'},
        )
        .crossAxisCount(4)
        .mainAxisSpacing(12)
        .crossAxisSpacing(8)
        .childAspectRatio(1.5)
        .build();

        expect(gridView['crossAxisCount'], 4);
        expect(gridView['mainAxisSpacing'], 12);
        expect(gridView['crossAxisSpacing'], 8);
        expect(gridView['childAspectRatio'], 1.5);
      });

      test('creates card with all properties', () {
        final card = MCPUIBuilder.card()
          .child({'type': 'text', 'value': 'Card content'})
          .elevation(8)
          .margin({'all': 16})
          .shape({'borderRadius': 16})
          .build();

        expect(card['elevation'], 8);
        expect(card['margin'], {'all': 16});
        expect(card['shape'], {'borderRadius': 16});
      });
    });

    group('QuickBuilders - All Variations', () {
      test('creates section with title and children', () {
        final section = QuickBuilders.section(
          title: 'Test Section',
          children: [
            {'type': 'text', 'value': 'Child 1'},
            {'type': 'text', 'value': 'Child 2'},
          ],
        );

        expect(section['type'], 'column');
        expect(section['children'].length, 4); // title + sizedbox + 2 children
        
        // Check title styling
        final titleText = section['children'][0];
        expect(titleText['type'], 'text');
        expect(titleText['value'], 'Test Section');
        expect(titleText['style']['fontSize'], 18);
        expect(titleText['style']['fontWeight'], 'bold');
      });

      test('creates form field with all parameters', () {
        final field = QuickBuilders.formField(
          label: 'Email',
          binding: 'user.email',
          placeholder: 'Enter your email',
          helperText: 'We will not spam you',
        );

        expect(field['type'], 'textfield');
        expect(field['label'], 'Email');
        expect(field['value'], '{{user.email}}');
        expect(field['placeholder'], 'Enter your email');
        expect(field['helperText'], 'We will not spam you');
        expect(field['onChange']['type'], 'state');
        expect(field['onChange']['action'], 'set');
        expect(field['onChange']['binding'], 'user.email');
        expect(field['onChange']['value'], '{{event.value}}');
      });

      test('creates form field with minimal parameters', () {
        final field = QuickBuilders.formField(
          label: 'Name',
          binding: 'name',
        );

        expect(field['type'], 'textfield');
        expect(field['label'], 'Name');
        expect(field.containsKey('placeholder'), false);
        expect(field.containsKey('helperText'), false);
      });

      test('creates loading indicator with different variations', () {
        final loading1 = QuickBuilders.loadingIndicator();
        final loading2 = QuickBuilders.loadingIndicator('Please wait...');

        // Without message
        expect(loading1['type'], 'center');
        expect(loading1['child']['children'].length, 1);

        // With message  
        expect(loading2['type'], 'center');
        expect(loading2['child']['children'].length, 3); // progress + sizedbox + text
        expect(loading2['child']['children'][2]['value'], 'Please wait...');
      });

      test('creates error message with proper styling', () {
        final error = QuickBuilders.errorMessage('Network error occurred');

        expect(error['type'], 'container');
        expect(error['padding'], {'all': 16});
        expect(error['decoration']['color'], '#ffebee');
        expect(error['decoration']['borderRadius'], 8);
        
        final row = error['child'];
        expect(row['type'], 'row');
        
        final children = row['children'];
        expect(children.length, 3); // icon + sizedbox + expanded text
        
        // Check icon
        expect(children[0]['type'], 'icon');
        expect(children[0]['icon'], 'error');
        expect(children[0]['color'], '#c62828');
        
        // Check sizedbox spacing
        expect(children[1]['type'], 'sizedbox');
        expect(children[1]['width'], 8);
        
        // Check expanded text
        expect(children[2]['type'], 'expanded');
        expect(children[2]['child']['type'], 'text');
        expect(children[2]['child']['value'], 'Network error occurred');
        expect(children[2]['child']['style']['color'], '#c62828');
      });
    });
  });
}