import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../../pageviewj.dart';

class CubeTransform extends PageTransform {
  CubeTransform();

  @override
  Widget transform(int index, double page, double aniValue, Widget child) {
    if (aniValue < 0) {
      return const SizedBox();
    }
    if (modifier?.scrollDirection == Axis.vertical) {
      return vertical(aniValue, index, page, child);
    } else {
      return horizontal(aniValue, index, page, child);
    }
  }

  Widget horizontal(double aniValue, int index, double page, Widget child) {
    var alignment = Alignment.centerRight;
    var value = 1 - aniValue;
    if (page >= index) {
      /// _pageController.page > index 向右滑动 划出下一页 下一页可见
      alignment = Alignment.centerRight;
      value = 1 - aniValue;
    } else {
      /// _pageController.page < index 向左滑动 划出上一页
      alignment = Alignment.centerLeft;
      value = aniValue - 1;
    }
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(math.pi / 2 * value),
      alignment: alignment,
      child: child,
    );
  }

  Widget vertical(double aniValue, int index, double page, Widget child) {
    var alignment = Alignment.centerRight;
    var value = 1 - aniValue;
    if (page >= index) {
      /// _pageController.page > index 向上滑动 划出下一页 下一页可见
      alignment = Alignment.bottomCenter;
      value = 1 - aniValue;
    } else {
      /// _pageController.page < index 向下滑动 划出上一页
      alignment = Alignment.topCenter;
      value = aniValue - 1;
    }
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, -0.001)
        ..rotateX(math.pi / 2 * value),
      alignment: alignment,
      child: child,
    );
  }
}

class ShuttersCubeTransform extends CubeTransform {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);

  int current = 0;
  int shutterSize = 6;
  double delay = .1;

  ShuttersCubeTransform();

  @override
  Widget horizontal(double aniValue, int index, double page, Widget child) {
    delay = delay.clamp(0, 1 / shutterSize);
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: List.generate(shutterSize, (indexSub) {
          double intervalAni = 0;

          if (page > index) {
            intervalAni = Interval(indexSub * delay, 1 - (shutterSize - indexSub) * delay).transform(aniValue.abs());
            // return SizedBox.shrink();
          } else {
            int sub = shutterSize - indexSub;
            intervalAni = Interval(sub * delay, 1 - (shutterSize - sub) * delay).transform(aniValue.abs());
          }

          return ClipRect(
            child: Align(
              heightFactor: 1 / shutterSize,
              alignment: FractionalOffset(0, indexSub / (shutterSize - 1)),
              child: SizedBox(
                height: constraints.maxHeight,
                child: super.horizontal(intervalAni, index, page, child),
              ),
            ),
          );
        }),
      );
    });
  }

  @override
  Widget vertical(double aniValue, int index, double page, Widget child) {
    return Row(
      children: List.generate(shutterSize, (indexSub) {
        double intervalAni = 0;

        // if (page > index) {
        //   intervalAni = Interval(indexSub / shutterSize, (indexSub + 1) / shutterSize).transform(aniValue.abs());
        //   // return SizedBox.shrink();
        // } else {
        //   intervalAni = Interval((shutterSize - indexSub - 1) / shutterSize, (shutterSize - indexSub) / shutterSize)
        //       .transform(aniValue.abs());
        // }

        if (page > index) {
          intervalAni = Interval(indexSub * delay, 1 - (shutterSize - indexSub) * delay).transform(aniValue.abs());
          // return SizedBox.shrink();
        } else {
          int sub = shutterSize - indexSub;
          intervalAni = Interval(sub * delay, 1 - (shutterSize - sub) * delay).transform(aniValue.abs());
        }

        return ClipRect(
          child: Align(
            widthFactor: 1 / shutterSize,
            alignment: FractionalOffset(indexSub / (shutterSize - 1), 0),
            child: SizedBox(
              width: mediaQuery.size.width,
              child: super.vertical(intervalAni, index, page, child),
            ),
          ),
        );
      }),
    );
  }
}
