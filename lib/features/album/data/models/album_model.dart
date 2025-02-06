import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:memora_app/features/album/domain/entities/album_entity.dart';

class AlbumModel extends Equatable {
  final String title;
  final String backgroundImage;
  final Timestamp dateStart;
  final Timestamp dateEnd;
  final String owner;
  final List<String> members;
  final String description;
  final int totalPages;
  final int usedPages;

  const AlbumModel({
    required this.title,
    required this.backgroundImage,
    required this.dateStart,
    required this.dateEnd,
    required this.owner,
    required this.members,
    required this.description,
    required this.totalPages,
    required this.usedPages,
  });

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      title: map['title'] as String,
      backgroundImage: map['background_image'] as String,
      dateStart: map['date_start'] as Timestamp,
      dateEnd: map['date_end'] as Timestamp,
      owner: map['owner'] as String,
      members: List<String>.from(map['members'] as List<dynamic>),
      description: map['description'] as String,
      totalPages: map['total_pages'] as int,
      usedPages: map['used_pages'] as int,
    );
  }

  AlbumEntity toEntity() {
    return AlbumEntity(
      title: title,
      backgroundImage: backgroundImage,
      dateStart: dateStart,
      dateEnd: dateEnd,
      owner: owner,
      members: members,
      description: description,
      totalPages: totalPages,
      usedPages: usedPages,
    );
  }

  @override
  List<Object> get props => [
        title,
        backgroundImage,
        dateStart,
        dateEnd,
        owner,
        members,
        description,
        totalPages,
        usedPages,
      ];
}
