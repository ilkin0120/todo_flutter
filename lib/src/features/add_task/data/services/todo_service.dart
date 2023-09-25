import 'package:dio/dio.dart';
import 'package:todo_test/src/common/models/task_model.dart';

import '../../../../common/error/exceptions.dart';
import '../../../../config/config.dart';

abstract class TodoServiceBase {
  Future<TodoModel> addTask(String title, String description);

  Future<List<TodoModel>> getTasks();

  Future<void> deleteTask(String id);

  Future<void> markTask(String id, bool isCompleted);
}

class TodoService implements TodoServiceBase {
  final dio = Dio();

  @override
  Future<TodoModel> addTask(String title, String description) async {
    try {
      final response = await dio.post('${Configs.apiLink}/',
          data: {'title': title, 'description': description});
      return TodoModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          throw BadRequestException();
        } else {
          throw ServerException();
        }
      }
      throw OtherException();
    }
  }

  @override
  Future<List<TodoModel>> getTasks() async {
    try {
      final response = await dio.get(
        '${Configs.apiLink}/',
      );
      return TodoModel.fromJsonToList(response.data);
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          throw BadRequestException();
        } else {
          throw ServerException();
        }
      }
      throw OtherException();
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await dio.delete(
        '${Configs.apiLink}/$id',
      );
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          throw BadRequestException();
        } else {
          throw ServerException();
        }
      }
      throw OtherException();
    }
  }

  @override
  Future<void> markTask(String id, bool isCompleted) async {
    try {
      await dio
          .patch('${Configs.apiLink}/$id', data: {'completed': isCompleted});
    } catch (e) {
      print(e);
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          throw BadRequestException();
        } else {
          throw ServerException();
        }
      }
      throw OtherException();
    }
  }
}
