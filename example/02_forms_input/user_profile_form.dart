import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

/// User Profile Form Example
/// 
/// 이 예제는 사용자 프로필 편집 폼을 보여줍니다.
/// 다양한 입력 위젯들과 유효성 검사, 파일 업로드 등을 포함합니다.
void main() {
  final profileForm = MCPUIJsonGenerator.page(
    title: 'Edit Profile',
    content: MCPUIJsonGenerator.column(
      children: [
        // 앱바
        MCPUIJsonGenerator.appBar(
          title: 'Edit Profile',
          leading: MCPUIJsonGenerator.icon(icon: 'arrow_back'),
          actions: [
            MCPUIJsonGenerator.button(
              label: 'Save',
              style: 'text',
              onTap: MCPUIJsonGenerator.toolAction(
                'saveProfile',
                args: {
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
        
        // 메인 콘텐츠
        MCPUIJsonGenerator.expanded(
          child: MCPUIJsonGenerator.padding(
            padding: MCPUIJsonGenerator.edgeInsets(all: 16),
            child: MCPUIJsonGenerator.column(
              children: [
                // 프로필 사진 섹션
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
                                  child: MCPUIJsonGenerator.floatingActionButton(
                                    onPressed: MCPUIJsonGenerator.toolAction('pickImage'),
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
                
                // 기본 정보 섹션
                QuickBuilders.section(
                  title: 'Basic Information',
                  children: [
                    // 이름 입력
                    QuickBuilders.formField(
                      label: 'Full Name',
                      binding: 'profile.name',
                      placeholder: 'Enter your full name',
                      helperText: 'This will be displayed on your profile',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    // 이메일 입력
                    QuickBuilders.formField(
                      label: 'Email Address',
                      binding: 'profile.email',
                      placeholder: 'Enter your email address',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    // 전화번호 입력
                    QuickBuilders.formField(
                      label: 'Phone Number',
                      binding: 'profile.phone',
                      placeholder: '+1 (555) 123-4567',
                      helperText: 'Include country code',
                    ),
                    MCPUIJsonGenerator.sizedBox(height: 16),
                    
                    // 국가 선택
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
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'profile.country',
                        value: '{{event.value}}',
                      ),
                    ),
                  ],
                ),
                
                MCPUIJsonGenerator.sizedBox(height: 16),
                
                // 자기소개 섹션
                QuickBuilders.section(
                  title: 'About Me',
                  children: [
                    MCPUIJsonGenerator.textField(
                      label: 'Bio',
                      value: '{{profile.bio}}',
                      placeholder: 'Tell us about yourself...',
                      maxLines: 4,
                      helperText: 'Maximum 500 characters',
                      onChange: MCPUIJsonGenerator.stateAction(
                        action: 'set',
                        binding: 'profile.bio',
                        value: '{{event.value}}',
                      ),
                    ),
                  ],
                ),
                
                MCPUIJsonGenerator.sizedBox(height: 16),
                
                // 설정 섹션
                QuickBuilders.section(
                  title: 'Preferences',
                  children: [
                    // 알림 설정
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
                                onChange: MCPUIJsonGenerator.stateAction(
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
                                onChange: MCPUIJsonGenerator.stateAction(
                                  action: 'toggle',
                                  binding: 'profile.notifications.push',
                                ),
                              ),
                            ),
                            MCPUIJsonGenerator.divider(),
                            MCPUIJsonGenerator.listTile(
                              title: 'Marketing Communications',
                              subtitle: 'Receive promotional offers and updates',
                              trailing: MCPUIJsonGenerator.switchWidget(
                                value: '{{profile.notifications.marketing}}',
                                onChange: MCPUIJsonGenerator.stateAction(
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
                    
                    // 프라이버시 설정
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
                              style: MCPUIJsonGenerator.textStyle(fontWeight: 'bold'),
                            ),
                            MCPUIJsonGenerator.sizedBox(height: 12),
                            MCPUIJsonGenerator.column(
                              children: [
                                MCPUIJsonGenerator.checkbox(
                                  label: 'Everyone',
                                  value: '{{profile.privacy == "public"}}',
                                  onChange: MCPUIJsonGenerator.stateAction(
                                    action: 'set',
                                    binding: 'profile.privacy',
                                    value: 'public',
                                  ),
                                ),
                                MCPUIJsonGenerator.checkbox(
                                  label: 'Friends only',
                                  value: '{{profile.privacy == "friends"}}',
                                  onChange: MCPUIJsonGenerator.stateAction(
                                    action: 'set',
                                    binding: 'profile.privacy',
                                    value: 'friends',
                                  ),
                                ),
                                MCPUIJsonGenerator.checkbox(
                                  label: 'Private',
                                  value: '{{profile.privacy == "private"}}',
                                  onChange: MCPUIJsonGenerator.stateAction(
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
                
                // 액션 버튼들
                MCPUIJsonGenerator.row(
                  children: [
                    MCPUIJsonGenerator.expanded(
                      child: MCPUIJsonGenerator.button(
                        label: 'Cancel',
                        style: 'outlined',
                        onTap: MCPUIJsonGenerator.navigationAction(action: 'pop'),
                      ),
                    ),
                    MCPUIJsonGenerator.sizedBox(width: 16),
                    MCPUIJsonGenerator.expanded(
                      child: MCPUIJsonGenerator.button(
                        label: '{{isSaving ? "Saving..." : "Save Changes"}}',
                        style: 'elevated',
                                  onTap: MCPUIJsonGenerator.batchAction(
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
                                  MCPUIJsonGenerator.navigationAction(action: 'pop'),
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
          'bio': 'Software developer passionate about mobile and web technologies.',
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

  MCPUIJsonGenerator.generateJsonFile(profileForm, 'user_profile_form.json');
  
  print('✓ 사용자 프로필 폼 예제가 생성되었습니다: user_profile_form.json');
  print('\n주요 기능:');
  print('- 프로필 사진 업로드');
  print('- 다양한 입력 필드 (텍스트, 드롭다운, 체크박스, 스위치)');
  print('- 유효성 검사와 헬퍼 텍스트');
  print('- 섹션별 그룹화');
  print('- 알림 및 프라이버시 설정');
  print('- 상태 관리와 저장 로직');
}