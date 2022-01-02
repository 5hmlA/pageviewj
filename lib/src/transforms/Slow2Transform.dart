
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../../pageviewj.dart';

class Slow2Transform extends PageTransform {
  final int parallax;

  Slow2Transform({this.parallax = 34});

  @override
  Widget transform(int index, double page, double aniValue, Widget child) {
    if (modifier?.scrollDirection == Axis.vertical) {
      return vertical(aniValue, index, page, child);
    } else {
      return horizontal(aniValue, index, page, child);
    }
  }

  Widget horizontal(double aniValue, int index, double page, Widget child) {
    double indexAni = page - index;
    double gauss = math.exp(-(math.pow((indexAni.abs() - 0.5), 2) / 0.08)); //<--caluclate Gaussian function
    return Transform.translate(
      offset: Offset(-parallax * gauss * indexAni.sign, 0),
      child: child,
    );
  }

  Widget vertical(double aniValue, int index, double page, Widget child) {
    double indexAni = page - index;
    double gauss = math.exp(-(math.pow((indexAni.abs() - 0.5), 2) / 0.08)); //<--caluclate Gaussian function
    return Transform.translate(
      offset: Offset(0, -parallax * gauss * indexAni.sign),
      child: child,
    );
  }
}