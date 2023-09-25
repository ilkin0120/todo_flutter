import '../models/task_model.dart';

class TodoEntity {
  String id;
  String title;
  String description;
  bool completed;

  TodoEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.completed});

  factory TodoEntity.fromModel(TodoModel model) {
    return TodoEntity(
        id: model.id,
        title: model.title,
        description: model.description,
        completed: model.completed);
  }

  static List<TodoEntity> fromModelList(List<TodoModel> todos) =>
      todos.map<TodoEntity>((item) => TodoEntity.fromModel(item)).toList();
}
