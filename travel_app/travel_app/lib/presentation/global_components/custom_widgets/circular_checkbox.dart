import 'package:flutter/material.dart';

import '../../../resources/styles/colors.dart';

class CircularCheckBox extends StatelessWidget {
  const CircularCheckBox({
    super.key,
    this.isSelected = false,
    this.onTap,
  });
  final bool isSelected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.etrexioPurple,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.etrexioPurple : AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
