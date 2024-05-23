import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'image_picker_bottom_sheet.dart';

class ShowBottomSheets {
  Future<void> showImagePickerBottomSheet(
      {Function? onTapCamera, Function? onTapGallery}) async {
    Get.bottomSheet(
      DraggableScrollableSheet(
        snap: true,
        expand: false,
        maxChildSize: 0.3,
        initialChildSize: 0.3,
        minChildSize: 0.2,
        builder: (BuildContext context, ScrollController scrollController) {
          return ImagePickerBottomSheetContent(
            scrollController: scrollController,
            onTapCamera: onTapCamera,
            onTapGallery: onTapGallery,
          );
        },
      ),
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
    );
  }
}
