import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

/// Dynamic Form Example
/// 
/// This example shows a dynamically generated form.
/// It's a reactive form where additional fields appear and disappear based on user selections.
void main() {
  final dynamicForm = MCPUIJsonGenerator.page(
    title: 'Dynamic Survey Form',
    content: MCPUIJsonGenerator.column(
      children: [
        MCPUIJsonGenerator.appBar(
          title: 'Customer Survey',
          leading: MCPUIJsonGenerator.icon(icon: 'arrow_back'),
        ),
        
        MCPUIJsonGenerator.expanded(
          child: MCPUIJsonGenerator.padding(
            padding: MCPUIJsonGenerator.edgeInsets(all: 16),
            child: MCPUIJsonGenerator.column(
              children: [
                // Progress indicator
                MCPUIJsonGenerator.card(
                  child: MCPUIJsonGenerator.padding(
                    padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                    child: MCPUIJsonGenerator.column(
                      children: [
                        MCPUIJsonGenerator.text(
                          'Survey Progress',
                          style: MCPUIJsonGenerator.textStyle(fontWeight: 'bold'),
                        ),
                        MCPUIJsonGenerator.sizedBox(height: 8),
                        MCPUIJsonGenerator.slider(
                          value: '{{progress}}',
                          min: 0,
                          max: 100,
                          onChange: MCPUIJsonGenerator.stateAction(
                            action: 'set',
                            binding: 'progress',
                            value: '{{event.value}}',
                          ),
                        ),
                        MCPUIJsonGenerator.text('{{progress}}% Complete'),
                      ],
                    ),
                  ),
                ),
                
                MCPUIJsonGenerator.sizedBox(height: 20),
                
                // Basic information section
                QuickBuilders.section(
                  title: 'Basic Information',
                  children: [
                    QuickBuilders.formField(
                      label: 'Full Name',
                      binding: 'survey.name',
                      placeholder: 'Enter your full name',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    QuickBuilders.formField(
                      label: 'Email',
                      binding: 'survey.email',
                      placeholder: 'Enter your email address',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    MCPUIJsonGenerator.dropdown(
                      label: 'Age Group',
                      value: '{{survey.ageGroup}}',
                      placeholder: 'Select your age group',
                      items: [
                        {'value': '18-25', 'label': '18-25 years'},
                        {'value': '26-35', 'label': '26-35 years'},
                        {'value': '36-50', 'label': '36-50 years'},
                        {'value': '51+', 'label': '51+ years'},
                      ],
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'survey.ageGroup',
                        value: '{{event.value}}',
                      ),
                    ),
                  ],
                ),
                
                MCPUIJsonGenerator.sizedBox(height: 20),
                
                // Customer type selection
                QuickBuilders.section(
                  title: 'Customer Type',
                  children: [
                    MCPUIJsonGenerator.text(
                      'Are you an existing customer?',
                      style: MCPUIJsonGenerator.textStyle(fontWeight: 'bold'),
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 8),
                    MCPUIJsonGenerator.column(
                      children: [
                        MCPUIJsonGenerator.checkbox(
                          label: 'Yes, I am an existing customer',
                          value: '{{survey.isExistingCustomer == true}}',
                          onChange: MCPUIJsonGenerator.batchAction(
                            actions: [
                              MCPUIJsonGenerator.stateAction(
                                action: 'set',
                                binding: 'survey.isExistingCustomer',
                                value: true,
                              ),
                              MCPUIJsonGenerator.stateAction(
                                action: 'set',
                                binding: 'showExistingCustomerFields',
                                value: true,
                              ),
                              MCPUIJsonGenerator.stateAction(
                                action: 'set',
                                binding: 'showNewCustomerFields',
                                value: false,
                              ),
                            ],
                          ),
                        ),
                        MCPUIJsonGenerator.checkbox(
                          label: 'No, I am a new customer',
                          value: '{{survey.isExistingCustomer == false}}',
                          onChange: MCPUIJsonGenerator.batchAction(
                            actions: [
                              MCPUIJsonGenerator.stateAction(
                                action: 'set',
                                binding: 'survey.isExistingCustomer',
                                value: false,
                              ),
                              MCPUIJsonGenerator.stateAction(
                                action: 'set',
                                binding: 'showExistingCustomerFields',
                                value: false,
                              ),
                              MCPUIJsonGenerator.stateAction(
                                action: 'set',
                                binding: 'showNewCustomerFields',
                                value: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                MCPUIJsonGenerator.sizedBox(height: 20),
                
                // Existing customer fields
                MCPUIJsonGenerator.container(
                  child: MCPUIJsonGenerator.column(
                    children: [
                      MCPUIJsonGenerator.text(
                        'Existing Customer Information',
                        style: MCPUIJsonGenerator.textStyle(
                          fontSize: 18,
                          fontWeight: 'bold',
                        ),
                      ),
                      MCPUIJsonGenerator.sizedBox(height: 16),
                      
                      QuickBuilders.formField(
                        label: 'Customer ID',
                        binding: 'survey.customerId',
                        placeholder: 'Enter your customer ID',
                      ),
                      MCPUIJsonGenerator.sizedBox(height: 16),
                      
                      MCPUIJsonGenerator.dropdown(
                        label: 'How long have you been our customer?',
                        value: '{{survey.customerDuration}}',
                        placeholder: 'Select duration',
                        items: [
                          {'value': 'less-than-1', 'label': 'Less than 1 year'},
                          {'value': '1-3', 'label': '1-3 years'},
                          {'value': '3-5', 'label': '3-5 years'},
                          {'value': 'more-than-5', 'label': 'More than 5 years'},
                        ],
                        onChange: MCPUIJsonGenerator.stateAction(
                          action: 'set',
                          binding: 'survey.customerDuration',
                          value: '{{event.value}}',
                        ),
                      ),
                      MCPUIJsonGenerator.sizedBox(height: 16),
                      
                      MCPUIJsonGenerator.slider(
                        value: '{{survey.satisfactionRating}}',
                        min: 1,
                        max: 10,
                        divisions: 9,
                        label: 'Satisfaction Rating: {{survey.satisfactionRating}}/10',
                        onChange: MCPUIJsonGenerator.stateAction(
                          action: 'set',
                          binding: 'survey.satisfactionRating',
                          value: '{{event.value}}',
                        ),
                      ),
                    ],
                  ),
                ),
                
                MCPUIJsonGenerator.sizedBox(height: 20),
                
                // New customer fields
                MCPUIJsonGenerator.container(
                  child: MCPUIJsonGenerator.column(
                    children: [
                      MCPUIJsonGenerator.text(
                        'New Customer Information',
                        style: MCPUIJsonGenerator.textStyle(
                          fontSize: 18,
                          fontWeight: 'bold',
                        ),
                      ),
                      MCPUIJsonGenerator.sizedBox(height: 16),
                      
                      MCPUIJsonGenerator.dropdown(
                        label: 'How did you hear about us?',
                        value: '{{survey.hearAboutUs}}',
                        placeholder: 'Select source',
                        items: [
                          {'value': 'social-media', 'label': 'Social Media'},
                          {'value': 'search-engine', 'label': 'Search Engine'},
                          {'value': 'friend-referral', 'label': 'Friend Referral'},
                          {'value': 'advertisement', 'label': 'Advertisement'},
                          {'value': 'other', 'label': 'Other'},
                        ],
                        onChange: MCPUIJsonGenerator.batchAction(
                          actions: [
                            MCPUIJsonGenerator.stateAction(
                              action: 'set',
                              binding: 'survey.hearAboutUs',
                              value: '{{event.value}}',
                            ),
                            MCPUIJsonGenerator.stateAction(
                              action: 'set',
                              binding: 'showOtherField',
                              value: '{{event.value == "other"}}',
                            ),
                          ],
                        ),
                      ),
                      MCPUIJsonGenerator.sizedBox(height: 16),
                      
                      // Field that appears when "Other" is selected
                      MCPUIJsonGenerator.container(
                        child: QuickBuilders.formField(
                          label: 'Please specify',
                          binding: 'survey.hearAboutUsOther',
                          placeholder: 'Tell us how you heard about us',
                        ),
                      ),
                      MCPUIJsonGenerator.sizedBox(height: 16),
                      
                      MCPUIJsonGenerator.text(
                        'What interests you most about our services?',
                        style: MCPUIJsonGenerator.textStyle(fontWeight: 'bold'),
                      ),
                      MCPUIJsonGenerator.sizedBox(height: 8),
                      MCPUIJsonGenerator.column(
                        children: [
                          MCPUIJsonGenerator.checkbox(
                            label: 'Product Quality',
                            value: '{{survey.interests.quality}}',
                            onChange: MCPUIJsonGenerator.stateAction(
                              action: 'toggle',
                              binding: 'survey.interests.quality',
                            ),
                          ),
                          MCPUIJsonGenerator.checkbox(
                            label: 'Competitive Pricing',
                            value: '{{survey.interests.pricing}}',
                            onChange: MCPUIJsonGenerator.stateAction(
                              action: 'toggle',
                              binding: 'survey.interests.pricing',
                            ),
                          ),
                          MCPUIJsonGenerator.checkbox(
                            label: 'Customer Service',
                            value: '{{survey.interests.service}}',
                            onChange: MCPUIJsonGenerator.stateAction(
                              action: 'toggle',
                              binding: 'survey.interests.service',
                            ),
                          ),
                          MCPUIJsonGenerator.checkbox(
                            label: 'Fast Delivery',
                            value: '{{survey.interests.delivery}}',
                            onChange: MCPUIJsonGenerator.stateAction(
                              action: 'toggle',
                              binding: 'survey.interests.delivery',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                MCPUIJsonGenerator.sizedBox(height: 20),
                
                // Common feedback section
                QuickBuilders.section(
                  title: 'Additional Feedback',
                  children: [
                    MCPUIJsonGenerator.textField(
                      label: 'Comments',
                      value: '{{survey.comments}}',
                      placeholder: 'Any additional comments or suggestions?',
                      maxLines: 4,
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'survey.comments',
                        value: '{{event.value}}',
                      ),
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    MCPUIJsonGenerator.checkbox(
                      label: 'I would like to receive updates about new products and services',
                      value: '{{survey.subscribeToUpdates}}',
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'toggle',
                        binding: 'survey.subscribeToUpdates',
                      ),
                    ),
                  ],
                ),
                
                MCPUIJsonGenerator.sizedBox(height: 32),
                
                // Submit buttons
                MCPUIJsonGenerator.row(
                  children: [
                    MCPUIJsonGenerator.expanded(
                      child: MCPUIJsonGenerator.button(
                        label: 'Save Draft',
                        style: 'outlined',
                        onTap: MCPUIJsonGenerator.toolAction(
                          'saveDraft',
                          args: {'survey': '{{survey}}'},
                        ),
                      ),
                    ),
                    MCPUIJsonGenerator.sizedBox(width: 16),
                    MCPUIJsonGenerator.expanded(
                      child: MCPUIJsonGenerator.button(
                        label: '{{isSubmitting ? "Submitting..." : "Submit Survey"}}',
                        style: 'elevated',
                        onTap: MCPUIJsonGenerator.batchAction(
                          actions: [
                            MCPUIJsonGenerator.stateAction(
                              action: 'set',
                              binding: 'isSubmitting',
                              value: true,
                            ),
                            MCPUIJsonGenerator.toolAction(
                              'submitSurvey',
                              args: {'survey': '{{survey}}'},
                              onSuccess: MCPUIJsonGenerator.batchAction(
                                actions: [
                                  MCPUIJsonGenerator.stateAction(
                                    action: 'set',
                                    binding: 'isSubmitting',
                                    value: false,
                                  ),
                                  MCPUIJsonGenerator.navigationAction(
                                    action: 'pushReplacement',
                                    route: '/survey-success',
                                  ),
                                ],
                              ),
                              onError: MCPUIJsonGenerator.stateAction(
                                action: 'set',
                                binding: 'isSubmitting',
                                value: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                MCPUIJsonGenerator.sizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    ),
    state: {
      'initial': {
        'progress': 0,
        'survey': {
          'name': '',
          'email': '',
          'ageGroup': '',
          'isExistingCustomer': null,
          'customerId': '',
          'customerDuration': '',
          'satisfactionRating': 5,
          'hearAboutUs': '',
          'hearAboutUsOther': '',
          'interests': {
            'quality': false,
            'pricing': false,
            'service': false,
            'delivery': false,
          },
          'comments': '',
          'subscribeToUpdates': false,
        },
        'showExistingCustomerFields': false,
        'showNewCustomerFields': false,
        'showOtherField': false,
        'isSubmitting': false,
      },
    },
  );

  MCPUIJsonGenerator.generateJsonFile(dynamicForm, 'dynamic_form.json');
  
  print('✓ Dynamic form example created: dynamic_form.json');
  print('\nKey features:');
  print('- Conditional field show/hide');
  print('- Progress display');
  print('- Various input types (text, dropdown, checkbox, slider)');
  print('- Complex state updates through batch actions');
  print('- Dynamic validation');
  print('- Draft save and final submission');
}