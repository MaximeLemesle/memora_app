import 'package:cloud_firestore/cloud_firestore.dart';

class PageEntity {
  final String uid;
  final String albumId;
  final String type;
  final String? title;
  final List<dynamic>? texts;
  final List<dynamic>? images;
  final String? backgroundImage;
  final Timestamp? startDate;
  final Timestamp? endDate;
  final List<dynamic>? members;

  const PageEntity({
    required this.uid,
    required this.albumId,
    required this.type,
    this.title,
    this.texts,
    this.images,
    this.backgroundImage,
    this.startDate,
    this.endDate,
    this.members,
  });
}
