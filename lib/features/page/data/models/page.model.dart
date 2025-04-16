import 'package:memora_app/features/page/domain/entities/page.entity.dart';

class PageModel extends PageEntity {
  const PageModel({
    required super.uid,
    required super.albumId,
    required super.type,
    required super.pageNumber,
    super.title,
    super.descriptions,
    super.images,
  });

  factory PageModel.fromJson(Map<String, dynamic> json, String docId) {
    return PageModel(
      uid: docId,
      albumId: json['album_id'],
      type: json['type'],
      pageNumber: json['page_number'],
      title: json['title'],
      descriptions: json['descriptions'],
      images: json['images'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'album_id': albumId,
      'type': type,
      'page_number': pageNumber,
      'title': title,
      'descriptions': descriptions,
      'images': images,
    };
  }

  factory PageModel.fromEntity(PageEntity entity) {
    return PageModel(
      uid: entity.uid,
      albumId: entity.albumId,
      type: entity.type,
      pageNumber: entity.pageNumber,
      title: entity.title,
      descriptions: entity.descriptions,
      images: entity.images,
    );
  }

  PageEntity toEntity() {
    return PageEntity(
      uid: uid,
      albumId: albumId,
      type: type,
      pageNumber: pageNumber,
      title: title,
      descriptions: descriptions,
      images: images,
    );
  }
}
