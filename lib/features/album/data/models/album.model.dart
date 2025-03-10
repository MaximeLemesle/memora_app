import 'package:memora_app/features/album/domain/entities/album.entity.dart';

class AlbumModel extends AlbumEntity {
  const AlbumModel({
    required super.title,
    required super.backgroundImage,
    required super.dateStart,
    required super.dateEnd,
    required super.members,
    required super.owner,
    required super.description,
    required super.totalPages,
    required super.usedPages,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      title: json['title'],
      backgroundImage: json['background_image'],
      dateStart: json['date_start'],
      dateEnd: json['date_end'],
      members: List<String>.from(json['members']),
      owner: json['owner'],
      description: json['description'],
      totalPages: json['total_pages'],
      usedPages: json['used_pages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'background_image': backgroundImage,
      'date_start': dateStart,
      'date_end': dateEnd,
      'members': members,
      'owner': owner,
      'description': description,
      'total_pages': totalPages,
      'used_pages': usedPages,
    };
  }

  factory AlbumModel.fromEntity(AlbumEntity entity) {
    return AlbumModel(
      title: entity.title,
      backgroundImage: entity.backgroundImage,
      dateStart: entity.dateStart,
      dateEnd: entity.dateEnd,
      members: entity.members,
      owner: entity.owner,
      description: entity.description,
      totalPages: entity.totalPages,
      usedPages: entity.usedPages,
    );
  }

  AlbumEntity toEntity() {
    return AlbumEntity(
      title: title,
      backgroundImage: backgroundImage,
      dateStart: dateStart,
      dateEnd: dateEnd,
      members: members,
      owner: owner,
      description: description,
      totalPages: totalPages,
      usedPages: usedPages,
    );
  }
}
