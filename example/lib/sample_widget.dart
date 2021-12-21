import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<String> images = [
  "images/gmzr1.jpg",
  "images/gmzr2.jpg",
  "images/gmzr3.jpg",
  "images/gmzr4.jpg",
];

Widget pageviewAniItem(
    BuildContext context, int index, double page, double aniValue) {
  return Center(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 300,
            child: Stack(
              children: [
                Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19)),
                  child: SizedBox(
                    height: 230 + 50 * aniValue,
                    child: Image.asset(
                      images[index % 4],
                      fit: BoxFit.cover,
                      alignment: Alignment(1 - aniValue, 0),
                    ),
                  ),
                ),
                Positioned(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 5.0 * (aniValue), sigmaY: 5.0 * (aniValue)),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.2)),
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return const Text(
                              "鬼灭之刃",
                              style: TextStyle(color: Colors.white),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  bottom: 10,
                  left: 24 + 260 - 260 * aniValue,
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Widget pageViewItem(BuildContext context, int index) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Stack(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
            height: 300,
            child: Image.asset(
              images[index % 4],
              fit: BoxFit.cover,
              alignment: const Alignment(0, 0),
            ),
          ),
        ),
        Positioned(
          child: Text(
            "鬼灭之刃 $index",
            style: const TextStyle(color: Colors.white),
          ),
          bottom: 18,
          left: 18,
        ),
      ],
    ),
  );
}
