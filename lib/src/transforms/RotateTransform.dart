
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../../pageviewj.dart';

class RotateTransform extends PageTransform {
  final double originAngle;
  final double fineTuning;

  RotateTransform({
    this.originAngle = math.pi / 2.6,
    this.fineTuning = 14,
  });

  @override
  Widget transform(int index, double page, double aniValue, Widget child) {
    if (modifier?.scrollDirection == Axis.vertical) {
      return vertical(aniValue, index, page, child);
    } else {
      return horizontal(aniValue, index, page, child);
    }
  }

  Widget horizontal(double aniValue, int index, double page, Widget child) {
    /// 0 - origin  1 - 0
    final angle = -originAngle * aniValue + originAngle;
    if (page >= index) {
      /// _pageController.page > index 向右滑动 划出下一页 下一页可见
      return LayoutBuilder(builder: (context, constraints) {
        final halfWide = constraints.maxWidth / 2 - fineTuning;
        final offset = -halfWide * aniValue + halfWide;
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(offset, .0, .0)
            ..rotateY(-angle),
          alignment: Alignment.center,
          child: child,
        );
      });
    } else {
      /// _pageController.page < index 向下滑动 划出上一页
      return LayoutBuilder(builder: (context, constraints) {
        final halfWide = constraints.maxWidth / 2 - fineTuning;
        final offset = -halfWide * aniValue + halfWide;
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(-offset, .0, .0)
            ..rotateY(angle),
          alignment: Alignment.center,
          child: child,
        );
      });
    }
  }

  Widget vertical(double aniValue, int index, double page, Widget child) {
    /// 0 - origin  1 - 0
    final angle = -originAngle * aniValue + originAngle;
    if (page >= index) {
      /// _pageController.page > index 向右滑动 划出下一页 下一页可见
      return LayoutBuilder(builder: (context, constraints) {
        final halfWide = constraints.maxHeight / 2 - fineTuning;
        final offset = -halfWide * aniValue + halfWide;
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(.0, offset, .0)
            ..rotateX(-angle),
          alignment: Alignment.center,
          child: child,
        );
      });
    } else {
      /// _pageController.page < index 向下滑动 划出上一页
      return LayoutBuilder(builder: (context, constraints) {
        final halfWide = constraints.maxHeight / 2 - fineTuning;
        final offset = -halfWide * aniValue + halfWide;
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(.0, -offset, .0)
            ..rotateX(angle),
          alignment: Alignment.center,
          child: child,
        );
      });
    }
  }
}