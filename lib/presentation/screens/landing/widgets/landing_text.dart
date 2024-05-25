import 'package:flutter/material.dart';

import '../../../../resources/i18n/app_sentences.dart';

class LandingText extends StatelessWidget {
  const LandingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: AppSentences().exampleSentence,
        children: <InlineSpan>[
          const TextSpan(text: ', '),
          TextSpan(
            text: AppSentences().exampleSentence,
          ),
        ],
      ),
    );
  }
}
