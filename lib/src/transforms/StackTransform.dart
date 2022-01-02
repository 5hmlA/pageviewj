
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../../pageviewj.dart';

class StackTransform extends PageTransform {
  final double originAngle;
  final double initialScale;

  StackTransform({
    this.originAngle = math.pi / 2.6,
    this.initialScale = .8,
  });

  @override
  Widget transform(int index, double page, double aniValue, Widget child) {
    if (modifier?.scrollDirection == Axis.vertical) {
      return vertical(aniValue, index, page, child);
    } else {
      return horizontal(aniValue, index, page, child);
    }
  }

  Transform horizontal(double aniValue, int index, double page, Widget child) {
    var alignment = Alignment.centerRight;
    var value = 1 - aniValue;
    if (page >= index) {
      /// _pageController.page > index 向右滑动 划出下一页 下一页可见
      return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, -0.001)
          ..rotateY(math.pi / -2 * value),
        alignment: alignment,
        child: child,
      );
    } else {
      /// _pageController.page < index 向下滑动 划出上一页
      alignment = Alignment.centerLeft;
      var angle = originAngle - originAngle * aniValue;
      return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..scale(initialScale + 0.2 * aniValue, initialScale + 0.2 * aniValue, 1)
          ..rotateY(angle.clamp(0, math.pi / 2)),
        alignment: alignment,
        child: Opacity(opacity: .5 + .5 * aniValue.abs(), child: child),
      );
    }
  }

  Widget vertical(double aniValue, int index, double page, Widget child) {
    var alignment = Alignment.bottomCenter;
    var value = 1 - aniValue;
    if (page >= index) {
      /// _pageController.page > index 向右滑动 划出下一页 下一页可见
      return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, -0.001)
          ..rotateX(math.pi / 2 * value),
        alignment: alignment,
        child: child,
      );
    } else {
      alignment = Alignment.topCenter;
      var angle = originAngle - originAngle * aniValue;
      return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, -0.001)
          ..scale(initialScale + 0.2 * aniValue, initialScale + 0.2 * aniValue, 1)
          ..rotateX(angle.clamp(0, math.pi / 2)),
        alignment: alignment,
        child: Opacity(opacity: .5 + .5 * aniValue.abs(), child: child),
      );
    }
  }
}