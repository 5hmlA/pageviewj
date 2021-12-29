import 'dart:math';

import 'package:flutter/material.dart';

class Hero {
  final String icon;
  final String name;
  final MaterialColor color;

  Hero(this.icon, this.name, this.color);
}

List<Hero> heros = [
  Hero("images/captonamerica.png", "caption\namerica", Colors.blue),
  Hero("images/ironman.png", "iron\nman", Colors.yellow),
  Hero("images/spiderman.png", "spider\nman", Colors.red),
];

class HeroBorder extends StadiumBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    RRect rRect = RRect.fromLTRBAndCorners(rect.left + 30, rect.top + 100, rect.right - 30, rect.bottom,
        topLeft: const Radius.circular(50), topRight: const Radius.circular(50));
    return Path()..addRRect(rRect);
  }
}

@immutable
class HeroCard extends StatelessWidget {
  final int index;
  final double page;
  final double aniValue;

  const HeroCard(this.index, this.page, this.aniValue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Hero hero = heros[index % 3];
    TextStyle textStyle = Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white);
    return LayoutBuilder(builder: (context, constraints) {
      double xOffset = 0;
      double scale = 1;
      double angle = 0;
      Color? color = hero.color;
      if (page > index) {
        xOffset = 0;
        // angle = -pi / 18;
        angle = -pi / 2 * (1 - aniValue);
        color = ColorTween(end: Colors.transparent, begin: hero.color).transform(1 - aniValue);
        Widget child = buildChild(color, scale, hero, context, textStyle);
        xOffset = constraints.maxWidth * (1 - aniValue);
        return Transform.rotate(
          angle: angle,
          alignment: Alignment.bottomLeft,
          child: child,
        );
      } else if (page < index) {
        // angle = pi/2 * aniValue;
        // scale = aniValue;
        scale = Curves.easeInSine.transform(aniValue);
        xOffset = -constraints.maxWidth * (1 - aniValue);
        double colorAni = Curves.easeInQuint.transform(aniValue);
        // color = ColorTween(begin: hero.color.withAlpha(0), end: hero.color).transform(colorAni);
        color = hero.color.withOpacity(colorAni);
        textStyle = Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white.withOpacity(colorAni));
        Offset offset = Offset(xOffset, 0);
        Widget child = buildChild(color, scale, hero, context, textStyle);
        return Transform.translate(
          offset: offset,
          child: child,
        );
      }
      return buildChild(color, scale, hero, context, textStyle);
    });
  }

  Container buildChild(Color? color, double scale, Hero hero, BuildContext context, TextStyle textStyle) {
    return Container(
      decoration: ShapeDecoration(
        color: color,
        shape: HeroBorder(),
      ),
      child: Column(
        children: [
          Transform.scale(
            scale: scale,
            child: Image.asset(
              hero.icon,
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          Align(
            alignment: const Alignment(-.5, -1.0),
            child: Text(
              hero.name,
              style: textStyle,
            ),
          )
        ],
      ),
    );
  }
}
