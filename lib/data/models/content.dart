import 'dart:developer';

class ContentObject {
  ContentObject(
      {required int this.id,
      required DateTime this.date,
      required String this.article,
      required String this.image,
      required String this.title});
  ContentObject.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'] as int?;
      title = json['title'] as String?;
      article = json['article'] as String?;
      image = json['image'] as String?;
      date = json['date'] as DateTime?;
    } catch (e) {
      log(e.toString());
    }
  }
  int? id;
  DateTime? date;
  String? image;
  String? article;
  String? title;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'article': article,
      'image': image,
      'date': date,
      'fields': <String, dynamic>{},
      'file_fields': <String, dynamic>{},
    };
  }

  @override
  String toString() => 'ContentObject { ContentObject: $id }';
}
