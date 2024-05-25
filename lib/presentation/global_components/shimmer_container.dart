import 'package:flutter/material.dart';
import '../../resources/styles/colors.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer(
      {super.key,
      this.containerCount = 1,
      this.containerHeight = 12,
      this.padding,
      this.margin});
  final int? containerCount;
  final double? containerHeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ...List<Widget>.generate(
                  containerCount!,
                  (int index) => Container(
                    padding: padding ??
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                    margin: margin ?? const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: SizedBox(
                      height: containerHeight,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
