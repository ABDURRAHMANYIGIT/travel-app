import 'dart:developer';

import 'collection_item.dart';

class CollectionObject {
  CollectionObject();

  CollectionObject.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as String?;
      name = json['name'] as String?;
      image = json['image'] as String?;
      if (json['collection_items'] != null) {
        for (final dynamic element
            in json['collection_items'] as List<dynamic>) {
          collectionItems.add(
              CollectionItemObject.fromJson(element as Map<String, dynamic>));
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
  String? id;
  String? image;
  String? name;
  List<CollectionItemObject> collectionItems = <CollectionItemObject>[];
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'image': image,
    };
  }

  @override
  String toString() => 'Collection { Collection: $id }';

  String get ownedItems =>
      '${collectionItems.where((CollectionItemObject element) => false).toList().length}/6';
}
