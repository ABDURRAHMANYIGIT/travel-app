import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../data/models/accommodation.dart';
import '../../../domain/controllers/screen_controllers/accommodation_screen_controller.dart';
import '../../../resources/file_paths/icons.dart';
import '../../global_components/image_asset.dart';
import 'widgets/content.dart';

class AccommodationDetailScreen extends StatelessWidget {
  const AccommodationDetailScreen(
      {super.key, required this.accommodationObject});
  final AccommodationObject accommodationObject;
  @override
  Widget build(BuildContext context) {
    Get.put(AccommodationScreenController());
    return Hero(
      tag: accommodationObject.id.toString(),
      child: Material(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leadingWidth: 64,
              leading: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12)),
                    child: const ImageAsset(
                      AppIcons.menu,
                    ),
                  ),
                ),
              ),
              pinned: true,
              floating: true,
              collapsedHeight: Get.height * 0.1,
              expandedHeight: Get.height * 0.4,
              flexibleSpace: Stack(
                fit: StackFit.expand,
                children: [
                  // Background image
                  if (accommodationObject.photo != null)
                    Image.network(
                      accommodationObject.photo!,
                      fit: BoxFit.cover,
                    ),
                  // Overlaying text
                ],
              ),
            ),
            // SliverList for the content
            SliverFillRemaining(
              child: AccommodationDetailContent(
                accommodationObject: accommodationObject,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
