import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

/// Todo List Application Example
/// 
/// 이 예제는 완전한 할일 목록 앱을 보여줍니다.
/// 상태 관리, CRUD 작업, 필터링, 검색 등의 기능을 포함합니다.
void main() {
  final todoApp = MCPUIJsonGenerator.page(
    title: 'Todo List',
    content: MCPUIJsonGenerator.column(
      children: [
        // 앱바 with 검색
        MCPUIJsonGenerator.appBar(
          title: 'My Todos',
          actions: [
            MCPUIJsonGenerator.button(
              label: '',
              style: 'text',
              icon: 'search',
              onTap: MCPUIJsonGenerator.stateAction(
                action: 'toggle',
                binding: 'showSearch',
              ),
            ),
            MCPUIJsonGenerator.button(
              label: '',
              style: 'text', 
              icon: 'filter_list',
              onTap: MCPUIJsonGenerator.stateAction(
                action: 'toggle',
                binding: 'showFilters',
              ),
            ),
          ],
        ),
        
        // 검색바 (조건부 표시)
        MCPUIJsonGenerator.container(
          child: MCPUIJsonGenerator.padding(
            padding: MCPUIJsonGenerator.edgeInsets(all: 16),
            child: MCPUIJsonGenerator.textField(
              label: 'Search todos',
              value: '{{searchQuery}}',
              placeholder: 'Type to search...',
              onChange: MCPUIJsonGenerator.stateAction(
                action: 'set',
                binding: 'searchQuery',
                value: '{{event.value}}',
              ),
            ),
          ),
        ),
        
        // 필터 칩들 (조건부 표시)
        MCPUIJsonGenerator.container(
          child: MCPUIJsonGenerator.padding(
            padding: MCPUIJsonGenerator.edgeInsets(horizontal: 16, vertical: 8),
            child: MCPUIJsonGenerator.row(
              children: [
                MCPUIJsonGenerator.button(
                  label: 'All ({{totalCount}})',
                  style: '{{currentFilter == "all" ? "elevated" : "outlined"}}',
                  onTap: MCPUIJsonGenerator.stateAction(
                    action: 'set',
                    binding: 'currentFilter',
                    value: 'all',
                  ),
                ),
                MCPUIJsonGenerator.sizedBox(width: 8),
                MCPUIJsonGenerator.button(
                  label: 'Active ({{activeCount}})',
                  style: '{{currentFilter == "active" ? "elevated" : "outlined"}}',
                  onTap: MCPUIJsonGenerator.stateAction(
                    action: 'set',
                    binding: 'currentFilter',
                    value: 'active',
                  ),
                ),
                MCPUIJsonGenerator.sizedBox(width: 8),
                MCPUIJsonGenerator.button(
                  label: 'Done ({{completedCount}})',
                  style: '{{currentFilter == "completed" ? "elevated" : "outlined"}}',
                  onTap: MCPUIJsonGenerator.stateAction(
                    action: 'set',
                    binding: 'currentFilter',
                    value: 'completed',
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // 새 할일 추가
        MCPUIJsonGenerator.padding(
          padding: MCPUIJsonGenerator.edgeInsets(all: 16),
          child: MCPUIJsonGenerator.row(
            children: [
              MCPUIJsonGenerator.expanded(
                child: MCPUIJsonGenerator.textField(
                  label: 'Add new todo',
                  value: '{{newTodoText}}',
                  placeholder: 'What needs to be done?',
                  onChange: MCPUIJsonGenerator.stateAction(
                    action: 'set',
                    binding: 'newTodoText',
                    value: '{{event.value}}',
                  ),
                ),
              ),
              MCPUIJsonGenerator.sizedBox(width: 8),
              MCPUIJsonGenerator.button(
                label: 'Add',
                style: 'elevated',
                icon: 'add',
                onTap: MCPUIJsonGenerator.batchAction(
                  actions: [
                    MCPUIJsonGenerator.toolAction(
                      'addTodo',
                      args: {
                        'text': '{{newTodoText}}',
                        'priority': '{{newTodoPriority}}',
                      },
                    ),
                    MCPUIJsonGenerator.stateAction(
                      action: 'set',
                      binding: 'newTodoText',
                      value: '',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // 우선순위 선택
        MCPUIJsonGenerator.padding(
          padding: MCPUIJsonGenerator.edgeInsets(horizontal: 16),
          child: MCPUIJsonGenerator.row(
            children: [
              MCPUIJsonGenerator.text('Priority: '),
              MCPUIJsonGenerator.dropdown(
                value: '{{newTodoPriority}}',
                items: [
                  {'value': 'low', 'label': '🟢 Low'},
                  {'value': 'medium', 'label': '🟡 Medium'},
                  {'value': 'high', 'label': '🔴 High'},
                ],
                onChange: MCPUIJsonGenerator.stateAction(
                  action: 'set',
                  binding: 'newTodoPriority',
                  value: '{{event.value}}',
                ),
              ),
            ],
          ),
        ),
        
        MCPUIJsonGenerator.divider(),
        
        // 할일 목록
        MCPUIJsonGenerator.expanded(
          child: MCPUIJsonGenerator.listView(
            items: '{{filteredTodos}}',
            itemSpacing: 4,
            itemTemplate: MCPUIJsonGenerator.card(
              margin: MCPUIJsonGenerator.edgeInsets(horizontal: 16, vertical: 4),
              child: MCPUIJsonGenerator.listTile(
                leading: MCPUIJsonGenerator.checkbox(
                  value: '{{item.completed}}',
                  onChange: MCPUIJsonGenerator.toolAction(
                    'toggleTodo',
                    args: {'id': '{{item.id}}'},
                  ),
                ),
                title: '{{item.text}}',
                subtitle: '{{item.priority}} priority • {{item.createdAt}}',
                trailing: MCPUIJsonGenerator.row(
                  mainAxisSize: 'min',
                  children: [
                    MCPUIJsonGenerator.button(
                      label: '',
                      style: 'text',
                      icon: 'edit',
                      onTap: MCPUIJsonGenerator.batchAction(
                        actions: [
                          MCPUIJsonGenerator.stateAction(
                            action: 'set',
                            binding: 'editingTodo',
                            value: '{{item}}',
                          ),
                          MCPUIJsonGenerator.stateAction(
                            action: 'set',
                            binding: 'showEditDialog',
                            value: true,
                          ),
                        ],
                      ),
                    ),
                    MCPUIJsonGenerator.button(
                      label: '',
                      style: 'text',
                      icon: 'delete',
                      onTap: MCPUIJsonGenerator.toolAction(
                        'deleteTodo',
                        args: {'id': '{{item.id}}'},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        
        // 하단 통계
        MCPUIJsonGenerator.container(
          padding: MCPUIJsonGenerator.edgeInsets(all: 16),
          decoration: MCPUIJsonGenerator.decoration(
            color: '#F5F5F5',
            border: MCPUIJsonGenerator.border(
              color: '#E0E0E0',
              width: 1,
            ),
          ),
          child: MCPUIJsonGenerator.row(
            mainAxisAlignment: 'spaceBetween',
            children: [
              MCPUIJsonGenerator.text(
                '{{totalCount}} total',
                style: MCPUIJsonGenerator.textStyle(fontWeight: 'bold'),
              ),
              MCPUIJsonGenerator.text(
                '{{completedCount}} completed',
                style: MCPUIJsonGenerator.textStyle(color: '#4CAF50'),
              ),
              MCPUIJsonGenerator.button(
                label: 'Clear Completed',
                style: 'text',
                onTap: MCPUIJsonGenerator.toolAction('clearCompleted'),
              ),
            ],
          ),
        ),
      ],
    ),
    state: {
      'initial': {
        'todos': [
          {
            'id': '1',
            'text': 'Learn Flutter MCP UI Generator',
            'completed': false,
            'priority': 'high',
            'createdAt': '2024-01-15',
          },
          {
            'id': '2',
            'text': 'Build a todo app',
            'completed': true,
            'priority': 'medium',
            'createdAt': '2024-01-14',
          },
          {
            'id': '3',
            'text': 'Write documentation',
            'completed': false,
            'priority': 'low',
            'createdAt': '2024-01-13',
          },
        ],
        'filteredTodos': [],
        'newTodoText': '',
        'newTodoPriority': 'medium',
        'searchQuery': '',
        'currentFilter': 'all',
        'showSearch': false,
        'showFilters': true,
        'showEditDialog': false,
        'editingTodo': null,
        'totalCount': 3,
        'activeCount': 2,
        'completedCount': 1,
      },
    },
    lifecycle: {
      'onInit': [
        MCPUIJsonGenerator.toolAction('loadTodos'),
        MCPUIJsonGenerator.toolAction('updateCounts'),
      ],
    },
  );

  MCPUIJsonGenerator.generateJsonFile(todoApp, 'todo_list.json');
  
  print('✓ 할일 목록 앱이 생성되었습니다: todo_list.json');
  print('\n주요 기능:');
  print('- CRUD 작업 (생성, 읽기, 업데이트, 삭제)');
  print('- 실시간 필터링 (전체, 활성, 완료)');
  print('- 검색 기능');
  print('- 우선순위 설정');
  print('- 통계 표시');
  print('- 배치 액션 (여러 상태 동시 업데이트)');
}