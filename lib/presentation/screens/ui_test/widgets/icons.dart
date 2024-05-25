import 'package:flutter/material.dart';

import '../../../../resources/file_paths/icons.dart';
import '../../../../resources/styles/colors.dart';
import '../../../global_components/image_asset.dart';

class AppIconsList extends StatelessWidget {
  const AppIconsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageAsset(
            AppIcons.example,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }
}
