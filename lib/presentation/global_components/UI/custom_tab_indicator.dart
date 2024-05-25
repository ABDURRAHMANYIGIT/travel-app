import 'package:flutter/material.dart';

import '../../../resources/styles/colors.dart';

class CustomTabIndicator extends Decoration {
  const CustomTabIndicator({
    this.radius = 100,
    this.indicatorHeight = 4,
    this.color = AppColors.grey,
  });
  final double radius;

  final Color color;

  final double indicatorHeight;

  @override
  CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return CustomPainter(
      this,
      onChanged,
      radius,
      color,
      indicatorHeight,
    );
  }
}

class CustomPainter extends BoxPainter {
  CustomPainter(
    this.decoration,
    VoidCallback? onChanged,
    this.radius,
    this.color,
    this.indicatorHeight,
  ) : super(onChanged);
  final CustomTabIndicator decoration;
  final double radius;
  final Color color;
  final double indicatorHeight;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Paint paint = Paint();
    final double xAxisPos = offset.dx + configuration.size!.width / 2;
    final double yAxisPos =
        offset.dy + configuration.size!.height - indicatorHeight / 2;
    paint.color = color;

    final RRect fullRect = RRect.fromRectAndCorners(
      Rect.fromCenter(
        center: Offset(xAxisPos, yAxisPos),
        width: configuration.size!.width,
        height: indicatorHeight,
      ),
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );

    canvas.drawRRect(fullRect, paint);
  }
}
