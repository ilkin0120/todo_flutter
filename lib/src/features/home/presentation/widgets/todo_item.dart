import 'package:flutter/material.dart';
import 'package:todo_test/src/common/%20entities/todo_entity.dart';
import 'package:todo_test/src/common/extensions/build_context_ext.dart';
import 'package:todo_test/src/common/widgets/custom_check_box.dart';
import 'package:todo_test/src/common/widgets/custom_icon_button.dart';

class TodoItem extends StatelessWidget {
  final TodoEntity todo;
  final Function(String) onDeleteClick;

  // id, isCompleted
  final Function(String, bool) onCheckBoxClick;

  const TodoItem(
      {Key? key,
      required this.todo,
      required this.onDeleteClick,
      required this.onCheckBoxClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomCheckbox(
                  onClick: (value) => onCheckBoxClick(todo.id, value),
                  currentValue: todo.completed),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: context.text.bodyMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    todo.description,
                    style: context.text.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          CustomIconButton(
            onClick: () => onDeleteClick(todo.id),
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
