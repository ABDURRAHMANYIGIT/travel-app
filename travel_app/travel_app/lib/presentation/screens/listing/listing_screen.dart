import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/screen_controllers/listing_screen_controller.dart';
import '../../../resources/file_paths/icons.dart';
import '../../../resources/styles/colors.dart';
import '../../global_components/image_asset.dart';
import '../../layouts/main_layout.dart';
import '../accommodation_detail/accommodation_detail_screen.dart';
import 'widgets/accommodation_card.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ListingScreenController _screenController =
        Get.put(ListingScreenController());
    return MainLayout(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leadingWidth: 44,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: GestureDetector(
              child: const ImageAsset(
                AppIcons.menu,
              ),
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: CircleAvatar(),
            )
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8.0),
          child: ListView.builder(
              itemCount: _screenController.accommodationList.length,
              itemBuilder: (BuildContext ctx, int index) {
                final item = _screenController.accommodationList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Hero(
                    tag: item.id.toString(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Material(
                        child: AccommodationCard(
                          accommodation: item,
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration: const Duration(seconds: 1),
                                reverseTransitionDuration:
                                    const Duration(seconds: 1),
                                pageBuilder: (_, __, ___) =>
                                    AccommodationDetailScreen(
                                      accommodationObject: item,
                                    )));
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
