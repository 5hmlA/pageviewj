import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../../pageviewj.dart';

class FlipTransform extends StaticTransform {

  FlipTransform();

  @override
  Widget horizontal(double aniValue, int index, double page, Widget child) {
    return super.horizontal(aniValue, index, page, horizontalFlip(aniValue, index, page, child));
  }

  Widget horizontalFlip(double aniValue, int index, double page, Widget child) {
    double angle = 0;
    if (page > index) {
      angle = (math.pi * (1 - aniValue)).clamp(0, math.pi / 2);
    } else {
      angle = (math.pi * aniValue).clamp(math.pi / 2, math.pi);
      child = Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(math.pi),
        child: child,
      );
    }
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle),
        child: child);
  }

  @override
  Widget vertical(double aniValue, int index, double page, Widget child) {
    return super.vertical(aniValue, index, page, verticalFlip(aniValue, index, page, child));
  }

  Widget verticalFlip(double aniValue, int index, double page, Widget child) {
    double angle = 0;
    if (page > index) {
      angle = (math.pi * (1 - aniValue)).clamp(0, math.pi / 2);
    } else {
      angle = (math.pi * aniValue).clamp(math.pi / 2, math.pi);
      child = Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateX(math.pi),
        child: child,
      );
    }
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(angle),
      child: child,
    );
  }
}

class ShuttersFlipTransform extends FlipTransform {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);

  int current = 0;
  int shutterSize = 6;
  double delay = .1;

  ShuttersFlipTransform();

  @override
  Widget horizontalFlip(double aniValue, int index, double page, Widget child) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
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
            intervalAni = Interval(indexSub * delay, 1-(shutterSize - indexSub) * delay).transform(aniValue.abs());
            // return SizedBox.shrink();
          } else {
            int sub = shutterSize - indexSub;
            intervalAni = Interval(sub * delay, 1-(shutterSize - sub) * delay)
                .transform(aniValue.abs());
          }

          return ClipRect(
            child: Align(
              heightFactor: 1 / shutterSize,
              alignment: FractionalOffset(0, indexSub / (shutterSize - 1)),
              child:
                  SizedBox(height: constraints.maxHeight, child: super.horizontalFlip(intervalAni, index, page, child)),
            ),
          );
        }),
      );
    });
  }

  @override
  Widget verticalFlip(double aniValue, int index, double page, Widget child) {
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
          intervalAni = Interval(indexSub * delay, 1-(shutterSize - indexSub) * delay).transform(aniValue.abs());
          // return SizedBox.shrink();
        } else {
          int sub = shutterSize - indexSub;
          intervalAni = Interval(sub * delay, 1-(shutterSize - sub) * delay)
              .transform(aniValue.abs());
        }

        return ClipRect(
          child: Align(
            widthFactor: 1 / shutterSize,
            alignment: FractionalOffset(indexSub / (shutterSize - 1), 0),
            child: SizedBox(width: mediaQuery.size.width, child: super.verticalFlip(intervalAni, index, page, child)),
          ),
        );
      }),
    );
  }
}
