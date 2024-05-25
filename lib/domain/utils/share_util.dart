import 'package:share_plus/share_plus.dart';

class ShareUtil {
  Future<void> share(ShareModel shareContent) async {
    await Share.share('${shareContent.title}\n\n${shareContent.subtitle}');
  }
}

class ShareModel {
  ShareModel({
    this.title,
    this.subtitle,
  });
  final String? title;
  final String? subtitle;
}
