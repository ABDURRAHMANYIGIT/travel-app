import 'dart:developer';

class AccommodationObject {
  AccommodationObject(
      {required this.id,
      required this.name,
      required this.location,
      required this.costPerPerson,
      required this.description,
      required this.photo,
      required this.photos,
      required this.rate});
  AccommodationObject.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as int?;
      name = json['name'] as String?;
      location = json['location'] as String?;
      rate = json['rate'] as double?;
      description = json['description'] as String?;
      photos = json['photos'] as List<String>?;
      photo = json['photo'] as String?;
      costPerPerson = json['cost_per_person'] as int?;
    } catch (e) {
      log(e.toString());
    }
  }

  int? id;
  String? name;
  String? location;
  double? rate;
  String? description;
  List<String>? photos;
  String? photo;
  int? costPerPerson;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'fields': <String, dynamic>{},
      'file_fields': <String, dynamic>{},
    };
  }
}
