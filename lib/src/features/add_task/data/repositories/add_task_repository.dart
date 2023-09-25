import 'package:todo_test/src/common/%20entities/todo_entity.dart';
import 'package:todo_test/src/common/error/failures.dart';
import 'package:todo_test/src/common/utils/either.dart';
import 'package:todo_test/src/features/add_task/data/services/todo_service.dart';
import 'package:todo_test/src/features/add_task/domain/repositories/todo_repository_base.dart';

import '../../../../common/error/exceptions.dart';
import '../../../../common/utils/network_checker.dart';

class TodoRepository implements TodoRepositoryBase {
  final todoService = TodoService();
  final networkChecker = NetworkChecker();

  @override
  Future<Either<Failure, TodoEntity>> addTask(
      String title, String description) async {
    final isConnected = await networkChecker.checkInternetConnectivity();

    if (isConnected) {
      try {
        final result = await todoService.addTask(title, description);
        final TodoEntity entity = TodoEntity.fromModel(result);
        return Success(entity);
      } on BadRequestException {
        return Error(BadRequestFailure());
      } on ServerException {
        return Error(ServerFailure());
      } catch (e) {
        return Error(OtherFailure());
      }
    } else {
      return Error(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getTasks() async {
    final isConnected = await networkChecker.checkInternetConnectivity();

    if (isConnected) {
      try {
        final result = await todoService.getTasks();

        return Success(TodoEntity.fromModelList(result));
      } on BadRequestException {
        return Error(BadRequestFailure());
      } on ServerException {
        return Error(ServerFailure());
      } catch (e) {
        return Error(OtherFailure());
      }
    } else {
      return Error(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    final isConnected = await networkChecker.checkInternetConnectivity();

    if (isConnected) {
      try {
        final result = await todoService.deleteTask(id);

        return Success(result);
      } on BadRequestException {
        return Error(BadRequestFailure());
      } on ServerException {
        return Error(ServerFailure());
      } catch (e) {
        return Error(OtherFailure());
      }
    } else {
      return Error(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> markTask(String id, bool isCompleted) async {
    final isConnected = await networkChecker.checkInternetConnectivity();

    if (isConnected) {
      try {
        final result = await todoService.markTask(id, isCompleted);

        return Success(result);
      } on BadRequestException {
        return Error(BadRequestFailure());
      } on ServerException {
        return Error(ServerFailure());
      } catch (e) {
        return Error(OtherFailure());
      }
    } else {
      return Error(NetworkFailure());
    }
  }
}
