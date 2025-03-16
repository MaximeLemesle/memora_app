import 'package:cloud_firestore/cloud_firestore.dart';

class AlbumEntity {
  final String uid;
  final String title;
  final String backgroundImage;
  final Timestamp startDate;
  final Timestamp endDate;
  final String ownerId;
  final String? description;
  final List<String>? members;

  const AlbumEntity({
    required this.uid,
    required this.title,
    required this.backgroundImage,
    required this.startDate,
    required this.endDate,
    required this.ownerId,
    this.description,
    this.members,
  });
}
