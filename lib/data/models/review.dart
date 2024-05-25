import 'dart:developer';

import 'user_object.dart';

class ReviewObject {
  ReviewObject();
  ReviewObject.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as int?;
      title = json['title'] as String?;
      description = json['description'] as String?;
      rate = json['rate'] as int?;
      user = json['user'] as UserObject?;
    } catch (e) {
      log(e.toString());
    }
  }
  int? id;
  int? rate;
  String? title;
  String? description;
  UserObject? user;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'rate': rate,
      'title': title,
      'description': description,
      'user': user,
      'fields': <String, dynamic>{},
      'file_fields': <String, dynamic>{},
    };
  }
}
