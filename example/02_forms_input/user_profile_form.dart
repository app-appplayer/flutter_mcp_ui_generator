import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import '../utils/file_writer.dart';

/// User Profile Form Example
///
/// This example shows a user profile edit form.
/// It includes various input widgets, validation, and file upload.
void main() {
  final profileForm = MCPUIJsonGenerator.page(
    title: 'Edit Profile',
    content: MCPUIJsonGenerator.column(
      children: [
        // App bar
        MCPUIJsonGenerator.appBar(
          title: 'Edit Profile',
          leading: MCPUIJsonGenerator.icon(icon: 'arrow_back'),
          actions: [
            MCPUIJsonGenerator.button(
              label: 'Save',
              style: 'text',
              click: MCPUIJsonGenerator.toolAction(
                'saveProfile',
                params: {
                  'name': '{{profile.name}}',
                  'email': '{{profile.email}}',
                  'phone': '{{profile.phone}}',
                  'bio': '{{profile.bio}}',
                  'country': '{{profile.country}}',
                  'notifications': '{{profile.notifications}}',
                  'privacy': '{{profile.privacy}}',
                },
              ),
            ),
          ],
        ),

        // Main content
        MCPUIJsonGenerator.expanded(
          child: MCPUIJsonGenerator.padding(
            padding: MCPUIJsonGenerator.edgeInsets(all: 16),
            child: MCPUIJsonGenerator.column(
              children: [
                // Profile picture section
                MCPUIJsonGenerator.card(
                  child: MCPUIJsonGenerator.padding(
                    padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                    child: MCPUIJsonGenerator.column(
                      children: [
                        MCPUIJsonGenerator.text(
                          'Profile Picture',
                          style: MCPUIJsonGenerator.textStyle(
                            fontSize: 18,
                            fontWeight: 'bold',
                          ),
                        ),
                        MCPUIJsonGenerator.sizedBox(height: 16),
                        MCPUIJsonGenerator.center(
                          child: MCPUIJsonGenerator.stack(
                            children: [
                              MCPUIJsonGenerator.container(
                                width: 100,
                                height: 100,
                                decoration: MCPUIJsonGenerator.decoration(
                                  borderRadius: 50,
                                  border: MCPUIJsonGenerator.border(
                                    color: '#E0E0E0',
                                    width: 2,
                                  ),
                                ),
                                child: MCPUIJsonGenerator.icon(
                                  icon: 'person',
                                  size: 48,
                                  color: '#BDBDBD',
                                ),
                              ),
                              MCPUIJsonGenerator.container(
                                width: 100,
                                height: 100,
                                child: MCPUIJsonGenerator.container(
                                  margin: MCPUIJsonGenerator.edgeInsets(
                                    top: 70,
                                    left: 70,
                                  ),
                                  child:
                                      MCPUIJsonGenerator.floatingActionButton(
                                    click: MCPUIJsonGenerator.toolAction(
                                        'pickImage'),
                                    child: MCPUIJsonGenerator.icon(
                                      icon: 'camera_alt',
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                MCPUIJsonGenerator.sizedBox(height: 16),

                // Basic information section
                QuickBuilders.section(
                  title: 'Basic Information',
                  children: [
                    // Name input
                    QuickBuilders.formField(
                      label: 'Full Name',
                      binding: 'profile.name',
                      placeholder: 'Enter your full name',
                      helperText: 'This will be displayed on your profile',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),

                    // Email input
                    QuickBuilders.formField(
                      label: 'Email Address',
                      binding: 'profile.email',
                      placeholder: 'Enter your email address',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),

                    // Phone number input
                    QuickBuilders.formField(
                      label: 'Phone Number',
                      binding: 'profile.phone',
                      placeholder: '+1 (555) 123-4567',
                      helperText: 'Include country code',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),

                    // Country selection
                    MCPUIJsonGenerator.dropdown(
                      label: 'Country',
                      value: '{{profile.country}}',
                      placeholder: 'Select your country',
                      items: [
                        {'value': 'kr', 'label': 'South Korea'},
                        {'value': 'us', 'label': 'United States'},
                        {'value': 'jp', 'label': 'Japan'},
                        {'value': 'cn', 'label': 'China'},
                        {'value': 'uk', 'label': 'United Kingdom'},
                        {'value': 'de', 'label': 'Germany'},
                        {'value': 'fr', 'label': 'France'},
                      ],
                      change: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'profile.country',
                        value: '{{event.value}}',
                      ),
                    ),
                  ],
                ),

                MCPUIJsonGenerator.sizedBox(height: 16),

                // About me section
                QuickBuilders.section(
                  title: 'About Me',
                  children: [
                    MCPUIJsonGenerator.textField(
                      label: 'Bio',
                      value: '{{profile.bio}}',
                      placeholder: 'Tell us about yourself...',
                      maxLines: 4,
                      helperText: 'Maximum 500 characters',
                      change: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'profile.bio',
                        value: '{{event.value}}',
                      ),
                    ),
                  ],
                ),

                MCPUIJsonGenerator.sizedBox(height: 16),

                // Settings section
                QuickBuilders.section(
                  title: 'Preferences',
                  children: [
                    // Notification settings
                    MCPUIJsonGenerator.card(
                      child: MCPUIJsonGenerator.padding(
                        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                        child: MCPUIJsonGenerator.column(
                          children: [
                            MCPUIJsonGenerator.listTile(
                              title: 'Email Notifications',
                              subtitle: 'Receive updates via email',
                              trailing: MCPUIJsonGenerator.switchWidget(
                                value: '{{profile.notifications.email}}',
                                change: MCPUIJsonGenerator.stateAction(
                                  action: 'toggle',
                                  binding: 'profile.notifications.email',
                                ),
                              ),
                            ),
                            MCPUIJsonGenerator.divider(),
                            MCPUIJsonGenerator.listTile(
                              title: 'Push Notifications',
                              subtitle: 'Receive push notifications on mobile',
                              trailing: MCPUIJsonGenerator.switchWidget(
                                value: '{{profile.notifications.push}}',
                                change: MCPUIJsonGenerator.stateAction(
                                  action: 'toggle',
                                  binding: 'profile.notifications.push',
                                ),
                              ),
                            ),
                            MCPUIJsonGenerator.divider(),
                            MCPUIJsonGenerator.listTile(
                              title: 'Marketing Communications',
                              subtitle:
                                  'Receive promotional offers and updates',
                              trailing: MCPUIJsonGenerator.switchWidget(
                                value: '{{profile.notifications.marketing}}',
                                change: MCPUIJsonGenerator.stateAction(
                                  action: 'toggle',
                                  binding: 'profile.notifications.marketing',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    MCPUIJsonGenerator.sizedBox(height: 16),

                    // Privacy settings
                    MCPUIJsonGenerator.text(
                      'Privacy Settings',
                      style: MCPUIJsonGenerator.textStyle(
                        fontSize: 16,
                        fontWeight: 'bold',
                      ),
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 8),
                    MCPUIJsonGenerator.card(
                      child: MCPUIJsonGenerator.padding(
                        padding: MCPUIJsonGenerator.edgeInsets(all: 16),
                        child: MCPUIJsonGenerator.column(
                          children: [
                            MCPUIJsonGenerator.text(
                              'Who can see your profile?',
                              style: MCPUIJsonGenerator.textStyle(
                                  fontWeight: 'bold'),
                            ),
                            MCPUIJsonGenerator.sizedBox(height: 12),
                            MCPUIJsonGenerator.column(
                              children: [
                                MCPUIJsonGenerator.checkbox(
                                  label: 'Everyone',
                                  value: '{{profile.privacy == "public"}}',
                                  change: MCPUIJsonGenerator.stateAction(
                                    action: 'set',
                                    binding: 'profile.privacy',
                                    value: 'public',
                                  ),
                                ),
                                MCPUIJsonGenerator.checkbox(
                                  label: 'Friends only',
                                  value: '{{profile.privacy == "friends"}}',
                                  change: MCPUIJsonGenerator.stateAction(
                                    action: 'set',
                                    binding: 'profile.privacy',
                                    value: 'friends',
                                  ),
                                ),
                                MCPUIJsonGenerator.checkbox(
                                  label: 'Private',
                                  value: '{{profile.privacy == "private"}}',
                                  change: MCPUIJsonGenerator.stateAction(
                                    action: 'set',
                                    binding: 'profile.privacy',
                                    value: 'private',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                MCPUIJsonGenerator.sizedBox(height: 24),

                // Action buttons
                MCPUIJsonGenerator.row(
                  children: [
                    MCPUIJsonGenerator.expanded(
                      child: MCPUIJsonGenerator.button(
                        label: 'Cancel',
                        style: 'outlined',
                        click:
                            MCPUIJsonGenerator.navigationAction(action: 'pop'),
                      ),
                    ),
                    MCPUIJsonGenerator.sizedBox(width: 16),
                    MCPUIJsonGenerator.expanded(
                      child: MCPUIJsonGenerator.button(
                        label: '{{isSaving ? "Saving..." : "Save Changes"}}',
                        style: 'elevated',
                        click: MCPUIJsonGenerator.batchAction(
                          actions: [
                            MCPUIJsonGenerator.stateAction(
                              action: 'set',
                              binding: 'isSaving',
                              value: true,
                            ),
                            MCPUIJsonGenerator.toolAction(
                              'saveProfile',
                              args: {
                                'profile': '{{profile}}',
                              },
                              onSuccess: MCPUIJsonGenerator.batchAction(
                                actions: [
                                  MCPUIJsonGenerator.stateAction(
                                    action: 'set',
                                    binding: 'isSaving',
                                    value: false,
                                  ),
                                  MCPUIJsonGenerator.navigationAction(
                                      action: 'pop'),
                                ],
                              ),
                              onError: MCPUIJsonGenerator.stateAction(
                                action: 'set',
                                binding: 'isSaving',
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
        'profile': {
          'name': 'John Doe',
          'email': 'john.doe@example.com',
          'phone': '+1 (555) 123-4567',
          'bio':
              'Software developer passionate about mobile and web technologies.',
          'country': 'us',
          'avatarUrl': '',
          'notifications': {
            'email': true,
            'push': true,
            'marketing': false,
          },
          'privacy': 'friends',
        },
        'isFormValid': true,
        'isSaving': false,
      },
    },
  );

  ExampleFileWriter.writeJsonFile(profileForm, 'user_profile_form.json');

  print('✓ User profile form example created: user_profile_form.json');
  print('\nKey features:');
  print('- Profile picture upload');
  print('- Various input fields (text, dropdown, checkbox, switch)');
  print('- Validation and helper text');
  print('- Section-based grouping');
  print('- Notification and privacy settings');
  print('- State management and save logic');
}
