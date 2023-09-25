import 'package:todo_test/src/common/%20entities/todo_entity.dart';

import '../../../../common/error/failures.dart';
import '../../../../common/utils/either.dart';

abstract class TodoRepositoryBase {
  Future<Either<Failure, TodoEntity>> addTask(String title, String description);

  Future<Either<Failure, List<TodoEntity>>> getTasks();

  Future<Either<Failure, void>> deleteTask(String id);

  Future<Either<Failure, void>> markTask(String id, bool isCompleted);
}
