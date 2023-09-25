part of 'add_task_cubit.dart';

class AddTaskState {
  String title;
  String description;
  TodoEntity newTodo;
  RequestStatus status;

  AddTaskState(
      {required this.title,
      required this.description,
      required this.status,
      required this.newTodo});

  AddTaskState copyWith(
      {String? title,
      String? description,
      TodoEntity? newTodo,
      RequestStatus? status}) {
    return AddTaskState(
        newTodo: newTodo ?? this.newTodo,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status);
  }
}
