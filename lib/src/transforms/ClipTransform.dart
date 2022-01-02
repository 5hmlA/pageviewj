
import 'package:flutter/widgets.dart';
import '../../pageviewj.dart';

class ClipTransform extends StaticTransform {
  ClipTransform();

  @override
  Widget horizontal(double aniValue, int index, double page, Widget child) {
    if (page == index) {
      return child;
    } else if (page > index) {
      return super.horizontal(aniValue, index, page, child);
    } else {
      return ClipRect(
        child: Align(
          widthFactor: aniValue,
          child: super.horizontal(aniValue, index, page, child),
        ),
      );
    }
  }

  @override
  Widget vertical(double aniValue, int index, double page, Widget child) {
    if (page == index) {
      return child;
    } else if (page > index) {
      return super.vertical(aniValue, index, page, child);
    } else {
      return ClipRect(
        child: Align(
          widthFactor: aniValue,
          child: super.vertical(aniValue, index, page, child),
        ),
      );
    }
  }
}