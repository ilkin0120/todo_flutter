import 'package:flutter/material.dart';
import 'package:todo_test/src/common/extensions/build_context_ext.dart';

class CustomCheckbox extends StatelessWidget {
  final bool currentValue;
  final Function(bool) onClick;

  const CustomCheckbox({
    Key? key,
    required this.onClick,
    required this.currentValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(!currentValue),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: currentValue ? context.color.green100 : null,
            border: Border.all(
                color: currentValue
                    ? context.color.green100
                    : context.color.primaryTextColor,
                width: 2)),
        child: currentValue
            ? const Icon(
                Icons.check,
                size: 15,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
