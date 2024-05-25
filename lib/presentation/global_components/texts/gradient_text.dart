import 'package:flutter/material.dart';

import 'custom_text.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
    this.maxLines,
    this.textAlign,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final int? maxLines;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: CustomText(
        text,
        style: style,
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }
}
