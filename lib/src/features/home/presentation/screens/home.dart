import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/src/common/%20entities/todo_entity.dart';
import 'package:todo_test/src/common/extensions/build_context_ext.dart';
import 'package:todo_test/src/common/request_status/request_status.dart';
import 'package:todo_test/src/common/widgets/custom_icon_button.dart';
import 'package:todo_test/src/features/add_task/enums/filter_enum.dart';
import 'package:todo_test/src/features/add_task/presentation/cubits/tasks/tasks_cubit.dart';
import 'package:todo_test/src/features/home/presentation/widgets/filter_button.dart';
import 'package:todo_test/src/features/home/presentation/widgets/todo_item.dart';
import 'package:todo_test/src/routes/route_names.dart';

import '../../../../common/error/failures.dart';
import '../../../../common/utils/default_snackbar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          CustomIconButton(
              onClick: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext modalContext) {
                    return SizedBox(
                      height: 180,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FilterButton(
                                text: 'All',
                                onClick: () {
                                  context
                                      .read<TasksCubit>()
                                      .filterTodos(FilterEnum.all);
                                  Navigator.pop(modalContext);
                                }),
                            FilterButton(
                                text: 'Completed',
                                onClick: () {
                                  context
                                      .read<TasksCubit>()
                                      .filterTodos(FilterEnum.completed);
                                  Navigator.pop(modalContext);
                                }),
                            FilterButton(
                                text: 'Not completed',
                                onClick: () {
                                  context
                                      .read<TasksCubit>()
                                      .filterTodos(FilterEnum.notCompleted);
                                  Navigator.pop(context);
                                })
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.filter_alt_rounded))
        ],
        elevation: 0,
        backgroundColor: context.color.blue100,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, addTaskRoute).then(
            (newTask) =>
                context.read<TasksCubit>().addNewTask(newTask as TodoEntity)),
        backgroundColor: context.color.green100,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          final status = state.status;
          if (status is SubmissionFailed) {
            if (status.failure is NetworkFailure) {
              DefaultSnackBar()
                  .errorSnackBar(context, 'Отсутсвует подключение к интернету');
            } else if (status.failure is ServerFailure) {
              DefaultSnackBar().errorSnackBar(context, 'Ошибка сервера');
            } else if (status.failure is BadRequestFailure) {
              // If error's type is [BadRequestFailure] then just navigate to OtpScreen
              DefaultSnackBar().errorSnackBar(context, 'Что-то пошло не так');
            }
          }
        },
        builder: (context, state) {
          return state.status is RequestSubmitting
              ? Center(
                  child:
                      CircularProgressIndicator(color: context.color.blue100),
                )
              : SafeArea(
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: state.filteredTodos.length+1,
                      itemBuilder: (BuildContext context, int index) =>
                      index==state.filteredTodos.length?const SizedBox(height: 60,): TodoItem(
                            todo: state.filteredTodos[index],
                            onDeleteClick: (id) =>
                                context.read<TasksCubit>().deleteTodo(id),
                            onCheckBoxClick: (id, isCompleted) => context
                                .read<TasksCubit>()
                                .markTask(id, isCompleted),
                          )),
                ));
        },
      ),
    );
  }
}
