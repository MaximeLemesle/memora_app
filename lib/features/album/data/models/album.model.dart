import 'package:memora_app/features/album/domain/entities/album.entity.dart';

class AlbumModel extends AlbumEntity {
  const AlbumModel({
    required super.uid,
    required super.title,
    required super.backgroundImage,
    required super.startDate,
    required super.endDate,
    required super.ownerId,
    required super.description,
    required super.members,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      uid: json['uid'],
      title: json['title'],
      backgroundImage: json['background_image'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      ownerId: json['owner_id'],
      description: json['description'],
      members: List<String>.from(json['members']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'title': title,
      'background_image': backgroundImage,
      'start_date': startDate,
      'end_date': endDate,
      'owner_id': ownerId,
      'description': description,
      'members': members,
    };
  }

  factory AlbumModel.fromEntity(AlbumEntity entity) {
    return AlbumModel(
      uid: entity.uid,
      title: entity.title,
      backgroundImage: entity.backgroundImage,
      startDate: entity.startDate,
      endDate: entity.endDate,
      ownerId: entity.ownerId,
      description: entity.description,
      members: entity.members,
    );
  }

  AlbumEntity toEntity() {
    return AlbumEntity(
      uid: uid,
      title: title,
      backgroundImage: backgroundImage,
      startDate: startDate,
      endDate: endDate,
      ownerId: ownerId,
      description: description,
      members: members,
    );
  }
}
