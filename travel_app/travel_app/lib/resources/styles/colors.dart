import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color transparent = Colors.transparent;
  static const Color etrexioPurple = Color(0XFF3C255B);

  static const Color black = Color(0XFF0B0B0B);
  static const Color grey = Color(0XFF727070);
  static const Color linked = Color(0XFF0A66C2);
  static const Color red = Colors.red;
  static const Color darkBlue = Color(0xFF060e0e);
  static const Color white = Color(0xFFfbfbfb);
  static const Color darkBrown = Color(0xFF5c2d1c);
  static const Color teal = Color(0xFF195b54);
  static const Color brown = Color(0xFF895643);
  static const Color lightGrey = Color(0xFFa2a2a2);
  static const Color steelBlue = Color(0xFF597f94);
  static const Color charcoal = Color(0xFF53554c);

  /// GRADIENTS
  static LinearGradient purpleGradient = const LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: <Color>[
      Color(0XFF8500D6),
      Color(0XFF3C255B),
      Color(0XFF3C255B),
      Color(0XFF8500D6),
    ],
    stops: <double>[
      0.02,
      0.22,
      0.40,
      0.96,
    ],
  );

  static RadialGradient purpleCircle = RadialGradient(
    colors: <Color>[
      const Color(0XFF8500D6),
      const Color(0XFF9933D7).withOpacity(0.75),
      const Color(0XFFFEFEFE),
    ],
  );
}
