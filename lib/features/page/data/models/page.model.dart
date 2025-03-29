import 'package:memora_app/features/page/domain/entities/page.entity.dart';

class PageModel extends PageEntity {
  const PageModel({
    required super.uid,
    required super.albumId,
    required super.pageNumber,
    required super.type,
    required super.title,
    super.descriptions,
    super.images,
  });

  factory PageModel.fromJson(Map<String, dynamic> json, String docId) {
    return PageModel(
      uid: docId,
      albumId: json['album_id'],
      pageNumber: json['page_number'],
      type: json['type'],
      title: json['title'],
      descriptions: json['descriptions'],
      images: json['images'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'album_id': albumId,
      'page_number': pageNumber,
      'type': type,
      'title': title,
      'descriptions': descriptions,
      'images': images,
    };
  }

  factory PageModel.fromEntity(PageEntity entity) {
    return PageModel(
      uid: entity.uid,
      albumId: entity.albumId,
      pageNumber: entity.pageNumber,
      type: entity.type,
      title: entity.title,
      descriptions: entity.descriptions,
      images: entity.images,
    );
  }

  PageEntity toEntity() {
    return PageEntity(
      uid: uid,
      albumId: albumId,
      pageNumber: pageNumber,
      type: type,
      title: title,
      descriptions: descriptions,
      images: images,
    );
  }
}
