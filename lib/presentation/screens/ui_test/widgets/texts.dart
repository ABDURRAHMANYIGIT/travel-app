import 'package:flutter/material.dart';

import '../../../global_components/texts/custom_text.dart';

class CustomTexts extends StatelessWidget {
  const CustomTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ...CustomTextStyle.values.map(
          (CustomTextStyle e) => CustomText(
            e.name,
            style: e.customTextStyle,
          ),
        ),
      ],
    );
  }
}
