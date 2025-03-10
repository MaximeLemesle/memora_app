import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memora_app/features/album/data/models/album.model.dart';

class AlbumDataSource {
  final FirebaseFirestore firestore;

  AlbumDataSource({required this.firestore});

  Future<List<AlbumModel>> getAlbumsByUser(String owner) async {
    try {
      // Get albums where the user is the owner
      final ownerQuery = await firestore
          .collection("albums")
          .where("owner", isEqualTo: owner)
          .get();

      // Get albums where the user is a member
      final memberQuery = await firestore
          .collection("albums")
          .where("members", arrayContains: owner)
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
}
