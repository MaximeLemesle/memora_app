import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:memora_app/features/album/domain/entities/album_entity.dart';

class AlbumModel extends Equatable {
  final String title;
  final String backgroundImage;
  final Timestamp dateStart;
  final Timestamp dateEnd;
  final List<String> members;
  final String owner;
  final String description;
  final int totalPages;
  final int usedPages;

  const AlbumModel({
    required this.title,
    required this.backgroundImage,
    required this.dateStart,
    required this.dateEnd,
    required this.members,
    required this.owner,
    required this.description,
    required this.totalPages,
    required this.usedPages,
  });

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      title: map['title'] as String? ?? (throw Exception('Title is required')),
      backgroundImage: map['background_image'] as String? ??
          (throw Exception('Background image is required')),
      dateStart: map['date_start'] as Timestamp? ??
          (throw Exception('Date start is required')),
      dateEnd: map['date_end'] as Timestamp? ??
          (throw Exception('Date end is required')),
      members: List<String>.from(map['members'] as List<dynamic>? ??
          (throw Exception('Members are required'))),
      owner: map['owner'] as String? ?? (throw Exception('Owner is required')),
      description: map['description'] as String? ??
          (throw Exception('Description is required')),
      totalPages: map['total_pages'] as int? ??
          (throw Exception('Total pages are required')),
      usedPages: map['used_pages'] as int? ??
          (throw Exception('Used pages are required')),
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

  @override
  List<Object> get props => [
        title,
        backgroundImage,
        dateStart,
        dateEnd,
        members,
        owner,
        description,
        totalPages,
        usedPages,
      ];
}
