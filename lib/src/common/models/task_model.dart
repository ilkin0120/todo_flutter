import 'dart:convert';

class TodoModel {
  String id;
  String title;
  String description;
  bool completed;

  TodoModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.completed});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
    );
  }

  static List<TodoModel> fromJsonToList(List<dynamic> json) =>
      json.map<TodoModel>((item) => TodoModel.fromJson(item)).toList();
}
