import 'package:flutter/material.dart';

import '../../../../resources/styles/text_styles.dart';
import '../../../global_components/texts/custom_text.dart';

class OnboardingPageLayout extends StatelessWidget {
  const OnboardingPageLayout({
    super.key,
    required this.content,
  });
  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Center(
            child: CustomText(
              content,
              style: AppTextStyle.h4(),
              maxLines: 5,
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
