import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:memora_app/features/album/data/models/album.model.dart';

class AlbumDataSource {
  final FirebaseFirestore firestore;

  AlbumDataSource({required this.firestore});

  Future<List<AlbumModel>> getAlbumsByUser(String ownerId) async {
    try {
      // Get albums where the user is the owner
      final ownerQuery = await firestore
          .collection("albums")
          .where("owner_id", isEqualTo: ownerId)
          .get();

      // Get albums where the user is a member
      final memberQuery = await firestore
          .collection("albums")
          .where("members", arrayContains: ownerId)
          .get();

      // Combine the two queries
      final fullQuery = [...ownerQuery.docs, ...memberQuery.docs];

      final albums =
          fullQuery.map((doc) => AlbumModel.fromJson(doc.data())).toList();

      return albums;
    } catch (e) {
      throw Exception("Error fetching albums: $e");
    }
  }

  Future<void> createAlbum(AlbumModel album) async {
    try {
      await firestore.collection("albums").doc(album.uid).set(album.toJson());
    } catch (e) {
      throw Exception("Error creating album: $e");
    }
  }
}
