import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';
import '../utils/file_writer.dart';

/// Todo List Application Example
///
/// This example shows a complete todo list app.
/// It includes features like state management, CRUD operations, filtering, and search.
void main() {
  final todoApp = MCPUIJsonGenerator.page(
    title: 'Todo List',
    content: MCPUIJsonGenerator.column(
      children: [
        // App bar with search
        MCPUIJsonGenerator.appBar(
          title: 'My Todos',
          actions: [
            MCPUIJsonGenerator.button(
              label: '',
              style: 'text',
              icon: 'search',
              click: MCPUIJsonGenerator.stateAction(
                action: 'toggle',
                binding: 'showSearch',
              ),
            ),
            MCPUIJsonGenerator.button(
              label: '',
              style: 'text',
              icon: 'filter_list',
              click: MCPUIJsonGenerator.stateAction(
                action: 'toggle',
                binding: 'showFilters',
              ),
            ),
          ],
        ),

        // Search bar (conditional display)
        MCPUIJsonGenerator.container(
          child: MCPUIJsonGenerator.padding(
            padding: MCPUIJsonGenerator.edgeInsets(all: 16),
            child: MCPUIJsonGenerator.textField(
              label: 'Search todos',
              value: '{{searchQuery}}',
              placeholder: 'Type to search...',
              change: MCPUIJsonGenerator.stateAction(
                action: 'set',
                binding: 'searchQuery',
                value: '{{event.value}}',
              ),
            ),
          ),
        ),

        // Filter chips (conditional display)
        MCPUIJsonGenerator.container(
          child: MCPUIJsonGenerator.padding(
            padding: MCPUIJsonGenerator.edgeInsets(horizontal: 16, vertical: 8),
            child: MCPUIJsonGenerator.row(
              children: [
                MCPUIJsonGenerator.button(
                  label: 'All ({{totalCount}})',
                  style: '{{currentFilter == "all" ? "elevated" : "outlined"}}',
                  click: MCPUIJsonGenerator.stateAction(
                    action: 'set',
                    binding: 'currentFilter',
                    value: 'all',
                  ),
                ),
                MCPUIJsonGenerator.sizedBox(width: 8),
                MCPUIJsonGenerator.button(
                  label: 'Active ({{activeCount}})',
                  style:
                      '{{currentFilter == "active" ? "elevated" : "outlined"}}',
                  click: MCPUIJsonGenerator.stateAction(
                    action: 'set',
                    binding: 'currentFilter',
                    value: 'active',
                  ),
                ),
                MCPUIJsonGenerator.sizedBox(width: 8),
                MCPUIJsonGenerator.button(
                  label: 'Done ({{completedCount}})',
                  style:
                      '{{currentFilter == "completed" ? "elevated" : "outlined"}}',
                  click: MCPUIJsonGenerator.stateAction(
                    action: 'set',
                    binding: 'currentFilter',
                    value: 'completed',
                  ),
                ),
              ],
            ),
          ),
        ),

        // Add new todo
        MCPUIJsonGenerator.padding(
          padding: MCPUIJsonGenerator.edgeInsets(all: 16),
          child: MCPUIJsonGenerator.row(
            children: [
              MCPUIJsonGenerator.expanded(
                child: MCPUIJsonGenerator.textField(
                  label: 'Add new todo',
                  value: '{{newTodoText}}',
                  placeholder: 'What needs to be done?',
                  change: MCPUIJsonGenerator.stateAction(
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
                click: MCPUIJsonGenerator.batchAction(
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

        // Priority selection
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
                change: MCPUIJsonGenerator.stateAction(
                  action: 'set',
                  binding: 'newTodoPriority',
                  value: '{{event.value}}',
                ),
              ),
            ],
          ),
        ),

        MCPUIJsonGenerator.divider(),

        // Todo list
        MCPUIJsonGenerator.expanded(
          child: MCPUIJsonGenerator.listView(
            items: '{{filteredTodos}}',
            itemSpacing: 4,
            itemTemplate: MCPUIJsonGenerator.card(
              margin:
                  MCPUIJsonGenerator.edgeInsets(horizontal: 16, vertical: 4),
              child: MCPUIJsonGenerator.listTile(
                leading: MCPUIJsonGenerator.checkbox(
                  value: '{{item.completed}}',
                  change: MCPUIJsonGenerator.toolAction(
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
                      click: MCPUIJsonGenerator.batchAction(
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
                      click: MCPUIJsonGenerator.toolAction(
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

        // Bottom statistics
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
                click: MCPUIJsonGenerator.toolAction('clearCompleted'),
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

  ExampleFileWriter.writeJsonFile(todoApp, 'todo_list.json');
  print('\nKey features:');
  print('- CRUD operations (Create, Read, Update, Delete)');
  print('- Real-time filtering (All, Active, Completed)');
  print('- Search functionality');
  print('- Priority settings');
  print('- Statistics display');
  print('- Batch actions (Update multiple states simultaneously)');
}
