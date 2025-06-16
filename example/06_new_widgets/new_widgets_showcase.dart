import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

/// New Widgets Showcase
/// 
/// This example demonstrates all 12 new widgets added to Flutter MCP UI Generator:
/// - numberField, colorPicker, radioGroup, checkboxGroup, segmentedControl
/// - dateField, timeField, dateRangePicker
/// - conditional, scrollView
/// - draggable, dragTarget
void main() {
  print('=== Flutter MCP UI Generator - New Widgets Showcase ===\n');

  // Create examples for each new widget category
  _createInputWidgetsExample();
  _createDateTimeWidgetsExample();
  _createLayoutControlWidgetsExample();
  _createDragDropExample();
  _createCompleteFormExample();

  print('\n=== All examples completed! ===');
  print('Generated JSON files:');
  print('- new_widgets_input.json');
  print('- new_widgets_datetime.json');
  print('- new_widgets_layout.json');
  print('- new_widgets_dragdrop.json');
  print('- new_widgets_form.json');
}

/// New Input Widgets Example
void _createInputWidgetsExample() {
  print('Creating new input widgets example...');
  
  final page = MCPUIJsonGenerator.page(
    title: 'New Input Widgets',
    content: MCPUIJsonGenerator.padding(
      padding: MCPUIJsonGenerator.edgeInsets(all: 16),
      child: MCPUIJsonGenerator.column(
        crossAxisAlignment: 'stretch',
        children: [
          // Number Field
          MCPUIJsonGenerator.text(
            'Number Field Example',
            style: MCPUIJsonGenerator.textStyle(
              fontSize: 18,
              fontWeight: 'bold',
            ),
          ),
          MCPUIJsonGenerator.sizedBox(height: 8),
          MCPUIJsonGenerator.numberField(
            label: 'Quantity',
            value: '{{quantity}}',
            onChange: MCPUIJsonGenerator.stateAction(
              action: 'set',
              binding: 'quantity',
              value: '{{event.value}}',
            ),
            min: 0,
            max: 100,
            step: 5,
            helperText: 'Choose quantity (0-100)',
          ),
          MCPUIJsonGenerator.sizedBox(height: 24),
          
          // Color Picker
          MCPUIJsonGenerator.text(
            'Color Picker Example',
            style: MCPUIJsonGenerator.textStyle(
              fontSize: 18,
              fontWeight: 'bold',
            ),
          ),
          MCPUIJsonGenerator.sizedBox(height: 8),
          MCPUIJsonGenerator.colorPicker(
            value: '{{selectedColor}}',
            onChange: MCPUIJsonGenerator.stateAction(
              action: 'set',
              binding: 'selectedColor',
              value: '{{event.value}}',
            ),
            label: 'Choose Theme Color',
            swatchColors: [
              '#FF5252', '#E91E63', '#9C27B0', '#673AB7',
              '#3F51B5', '#2196F3', '#03A9F4', '#00BCD4',
              '#009688', '#4CAF50', '#8BC34A', '#CDDC39',
              '#FFEB3B', '#FFC107', '#FF9800', '#FF5722',
            ],
          ),
          MCPUIJsonGenerator.sizedBox(height: 24),
          
          // Radio Group
          MCPUIJsonGenerator.text(
            'Radio Group Example',
            style: MCPUIJsonGenerator.textStyle(
              fontSize: 18,
              fontWeight: 'bold',
            ),
          ),
          MCPUIJsonGenerator.sizedBox(height: 8),
          MCPUIJsonGenerator.radioGroup(
            value: '{{size}}',
            items: [
              {'value': 'small', 'label': 'Small'},
              {'value': 'medium', 'label': 'Medium'},
              {'value': 'large', 'label': 'Large'},
              {'value': 'xlarge', 'label': 'Extra Large'},
            ],
            onChange: MCPUIJsonGenerator.stateAction(
              action: 'set',
              binding: 'size',
              value: '{{event.value}}',
            ),
            label: 'Select Size',
            orientation: 'horizontal',
          ),
          MCPUIJsonGenerator.sizedBox(height: 24),
          
          // Checkbox Group
          MCPUIJsonGenerator.text(
            'Checkbox Group Example',
            style: MCPUIJsonGenerator.textStyle(
              fontSize: 18,
              fontWeight: 'bold',
            ),
          ),
          MCPUIJsonGenerator.sizedBox(height: 8),
          MCPUIJsonGenerator.checkboxGroup(
            value: '{{features}}',
            items: [
              {'value': 'wifi', 'label': 'Wi-Fi'},
              {'value': 'parking', 'label': 'Parking'},
              {'value': 'pool', 'label': 'Swimming Pool'},
              {'value': 'gym', 'label': 'Gym'},
              {'value': 'pets', 'label': 'Pet Friendly'},
            ],
            onChange: MCPUIJsonGenerator.stateAction(
              action: 'set',
              binding: 'features',
              value: '{{event.value}}',
            ),
            label: 'Select Features',
          ),
          MCPUIJsonGenerator.sizedBox(height: 24),
          
          // Segmented Control
          MCPUIJsonGenerator.text(
            'Segmented Control Example',
            style: MCPUIJsonGenerator.textStyle(
              fontSize: 18,
              fontWeight: 'bold',
            ),
          ),
          MCPUIJsonGenerator.sizedBox(height: 8),
          MCPUIJsonGenerator.segmentedControl(
            value: '{{viewMode}}',
            items: [
              {'value': 'list', 'label': 'List'},
              {'value': 'grid', 'label': 'Grid'},
              {'value': 'map', 'label': 'Map'},
            ],
            onChange: MCPUIJsonGenerator.stateAction(
              action: 'set',
              binding: 'viewMode',
              value: '{{event.value}}',
            ),
            label: 'View Mode',
          ),
        ],
      ),
    ),
    state: {
      'initial': {
        'quantity': 10,
        'selectedColor': '#2196F3',
        'size': 'medium',
        'features': ['wifi', 'parking'],
        'viewMode': 'list',
      },
    },
  );
  
  MCPUIJsonGenerator.generateJsonFile(page, 'new_widgets_input.json');
  print('✓ Created new_widgets_input.json');
}

/// Date & Time Widgets Example
void _createDateTimeWidgetsExample() {
  print('Creating date & time widgets example...');
  
  final page = MCPUIJsonGenerator.page(
    title: 'Date & Time Widgets',
    content: MCPUIJsonGenerator.padding(
      padding: MCPUIJsonGenerator.edgeInsets(all: 16),
      child: MCPUIJsonGenerator.column(
        crossAxisAlignment: 'stretch',
        children: [
          // Date Field
          MCPUIJsonGenerator.text(
            'Date Field Example',
            style: MCPUIJsonGenerator.textStyle(
              fontSize: 18,
              fontWeight: 'bold',
            ),
          ),
          MCPUIJsonGenerator.sizedBox(height: 8),
          MCPUIJsonGenerator.dateField(
            value: '{{birthDate}}',
            onChange: MCPUIJsonGenerator.stateAction(
              action: 'set',
              binding: 'birthDate',
              value: '{{event.value}}',
            ),
            label: 'Birth Date',
            minDate: '1900-01-01',
            maxDate: '2024-12-31',
            format: 'MMM dd, yyyy',
            placeholder: 'Select your birth date',
          ),
          MCPUIJsonGenerator.sizedBox(height: 24),
          
          // Time Field
          MCPUIJsonGenerator.text(
            'Time Field Example',
            style: MCPUIJsonGenerator.textStyle(
              fontSize: 18,
              fontWeight: 'bold',
            ),
          ),
          MCPUIJsonGenerator.sizedBox(height: 8),
          MCPUIJsonGenerator.timeField(
            value: '{{appointmentTime}}',
            onChange: MCPUIJsonGenerator.stateAction(
              action: 'set',
              binding: 'appointmentTime',
              value: '{{event.value}}',
            ),
            label: 'Appointment Time',
            format: 'hh:mm a',
            use24HourFormat: false,
            placeholder: 'Select time',
          ),
          MCPUIJsonGenerator.sizedBox(height: 24),
          
          // Date Range Picker
          MCPUIJsonGenerator.text(
            'Date Range Picker Example',
            style: MCPUIJsonGenerator.textStyle(
              fontSize: 18,
              fontWeight: 'bold',
            ),
          ),
          MCPUIJsonGenerator.sizedBox(height: 8),
          MCPUIJsonGenerator.dateRangePicker(
            startDate: '{{vacationStart}}',
            endDate: '{{vacationEnd}}',
            onChange: MCPUIJsonGenerator.stateAction(
              action: 'batch',
              binding: '',
              value: [
                MCPUIJsonGenerator.stateAction(
                  action: 'set',
                  binding: 'vacationStart',
                  value: '{{event.startDate}}',
                ),
                MCPUIJsonGenerator.stateAction(
                  action: 'set',
                  binding: 'vacationEnd',
                  value: '{{event.endDate}}',
                ),
              ],
            ),
            label: 'Vacation Period',
            minDate: '2024-01-01',
            maxDate: '2025-12-31',
            format: 'yyyy-MM-dd',
          ),
          MCPUIJsonGenerator.sizedBox(height: 24),
          
          // Display selected values
          MCPUIJsonGenerator.card(
            child: MCPUIJsonGenerator.padding(
              padding: MCPUIJsonGenerator.edgeInsets(all: 16),
              child: MCPUIJsonGenerator.column(
                crossAxisAlignment: 'start',
                children: [
                  MCPUIJsonGenerator.text(
                    'Selected Values:',
                    style: MCPUIJsonGenerator.textStyle(
                      fontWeight: 'bold',
                    ),
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 8),
                  MCPUIJsonGenerator.text('Birth Date: {{birthDate}}'),
                  MCPUIJsonGenerator.text('Appointment: {{appointmentTime}}'),
                  MCPUIJsonGenerator.text('Vacation: {{vacationStart}} to {{vacationEnd}}'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    state: {
      'initial': {
        'birthDate': '1990-01-01',
        'appointmentTime': '09:00',
        'vacationStart': '2024-07-01',
        'vacationEnd': '2024-07-14',
      },
    },
  );
  
  MCPUIJsonGenerator.generateJsonFile(page, 'new_widgets_datetime.json');
  print('✓ Created new_widgets_datetime.json');
}

/// Layout & Control Widgets Example
void _createLayoutControlWidgetsExample() {
  print('Creating layout & control widgets example...');
  
  final page = MCPUIJsonGenerator.page(
    title: 'Layout & Control Widgets',
    content: MCPUIJsonGenerator.padding(
      padding: MCPUIJsonGenerator.edgeInsets(all: 16),
      child: MCPUIJsonGenerator.column(
        children: [
          // Conditional Widget Example
          MCPUIJsonGenerator.text(
            'Conditional Widget Example',
            style: MCPUIJsonGenerator.textStyle(
              fontSize: 18,
              fontWeight: 'bold',
            ),
          ),
          MCPUIJsonGenerator.sizedBox(height: 16),
          
          MCPUIJsonGenerator.switchWidget(
            value: '{{showContent}}',
            onChange: MCPUIJsonGenerator.stateAction(
              action: 'set',
              binding: 'showContent',
              value: '{{event.value}}',
            ),
            label: 'Show Content',
          ),
          MCPUIJsonGenerator.sizedBox(height: 16),
          
          MCPUIJsonGenerator.conditionalWidget(
            condition: '{{showContent}}',
            then: MCPUIJsonGenerator.card(
              elevation: 4,
              child: MCPUIJsonGenerator.padding(
                padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                child: MCPUIJsonGenerator.column(
                  children: [
                    MCPUIJsonGenerator.icon(
                      icon: 'check_circle',
                      size: 48,
                      color: '#4CAF50',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 8),
                    MCPUIJsonGenerator.text(
                      'Content is visible!',
                      style: MCPUIJsonGenerator.textStyle(
                        fontSize: 18,
                        fontWeight: 'bold',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            orElse: MCPUIJsonGenerator.container(
              padding: MCPUIJsonGenerator.edgeInsets(all: 32),
              decoration: MCPUIJsonGenerator.decoration(
                color: '#F5F5F5',
                borderRadius: 8,
              ),
              child: MCPUIJsonGenerator.text(
                'Content is hidden. Toggle the switch to show.',
                style: MCPUIJsonGenerator.textStyle(
                  color: '#757575',
                ),
              ),
            ),
          ),
          MCPUIJsonGenerator.sizedBox(height: 32),
          
          // ScrollView Example
          MCPUIJsonGenerator.text(
            'ScrollView Example',
            style: MCPUIJsonGenerator.textStyle(
              fontSize: 18,
              fontWeight: 'bold',
            ),
          ),
          MCPUIJsonGenerator.sizedBox(height: 16),
          
          MCPUIJsonGenerator.container(
            height: 200,
            decoration: MCPUIJsonGenerator.decoration(
              border: MCPUIJsonGenerator.border(
                color: '#E0E0E0',
                width: 1,
              ),
              borderRadius: 8,
            ),
            child: MCPUIJsonGenerator.scrollView(
              child: MCPUIJsonGenerator.column(
                children: List.generate(20, (index) => 
                  MCPUIJsonGenerator.listTile(
                    title: 'Item ${index + 1}',
                    subtitle: 'This is item number ${index + 1}',
                    leading: MCPUIJsonGenerator.icon(
                      icon: 'folder',
                      color: '#2196F3',
                    ),
                    trailing: MCPUIJsonGenerator.icon(
                      icon: 'arrow_forward',
                      color: '#757575',
                    ),
                  ),
                ),
              ),
              padding: MCPUIJsonGenerator.edgeInsets(all: 8),
            ),
          ),
        ],
      ),
    ),
    state: {
      'initial': {
        'showContent': true,
      },
    },
  );
  
  MCPUIJsonGenerator.generateJsonFile(page, 'new_widgets_layout.json');
  print('✓ Created new_widgets_layout.json');
}

/// Drag & Drop Example
void _createDragDropExample() {
  print('Creating drag & drop example...');
  
  final page = MCPUIJsonGenerator.page(
    title: 'Drag & Drop Demo',
    content: MCPUIJsonGenerator.padding(
      padding: MCPUIJsonGenerator.edgeInsets(all: 16),
      child: MCPUIJsonGenerator.column(
        children: [
          MCPUIJsonGenerator.text(
            'Drag items from the left to the right',
            style: MCPUIJsonGenerator.textStyle(
              fontSize: 18,
              fontWeight: 'bold',
            ),
          ),
          MCPUIJsonGenerator.sizedBox(height: 16),
          
          MCPUIJsonGenerator.row(
            crossAxisAlignment: 'start',
            children: [
              // Source items
              MCPUIJsonGenerator.expanded(
                child: MCPUIJsonGenerator.container(
                  decoration: MCPUIJsonGenerator.decoration(
                    color: '#E3F2FD',
                    borderRadius: 8,
                  ),
                  padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                  child: MCPUIJsonGenerator.column(
                    children: [
                      MCPUIJsonGenerator.text(
                        'Items',
                        style: MCPUIJsonGenerator.textStyle(
                          fontWeight: 'bold',
                        ),
                      ),
                      MCPUIJsonGenerator.sizedBox(height: 16),
                      
                      // Draggable items
                      ...['Apple', 'Banana', 'Orange', 'Grape'].map((fruit) =>
                        MCPUIJsonGenerator.padding(
                          padding: MCPUIJsonGenerator.edgeInsets(bottom: 8),
                          child: MCPUIJsonGenerator.draggable(
                            child: MCPUIJsonGenerator.container(
                              decoration: MCPUIJsonGenerator.decoration(
                                color: '#FFFFFF',
                                borderRadius: 8,
                                boxShadow: [
                                  {
                                    'color': '#00000020',
                                    'offset': {'x': 0, 'y': 2},
                                    'blurRadius': 4,
                                  },
                                ],
                              ),
                              padding: MCPUIJsonGenerator.edgeInsets(all: 12),
                              child: MCPUIJsonGenerator.row(
                                children: [
                                  MCPUIJsonGenerator.icon(
                                    icon: 'drag_indicator',
                                    color: '#757575',
                                  ),
                                  MCPUIJsonGenerator.sizedBox(width: 8),
                                  MCPUIJsonGenerator.text(fruit),
                                ],
                              ),
                            ),
                            feedback: MCPUIJsonGenerator.container(
                              decoration: MCPUIJsonGenerator.decoration(
                                color: '#2196F3',
                                borderRadius: 8,
                              ),
                              padding: MCPUIJsonGenerator.edgeInsets(all: 12),
                              child: MCPUIJsonGenerator.text(
                                fruit,
                                style: MCPUIJsonGenerator.textStyle(
                                  color: '#FFFFFF',
                                  fontWeight: 'bold',
                                ),
                              ),
                            ),
                            data: {'name': fruit, 'type': 'fruit'},
                            childWhenDragging: MCPUIJsonGenerator.container(
                              decoration: MCPUIJsonGenerator.decoration(
                                color: '#E0E0E0',
                                borderRadius: 8,
                              ),
                              padding: MCPUIJsonGenerator.edgeInsets(all: 12),
                              child: MCPUIJsonGenerator.text(
                                '...',
                                style: MCPUIJsonGenerator.textStyle(
                                  color: '#757575',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).toList(),
                    ],
                  ),
                ),
              ),
              MCPUIJsonGenerator.sizedBox(width: 16),
              
              // Drop target
              MCPUIJsonGenerator.expanded(
                child: MCPUIJsonGenerator.dragTarget(
                  builder: MCPUIJsonGenerator.container(
                    decoration: MCPUIJsonGenerator.decoration(
                      color: '{{isDraggingOver ? "#C8E6C9" : "#F5F5F5"}}',
                      borderRadius: 8,
                      border: MCPUIJsonGenerator.border(
                        color: '{{isDraggingOver ? "#4CAF50" : "#E0E0E0"}}',
                        width: 2,
                        style: 'dashed',
                      ),
                    ),
                    padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                    child: MCPUIJsonGenerator.column(
                      children: [
                        MCPUIJsonGenerator.text(
                          'Drop Zone',
                          style: MCPUIJsonGenerator.textStyle(
                            fontWeight: 'bold',
                          ),
                        ),
                        MCPUIJsonGenerator.sizedBox(height: 16),
                        MCPUIJsonGenerator.conditionalWidget(
                          condition: '{{droppedItems.length > 0}}',
                          then: MCPUIJsonGenerator.column(
                            children: [
                              MCPUIJsonGenerator.text('Dropped items:'),
                              MCPUIJsonGenerator.sizedBox(height: 8),
                              MCPUIJsonGenerator.listView(
                                items: '{{droppedItems}}',
                                itemTemplate: MCPUIJsonGenerator.container(
                                  decoration: MCPUIJsonGenerator.decoration(
                                    color: '#4CAF50',
                                    borderRadius: 8,
                                  ),
                                  padding: MCPUIJsonGenerator.edgeInsets(all: 8),
                                  margin: MCPUIJsonGenerator.edgeInsets(bottom: 4),
                                  child: MCPUIJsonGenerator.text(
                                    '{{item.name}}',
                                    style: MCPUIJsonGenerator.textStyle(
                                      color: '#FFFFFF',
                                    ),
                                  ),
                                ),
                                shrinkWrap: true,
                              ),
                            ],
                          ),
                          orElse: MCPUIJsonGenerator.text(
                            'Drop items here',
                            style: MCPUIJsonGenerator.textStyle(
                              color: '#757575',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onAccept: MCPUIJsonGenerator.stateAction(
                    action: 'append',
                    binding: 'droppedItems',
                    value: '{{event.data}}',
                  ),
                  onWillAccept: MCPUIJsonGenerator.stateAction(
                    action: 'set',
                    binding: 'isDraggingOver',
                    value: true,
                  ),
                  onLeave: MCPUIJsonGenerator.stateAction(
                    action: 'set',
                    binding: 'isDraggingOver',
                    value: false,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    state: {
      'initial': {
        'droppedItems': [],
        'isDraggingOver': false,
      },
    },
  );
  
  MCPUIJsonGenerator.generateJsonFile(page, 'new_widgets_dragdrop.json');
  print('✓ Created new_widgets_dragdrop.json');
}

/// Complete Form Example with All New Widgets
void _createCompleteFormExample() {
  print('Creating complete form example...');
  
  final page = MCPUIJsonGenerator.page(
    title: 'Event Registration Form',
    content: MCPUIJsonGenerator.scrollView(
      child: MCPUIJsonGenerator.padding(
        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
        child: MCPUIJsonGenerator.column(
          crossAxisAlignment: 'stretch',
          children: [
            MCPUIJsonGenerator.text(
              'Event Registration',
              style: MCPUIJsonGenerator.textStyle(
                fontSize: 24,
                fontWeight: 'bold',
              ),
            ),
            MCPUIJsonGenerator.sizedBox(height: 24),
            
            // Personal Information Section
            MCPUIJsonGenerator.card(
              child: MCPUIJsonGenerator.padding(
                padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                child: MCPUIJsonGenerator.column(
                  crossAxisAlignment: 'stretch',
                  children: [
                    MCPUIJsonGenerator.text(
                      'Personal Information',
                      style: MCPUIJsonGenerator.textStyle(
                        fontSize: 18,
                        fontWeight: 'bold',
                      ),
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    MCPUIJsonGenerator.textField(
                      label: 'Full Name',
                      value: '{{fullName}}',
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'fullName',
                        value: '{{event.value}}',
                      ),
                      placeholder: 'Enter your full name',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    MCPUIJsonGenerator.dateField(
                      value: '{{birthDate}}',
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'birthDate',
                        value: '{{event.value}}',
                      ),
                      label: 'Date of Birth',
                      maxDate: '2006-12-31',
                      placeholder: 'Select date',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    MCPUIJsonGenerator.numberField(
                      label: 'Age',
                      value: '{{age}}',
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'age',
                        value: '{{event.value}}',
                      ),
                      min: 18,
                      max: 100,
                      helperText: 'Must be 18 or older',
                    ),
                  ],
                ),
              ),
            ),
            MCPUIJsonGenerator.sizedBox(height: 16),
            
            // Event Preferences Section
            MCPUIJsonGenerator.card(
              child: MCPUIJsonGenerator.padding(
                padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                child: MCPUIJsonGenerator.column(
                  crossAxisAlignment: 'stretch',
                  children: [
                    MCPUIJsonGenerator.text(
                      'Event Preferences',
                      style: MCPUIJsonGenerator.textStyle(
                        fontSize: 18,
                        fontWeight: 'bold',
                      ),
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    MCPUIJsonGenerator.segmentedControl(
                      value: '{{ticketType}}',
                      items: [
                        {'value': 'regular', 'label': 'Regular'},
                        {'value': 'vip', 'label': 'VIP'},
                        {'value': 'premium', 'label': 'Premium'},
                      ],
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'ticketType',
                        value: '{{event.value}}',
                      ),
                      label: 'Ticket Type',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    MCPUIJsonGenerator.radioGroup(
                      value: '{{mealPreference}}',
                      items: [
                        {'value': 'vegetarian', 'label': 'Vegetarian'},
                        {'value': 'vegan', 'label': 'Vegan'},
                        {'value': 'regular', 'label': 'Regular'},
                        {'value': 'none', 'label': 'No meal'},
                      ],
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'mealPreference',
                        value: '{{event.value}}',
                      ),
                      label: 'Meal Preference',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    MCPUIJsonGenerator.checkboxGroup(
                      value: '{{workshops}}',
                      items: [
                        {'value': 'ai', 'label': 'AI & Machine Learning'},
                        {'value': 'web', 'label': 'Web Development'},
                        {'value': 'mobile', 'label': 'Mobile Development'},
                        {'value': 'cloud', 'label': 'Cloud Computing'},
                        {'value': 'security', 'label': 'Cybersecurity'},
                      ],
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'workshops',
                        value: '{{event.value}}',
                      ),
                      label: 'Select Workshops',
                    ),
                  ],
                ),
              ),
            ),
            MCPUIJsonGenerator.sizedBox(height: 16),
            
            // Schedule Section
            MCPUIJsonGenerator.card(
              child: MCPUIJsonGenerator.padding(
                padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                child: MCPUIJsonGenerator.column(
                  crossAxisAlignment: 'stretch',
                  children: [
                    MCPUIJsonGenerator.text(
                      'Schedule',
                      style: MCPUIJsonGenerator.textStyle(
                        fontSize: 18,
                        fontWeight: 'bold',
                      ),
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    MCPUIJsonGenerator.dateRangePicker(
                      startDate: '{{eventStart}}',
                      endDate: '{{eventEnd}}',
                      onChange: MCPUIJsonGenerator.batchAction(
                        actions: [
                          MCPUIJsonGenerator.stateAction(
                            action: 'set',
                            binding: 'eventStart',
                            value: '{{event.startDate}}',
                          ),
                          MCPUIJsonGenerator.stateAction(
                            action: 'set',
                            binding: 'eventEnd',
                            value: '{{event.endDate}}',
                          ),
                        ],
                      ),
                      label: 'Event Dates',
                      minDate: '2024-01-01',
                      maxDate: '2025-12-31',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    MCPUIJsonGenerator.timeField(
                      value: '{{preferredSessionTime}}',
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'preferredSessionTime',
                        value: '{{event.value}}',
                      ),
                      label: 'Preferred Session Time',
                      placeholder: 'Select time',
                    ),
                  ],
                ),
              ),
            ),
            MCPUIJsonGenerator.sizedBox(height: 16),
            
            // Customization Section
            MCPUIJsonGenerator.card(
              child: MCPUIJsonGenerator.padding(
                padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                child: MCPUIJsonGenerator.column(
                  crossAxisAlignment: 'stretch',
                  children: [
                    MCPUIJsonGenerator.text(
                      'Badge Customization',
                      style: MCPUIJsonGenerator.textStyle(
                        fontSize: 18,
                        fontWeight: 'bold',
                      ),
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    MCPUIJsonGenerator.colorPicker(
                      value: '{{badgeColor}}',
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'badgeColor',
                        value: '{{event.value}}',
                      ),
                      label: 'Badge Color',
                      enableAlpha: false,
                    ),
                  ],
                ),
              ),
            ),
            MCPUIJsonGenerator.sizedBox(height: 24),
            
            // Submit Button
            MCPUIJsonGenerator.button(
              label: 'Submit Registration',
              onTap: MCPUIJsonGenerator.toolAction(
                'submitRegistration',
                args: {
                  'fullName': '{{fullName}}',
                  'birthDate': '{{birthDate}}',
                  'age': '{{age}}',
                  'ticketType': '{{ticketType}}',
                  'mealPreference': '{{mealPreference}}',
                  'workshops': '{{workshops}}',
                  'eventStart': '{{eventStart}}',
                  'eventEnd': '{{eventEnd}}',
                  'preferredSessionTime': '{{preferredSessionTime}}',
                  'badgeColor': '{{badgeColor}}',
                },
                onSuccess: MCPUIJsonGenerator.navigationAction(
                  action: 'push',
                  route: '/confirmation',
                ),
              ),
              style: 'elevated',
              icon: 'send',
            ),
          ],
        ),
      ),
    ),
    state: {
      'initial': {
        'fullName': '',
        'birthDate': '',
        'age': 18,
        'ticketType': 'regular',
        'mealPreference': 'regular',
        'workshops': [],
        'eventStart': '',
        'eventEnd': '',
        'preferredSessionTime': '09:00',
        'badgeColor': '#2196F3',
      },
    },
  );
  
  MCPUIJsonGenerator.generateJsonFile(page, 'new_widgets_form.json');
  print('✓ Created new_widgets_form.json');
}