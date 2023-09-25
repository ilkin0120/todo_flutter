import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_test/src/common/extensions/build_context_ext.dart';
class FilterButton extends StatelessWidget {
  final VoidCallback onClick;
  final String text;
  const FilterButton({Key? key,required this.text,required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onClick,
      child: Container(
        margin:
        const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          text,
          style: context.text.bodyMedium,
        ),
      ),
    );
  }
}
