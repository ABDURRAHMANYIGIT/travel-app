import 'package:flutter/material.dart';

import '../../../resources/styles/colors.dart';

class BottomSheetTopHolderWidget extends StatelessWidget {
  const BottomSheetTopHolderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 3,
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(
            100,
          ),
        ),
      ),
    );
  }
}
