import 'dart:developer';

class CollectionItemObject {
  CollectionItemObject();

  CollectionItemObject.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as String?;
      title = json['title'] as String?;
    } catch (e) {
      log(e.toString());
    }
  }

  String? id;
  String? title;
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
    };
  }

  @override
  String toString() => 'CollectionItem { CollectionItem: $id }';
}
