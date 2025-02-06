import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AlbumEntity extends Equatable {
  final String title;
  final String backgroundImage;
  final Timestamp dateStart;
  final Timestamp dateEnd;
  final String owner;
  final List<String> members;
  final String description;
  final int totalPages;
  final int usedPages;

  const AlbumEntity({
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
