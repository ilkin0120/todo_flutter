import 'package:bloc/bloc.dart';
import 'package:todo_test/src/common/%20entities/todo_entity.dart';
import 'package:todo_test/src/features/add_task/data/repositories/add_task_repository.dart';

import '../../../../../common/request_status/request_status.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit()
      : super(AddTaskState(
            title: '',
            description: '',
            status: const InitialRequestStatus(),
            newTodo: TodoEntity(
                completed: false, description: '', title: '', id: '')));
  final todoRepository = TodoRepository();

  void onTitleChange(String title) {
    emit(state.copyWith(title: title));
  }

  void onDescriptionChange(String description) {
    emit(state.copyWith(description: description));
  }

  void addTask() async {
    emit(state.copyWith(status: const RequestSubmitting()));
    final result = await todoRepository.addTask(state.title, state.description);
    result.when(
        error: (failure) {
          return emit(state.copyWith(status: SubmissionFailed(failure)));
        },
        success: (data) => emit(
            state.copyWith(status: const SubmissionSuccess(), newTodo: data)));
  }
}
