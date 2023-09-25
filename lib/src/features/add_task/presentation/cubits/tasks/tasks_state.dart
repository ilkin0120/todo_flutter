part of 'tasks_cubit.dart';

class TasksState {
  List<TodoEntity> todos;
  List<TodoEntity> filteredTodos;
  RequestStatus status;

  TasksState({required this.todos, required this.status,required this.filteredTodos});

  TasksState copyWith({List<TodoEntity>? todos,List<TodoEntity>? filteredTodos, RequestStatus? status}) {
    return TasksState(
        todos: todos ?? this.todos,filteredTodos: filteredTodos??this.filteredTodos, status: status ?? this.status);
  }
}
