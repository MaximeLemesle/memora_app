import 'package:memora_app/features/page/domain/entities/page.entity.dart';

class PageModel extends PageEntity {
  const PageModel({
    required super.uid,
    required super.albumId,
    required super.type,
    required super.pageNumber,
    super.title,
    super.texts,
    super.images,
    super.backgroundImage,
    super.startDate,
    super.endDate,
    super.members,
  });

  factory PageModel.fromJson(Map<String, dynamic> json, String docId) {
    return PageModel(
      uid: docId,
      albumId: json['album_id'],
      type: json['type'],
      pageNumber: json['page_number'],
      title: json['title'],
      texts: json['texts'],
      images: json['images'],
      backgroundImage: json['background_image'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      members: json['members'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'album_id': albumId,
      'type': type,
      'page_number': pageNumber,
      'title': title,
      'texts': texts,
      'images': images,
      'background_image': backgroundImage,
      'start_date': startDate,
      'end_date': endDate,
      'members': members,
    };
  }

  factory PageModel.fromEntity(PageEntity entity) {
    return PageModel(
      uid: entity.uid,
      albumId: entity.albumId,
      type: entity.type,
      pageNumber: entity.pageNumber,
      title: entity.title,
      texts: entity.texts,
      images: entity.images,
      backgroundImage: entity.backgroundImage,
      startDate: entity.startDate,
      endDate: entity.endDate,
      members: entity.members,
    );
  }

  PageEntity toEntity() {
    return PageEntity(
      uid: uid,
      albumId: albumId,
      type: type,
      pageNumber: pageNumber,
      title: title,
      texts: texts,
      images: images,
      backgroundImage: backgroundImage,
      startDate: startDate,
      endDate: endDate,
      members: members,
    );
  }
}
