import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../data/models/accommodation.dart';
import 'widgets/content.dart';

class AccommodationDetailScreen extends StatelessWidget {
  const AccommodationDetailScreen(
      {super.key, required this.accommodationObject});
  final AccommodationObject accommodationObject;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: accommodationObject.id.toString(),
      child: Material(
          child: SizedBox(
        height: Get.height,
        child: Stack(
          children: [
            // Sliding container from the bottom
            AccommodationDetailContent(
                accommodationObject: accommodationObject),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  image: accommodationObject.photo != null
                      ? DecorationImage(
                          image: NetworkImage(accommodationObject.photo!),
                          fit: BoxFit.cover,
                        )
                      : null),
            ),
          ],
        ),
      )),
    );
  }
}
