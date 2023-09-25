import 'package:flutter/material.dart';
import 'package:todo_test/src/common/extensions/build_context_ext.dart';

abstract class DefaultSnackBarBase {
  static const snackBarDuration = Duration(seconds: 1);
}

class DefaultSnackBar implements DefaultSnackBarBase {
  void errorSnackBar(BuildContext context, String text) {
    _snackBarWrapper(
        context,
        Row(
          children: [
            Text(
              text,
              style:
                  context.text.bodyMedium.copyWith(fontWeight: FontWeight.w500),
            )
          ],
        ));
  }

  void _snackBarWrapper(BuildContext context, Widget child) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: context.color.background,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: context.color.primaryTextColor, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      content: child,
      duration: DefaultSnackBarBase.snackBarDuration,
    ));
  }
}
