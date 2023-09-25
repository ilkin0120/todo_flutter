import 'package:bloc/bloc.dart';
import 'package:todo_test/src/common/%20entities/todo_entity.dart';
import 'package:todo_test/src/common/request_status/request_status.dart';
import 'package:todo_test/src/features/add_task/enums/filter_enum.dart';

import '../../../data/repositories/add_task_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit()
      : super(TasksState(
            todos: [],
            filteredTodos: [],
            status: const InitialRequestStatus()));
  final todoRepository = TodoRepository();

  void onTaskDelete(String id) {
    final newTodos = state.todos;
    newTodos.removeWhere((item) => item.id == id);
    emit(state.copyWith(todos: newTodos));
  }

  void addNewTask(TodoEntity todo) {
    final newTodos = state.todos;
    newTodos.add(todo);
    emit(state.copyWith(todos: newTodos));
  }

  void filterTodos(FilterEnum filter) {
    switch (filter) {
      case FilterEnum.all:
        emit(state.copyWith(filteredTodos: state.todos));
      case FilterEnum.completed:
        final newTodos = state.todos;
        emit(state.copyWith(
            filteredTodos:
                newTodos.where((element) => element.completed).toList()));
      case FilterEnum.notCompleted:
        final newTodos = state.todos;

        emit(state.copyWith(
            filteredTodos:
                newTodos.where((element) => !element.completed).toList()));
    }
  }

  void onTaskMark(String id, bool value) {
    final newTodos = state.todos;
    // find todo with given 'id', if there is no todo with given 'id' the return the first todo
    final todo = newTodos.firstWhere((item) => item.id == id,
        orElse: () => state.todos[0]);
    todo.completed = value;
    int index = newTodos.indexOf(todo);
    newTodos[index] = todo;
    emit(state.copyWith(todos: newTodos));
  }

  void getAllTodos() async {
    emit(state.copyWith(status: const RequestSubmitting()));
    final result = await todoRepository.getTasks();
    result.when(
        error: (failure) =>
            emit(state.copyWith(status: SubmissionFailed(failure))),
        success: (todos) {
          return emit(state.copyWith(
              status: const SubmissionSuccess(),
              todos: todos,
              filteredTodos: todos));
        });
  }

  void deleteTodo(String id) async {
    onTaskDelete(id);
    final result = await todoRepository.deleteTask(id);

    result.when(
        error: (failure) =>
            emit(state.copyWith(status: SubmissionFailed(failure))),
        success: (res) {});
  }

  void markTask(String id, bool isCompleted) async {
    onTaskMark(id, isCompleted);
    final result = await todoRepository.markTask(id, isCompleted);

    result.when(
        error: (failure) =>
            emit(state.copyWith(status: SubmissionFailed(failure))),
        success: (res) {});
  }
}
