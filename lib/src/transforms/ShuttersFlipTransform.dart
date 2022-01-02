
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../../pageviewj.dart';

class ShuttersFlipTransform extends StaticTransform {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);

  int current = 0;
  int shutterSize = 4;

  ShuttersFlipTransform();

  @override
  Widget horizontal(double aniValue, int index, double page, Widget child) {
    if (page < index) {
      child = Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateX(math.pi),
        child: child,
      );
    }
    return super.horizontal(
        aniValue,
        index,
        page,
        Row(
          children: List.generate(shutterSize, (indexSub) {
            double progress = 0;
            double intervalAni = 0;

            if (page > index) {
              intervalAni = Interval(indexSub / shutterSize, (indexSub + 1) / shutterSize).transform(aniValue.abs());
              progress = (1 - intervalAni).clamp(0, 0.5);
              // return SizedBox.shrink();
            } else {
              intervalAni = Interval((shutterSize - indexSub - 1) / shutterSize, (shutterSize - indexSub) / shutterSize)
                  .transform(aniValue.abs());
              progress = (intervalAni).clamp(0.5, 1);
            }
            return ClipRect(
              child: Align(
                widthFactor: 1 / shutterSize,
                alignment: FractionalOffset(indexSub / (shutterSize - 1), 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(math.pi * progress),
                  alignment: Alignment.center,
                  child: SizedBox(width: mediaQuery.size.width, child: child),
                ),
              ),
            );
          }),
        ));
  }

  @override
  Widget vertical(double aniValue, int index, double page, Widget child) {
    return horizontal(aniValue, index, page, child);
  }
}