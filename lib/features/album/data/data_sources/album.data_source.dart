import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:memora_app/features/album/data/models/album.model.dart';

class AlbumDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  AlbumDataSource({
    required this.firestore,
    FirebaseStorage? storage,
  }) : storage = storage ?? FirebaseStorage.instance;

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

  Future<AlbumModel> getAlbumById(String albumId) async {
    try {
      // Get an album by its ID
      final doc = await firestore.collection("albums").doc(albumId).get();

      if (doc.exists) {
        return AlbumModel.fromJson(doc.data()!);
      } else {
        throw Exception("Album not found");
      }
    } catch (e) {
      throw Exception("Error fetching album: $e");
    }
  }

  Future<void> createAlbum(AlbumModel album) async {
    try {
      await firestore.collection("albums").doc(album.uid).set(album.toJson());
    } catch (e) {
      throw Exception("Error creating album: $e");
    }
  }

  Future<void> deleteAlbum(AlbumModel album) async {
    try {
      final imageUrl = album.backgroundImage;
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();

      await firestore.collection("albums").doc(album.uid).delete();
    } catch (e) {
      throw Exception("Error deleting album: $e");
    }
  }
}
