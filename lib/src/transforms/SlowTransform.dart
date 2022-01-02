
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../../pageviewj.dart';

class SlowTransform extends PageTransform {
  int current = 0;

  SlowTransform();

  @override
  Widget transform(int index, double page, double aniValue, Widget child) {
    if (modifier?.scrollDirection == Axis.vertical) {
      return vertical(aniValue, index, page, child);
    } else {
      return horizontal(aniValue, index, page, child);
    }
  }

  Widget horizontal(double aniValue, int index, double page, Widget child) {
    double gauss = math.sin(math.pi * aniValue.abs());
    if (page == index) {
      current = index;
      return child;
    } else if (page > index) {
      if (current == index) {
        return child;
      }
      return LayoutBuilder(builder: (context, constraints) {
        return Transform.translate(
          offset: Offset(-constraints.maxWidth / 4 * gauss, 0),
          child: child,
        );
      });
    } else {
      if (current == index) {
        return child;
      }
      return LayoutBuilder(builder: (context, constraints) {
        return Transform.translate(
          offset: Offset(constraints.maxWidth / 4 * gauss, 0),
          child: child,
        );
      });
    }
  }

  Widget vertical(double aniValue, int index, double page, Widget child) {
    double gauss = math.sin(math.pi * aniValue);
    if (page == index) {
      current = index;
      return child;
    } else if (page > index) {
      if (current == index) {
        return child;
      }
      return LayoutBuilder(builder: (context, constraints) {
        return Transform.translate(
          offset: Offset(0, -constraints.maxWidth / 4 * gauss),
          child: child,
        );
      });
    } else {
      if (current == index) {
        return child;
      }
      return LayoutBuilder(builder: (context, constraints) {
        return Transform.translate(
          offset: Offset(0, constraints.maxWidth / 4 * gauss),
          child: child,
        );
      });
    }
  }
}