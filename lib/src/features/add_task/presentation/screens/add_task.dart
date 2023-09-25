import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/src/common/extensions/build_context_ext.dart';
import 'package:todo_test/src/common/widgets/custom_button.dart';
import 'package:todo_test/src/common/widgets/custom_icon_button.dart';
import 'package:todo_test/src/features/add_task/presentation/cubits/add_task/add_task_cubit.dart';

import '../../../../common/error/failures.dart';
import '../../../../common/request_status/request_status.dart';
import '../../../../common/utils/default_snackbar.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomIconButton(
              margin: const EdgeInsets.only(right: 10),
              onClick: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: context.color.primaryTextColor,
              ))
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text('New Task'),
        titleTextStyle:
            context.text.bodyMedium.copyWith(fontWeight: FontWeight.w500),
      ),
      body: Center(
        child: BlocConsumer<AddTaskCubit, AddTaskState>(
          listener: (context, state) {
            final status = state.status;
            if (status is SubmissionFailed) {
              if (status.failure is NetworkFailure) {
                DefaultSnackBar().errorSnackBar(
                    context, 'Отсутсвует подключение к интернету');
              } else if (status.failure is ServerFailure) {
                DefaultSnackBar().errorSnackBar(context, 'Ошибка сервера');
              } else if (status.failure is BadRequestFailure) {
                // If error's type is [BadRequestFailure] then just navigate to OtpScreen
                DefaultSnackBar().errorSnackBar(context, 'Что-то пошло не так');
              }
            } else if (status is SubmissionSuccess) {
              Navigator.pop(context,state.newTodo);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                const Spacer(),
                BlocBuilder<AddTaskCubit, AddTaskState>(
                    buildWhen: (prev, curr) =>
                        prev.status != curr.status || prev.title != curr.title,
                    builder: (context, state) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextField(
                            onChanged: (value) => context
                                .read<AddTaskCubit>()
                                .onTitleChange(value),
                            decoration:
                                const InputDecoration(hintText: 'Title'),
                            readOnly: state.status is RequestSubmitting,
                          ));
                    }),
                const SizedBox(
                  height: 40,
                ),
                BlocBuilder<AddTaskCubit, AddTaskState>(
                    buildWhen: (prev, curr) =>
                        prev.status != curr.status ||
                        prev.description != curr.description,
                    builder: (context, state) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextField(
                            onChanged: (value) => context
                                .read<AddTaskCubit>()
                                .onDescriptionChange(value),
                            decoration:
                                const InputDecoration(hintText: 'Description'),
                            readOnly: state.status is RequestSubmitting,
                          ));
                    }),
                const Spacer(),
                BlocBuilder<AddTaskCubit, AddTaskState>(
                    builder: (context, state) {
                  return CustomButton(
                    label: Text(
                      state.status is RequestSubmitting ? 'Loading' : 'Add',
                      style:
                          context.text.bodyMedium.copyWith(color: Colors.white),
                    ),
                    onClick: () {
                      if (state.title.isNotEmpty &&
                          state.description.isNotEmpty &&
                          state.status is! RequestSubmitting) {
                        context.read<AddTaskCubit>().addTask();
                      }
                    },
                    buttonStyle: BoxDecoration(
                      color: context.color.green100,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  );
                })
              ],
            );
          },
        ),
      ),
    );
  }
}
