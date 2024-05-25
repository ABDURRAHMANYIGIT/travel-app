enum AccommodationDetailTabEnum { about, gallery, reviews }

extension AccommodationDetailTabEnumExtension on AccommodationDetailTabEnum {
  String get getTitle {
    switch (this) {
      case AccommodationDetailTabEnum.reviews:
        return 'Reviews';
      case AccommodationDetailTabEnum.gallery:
        return 'Gallery';
      case AccommodationDetailTabEnum.about:
        return 'About';
    }
  }
}
