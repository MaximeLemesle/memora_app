import 'package:equatable/equatable.dart';

class AlbumResponse extends Equatable {
  final String title;
  final String backgroundImage;
  final String dateStart;
  final String dateEnd;
  final String owner;
  final List<String> members;
  final String description;
  final int totalPages;
  final int usedPages;

  const AlbumResponse({
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

  AlbumResponse toEntity() {
    return AlbumResponse(
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

  factory AlbumResponse.fromMap(Map<String, dynamic> map) {
    return AlbumResponse(
      title: map['title'] as String,
      backgroundImage: map['background_image'] as String,
      dateStart: map['date_start'] as String,
      dateEnd: map['date_end'] as String,
      owner: map['owner'] as String,
      members: List<String>.from(map['members'] as List<dynamic>),
      description: map['description'] as String,
      totalPages: map['total_pages'] as int,
      usedPages: map['used_pages'] as int,
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
