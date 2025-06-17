import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

/// Login Form Example
/// 
/// This example shows how to create a login form.
/// It includes text fields, buttons, validation, and error handling.
void main() {
  // Create login page
  final loginPage = MCPUIJsonGenerator.page(
    title: 'Login',
    content: MCPUIJsonGenerator.container(
      padding: MCPUIJsonGenerator.edgeInsets(all: 24),
      child: MCPUIJsonGenerator.center(
        child: MCPUIJsonGenerator.container(
          width: 400,
          child: MCPUIJsonGenerator.card(
            elevation: 8,
            child: MCPUIJsonGenerator.padding(
              padding: MCPUIJsonGenerator.edgeInsets(all: 32),
              child: MCPUIJsonGenerator.column(
                mainAxisSize: 'min',
                children: [
                  // Logo/Title
                  MCPUIJsonGenerator.icon(
                    icon: 'lock',
                    size: 64,
                    color: '#2196F3',
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 16),
                  MCPUIJsonGenerator.text(
                    'Welcome Back',
                    style: MCPUIJsonGenerator.textStyle(
                      fontSize: 28,
                      fontWeight: 'bold',
                      color: '#333333',
                    ),
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 8),
                  MCPUIJsonGenerator.text(
                    'Please sign in to your account',
                    style: MCPUIJsonGenerator.textStyle(
                      fontSize: 16,
                      color: '#666666',
                    ),
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 32),
                  
                  // Error message (conditional display)
                  MCPUIJsonGenerator.container(
                    child: QuickBuilders.errorMessage('{{error}}'),
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 16),
                  
                  // Email input field
                  MCPUIJsonGenerator.textField(
                    label: 'Email',
                    placeholder: 'Enter your email address',
                    value: '{{email}}',
                    onChange: MCPUIJsonGenerator.batchAction(
                      actions: [
                        MCPUIJsonGenerator.stateAction(
                          action: 'set',
                          binding: 'email',
                          value: '{{event.value}}',
                        ),
                        MCPUIJsonGenerator.stateAction(
                          action: 'set',
                          binding: 'error',
                          value: '',
                        ),
                      ],
                    ),
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 16),
                  
                  // Password input field
                  MCPUIJsonGenerator.textField(
                    label: 'Password',
                    placeholder: 'Enter your password',
                    value: '{{password}}',
                    obscureText: true,
                    onChange: MCPUIJsonGenerator.batchAction(
                      actions: [
                        MCPUIJsonGenerator.stateAction(
                          action: 'set',
                          binding: 'password',
                          value: '{{event.value}}',
                        ),
                        MCPUIJsonGenerator.stateAction(
                          action: 'set',
                          binding: 'error',
                          value: '',
                        ),
                      ],
                    ),
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 8),
                  
                  // Show password checkbox
                  MCPUIJsonGenerator.row(
                    children: [
                      MCPUIJsonGenerator.checkbox(
                        value: '{{showPassword}}',
                        onChange: MCPUIJsonGenerator.stateAction(
                          action: 'toggle',
                          binding: 'showPassword',
                        ),
                      ),
                      MCPUIJsonGenerator.sizedBox(width: 8),
                      MCPUIJsonGenerator.text('Show password'),
                    ],
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 24),
                  
                  // Login button
                  MCPUIJsonGenerator.container(
                    child: MCPUIJsonGenerator.button(
                      label: '{{isLoading ? "Logging in..." : "Login"}}',
                      style: 'elevated',
                      onTap: MCPUIJsonGenerator.batchAction(
                        actions: [
                          // Start loading state
                          MCPUIJsonGenerator.stateAction(
                            action: 'set',
                            binding: 'isLoading',
                            value: true,
                          ),
                          MCPUIJsonGenerator.stateAction(
                            action: 'set',
                            binding: 'error',
                            value: '',
                          ),
                          // Login attempt
                          MCPUIJsonGenerator.toolAction(
                            'authenticate',
                            args: {
                              'email': '{{email}}',
                              'password': '{{password}}',
                            },
                            onSuccess: MCPUIJsonGenerator.batchAction(
                              actions: [
                                MCPUIJsonGenerator.stateAction(
                                  action: 'set',
                                  binding: 'isLoading',
                                  value: false,
                                ),
                                MCPUIJsonGenerator.navigationAction(
                                  action: 'pushReplacement',
                                  route: '/dashboard',
                                ),
                              ],
                            ),
                            onError: MCPUIJsonGenerator.batchAction(
                              actions: [
                                MCPUIJsonGenerator.stateAction(
                                  action: 'set',
                                  binding: 'isLoading',
                                  value: false,
                                ),
                                MCPUIJsonGenerator.stateAction(
                                  action: 'set',
                                  binding: 'error',
                                  value: '{{error.message}}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 16),
                  
                  // Forgot password link
                  MCPUIJsonGenerator.button(
                    label: 'Forgot password?',
                    style: 'text',
                    onTap: MCPUIJsonGenerator.navigationAction(
                      action: 'push',
                      route: '/forgot-password',
                    ),
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 24),
                  
                  // Divider
                  MCPUIJsonGenerator.row(
                    children: [
                      MCPUIJsonGenerator.expanded(
                        child: MCPUIJsonGenerator.divider(),
                      ),
                      MCPUIJsonGenerator.padding(
                        padding: MCPUIJsonGenerator.edgeInsets(horizontal: 16),
                        child: MCPUIJsonGenerator.text(
                          'OR',
                          style: MCPUIJsonGenerator.textStyle(color: '#999999'),
                        ),
                      ),
                      MCPUIJsonGenerator.expanded(
                        child: MCPUIJsonGenerator.divider(),
                      ),
                    ],
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 24),
                  
                  // Social login buttons
                  MCPUIJsonGenerator.row(
                    mainAxisAlignment: 'spaceEvenly',
                    children: [
                      MCPUIJsonGenerator.button(
                        label: 'Google',
                        style: 'outlined',
                        icon: 'login',
                        onTap: MCPUIJsonGenerator.toolAction('socialLogin', args: {'provider': 'google'}),
                      ),
                      MCPUIJsonGenerator.button(
                        label: 'Facebook',
                        style: 'outlined',
                        icon: 'login',
                        onTap: MCPUIJsonGenerator.toolAction('socialLogin', args: {'provider': 'facebook'}),
                      ),
                    ],
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 24),
                  
                  // Sign up link
                  MCPUIJsonGenerator.row(
                    mainAxisAlignment: 'center',
                    children: [
                      MCPUIJsonGenerator.text("Don't have an account? "),
                      MCPUIJsonGenerator.button(
                        label: 'Sign up',
                        style: 'text',
                        onTap: MCPUIJsonGenerator.navigationAction(
                          action: 'push',
                          route: '/signup',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    state: {
      'initial': {
        'email': '',
        'password': '',
        'showPassword': false,
        'isLoading': false,
        'error': '',
      },
    },
  );

  // Generate JSON file
  MCPUIJsonGenerator.generateJsonFile(loginPage, 'login_form.json');
  
  print('✓ Login form example created: login_form.json');
  print('\nKey features:');
  print('- Email/password input fields');
  print('- Real-time validation');
  print('- Loading state management');
  print('- Error message display');
  print('- Social login buttons');
  print('- Responsive layout');
}