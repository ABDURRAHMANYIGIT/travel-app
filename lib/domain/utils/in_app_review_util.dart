import 'package:in_app_review/in_app_review.dart';

import '../../resources/config/app_info.dart';

class InAppReviewUtil {
  void onTapRateInAppstore() {
    final InAppReview inAppReview = InAppReview.instance;
    inAppReview.openStoreListing(
      appStoreId: AppInfo.appStoreId,
    );
  }
}
