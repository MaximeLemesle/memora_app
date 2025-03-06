import 'package:cloud_firestore/cloud_firestore.dart';

class AlbumEntity {
  final String uid;
  final String title;
  final String backgroundImage;
  final Timestamp dateStart;
  final Timestamp dateEnd;
  final List<String> members;
  final String owner;
  final String description;
  final int totalPages;
  final int usedPages;

  const AlbumEntity({
    required this.uid,
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
}
