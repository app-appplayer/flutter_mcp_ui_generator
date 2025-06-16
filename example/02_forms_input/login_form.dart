import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

/// Login Form Example
/// 
/// 이 예제는 로그인 폼을 만드는 방법을 보여줍니다.
/// 텍스트 필드, 버튼, 유효성 검사, 에러 처리 등을 포함합니다.
void main() {
  // 로그인 페이지 생성
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
                  // 로고/타이틀
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
                  
                  // 에러 메시지 (조건부 표시)
                  MCPUIJsonGenerator.container(
                    child: QuickBuilders.errorMessage('{{error}}'),
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 16),
                  
                  // 이메일 입력 필드
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
                  
                  // 비밀번호 입력 필드
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
                  
                  // 비밀번호 보기 체크박스
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
                  
                  // 로그인 버튼
                  MCPUIJsonGenerator.container(
                    child: MCPUIJsonGenerator.button(
                      label: '{{isLoading ? "Logging in..." : "Login"}}',
                      style: 'elevated',
                      onTap: MCPUIJsonGenerator.batchAction(
                        actions: [
                          // 로딩 상태 시작
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
                          // 로그인 시도
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
                  
                  // 비밀번호 찾기 링크
                  MCPUIJsonGenerator.button(
                    label: 'Forgot password?',
                    style: 'text',
                    onTap: MCPUIJsonGenerator.navigationAction(
                      action: 'push',
                      route: '/forgot-password',
                    ),
                  ),
                  MCPUIJsonGenerator.sizedBox(height: 24),
                  
                  // 구분선
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
                  
                  // 소셜 로그인 버튼들
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
                  
                  // 회원가입 링크
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

  // JSON 파일 생성
  MCPUIJsonGenerator.generateJsonFile(loginPage, 'login_form.json');
  
  print('✓ 로그인 폼 예제가 생성되었습니다: login_form.json');
  print('\n주요 기능:');
  print('- 이메일/비밀번호 입력 필드');
  print('- 실시간 유효성 검사');
  print('- 로딩 상태 관리');
  print('- 에러 메시지 표시');
  print('- 소셜 로그인 버튼');
  print('- 반응형 레이아웃');
}