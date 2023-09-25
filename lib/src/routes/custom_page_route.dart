import 'package:flutter/material.dart';

import '../constants/ui_constants.dart';

enum AnimationType { slideFromRight, sliderFromLeft }

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  AnimationType animationType;

  CustomPageRoute(
      {required WidgetBuilder builder,
        super.settings,
        this.animationType = AnimationType.slideFromRight})
      : super(
    builder: builder,
  );

  @override
  Duration get transitionDuration => UiConstants.fastAnimationDuration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final begin = getInitialAndFinalOffset()[0];
    final end = getInitialAndFinalOffset()[1];
    var tween = Tween(begin: begin, end: end);

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  List<Offset> getInitialAndFinalOffset() {
    switch (animationType) {
      case AnimationType.slideFromRight:
        return [const Offset(1.0, 0.0), Offset.zero];
      case AnimationType.sliderFromLeft:
        return [const Offset(-1.0, 0.0), Offset.zero];
    }
  }
}
