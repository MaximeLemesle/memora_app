import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memora_app/features/album/data/models/album.model.dart';

class AlbumDataSource {
  final FirebaseFirestore firestore;

  AlbumDataSource({required this.firestore});

  Future<List<AlbumModel>> getAlbumsByUser(String uid) async {
    try {
      // TODO: Add the fetch of albums where the user is a member
      final data = await firestore
          .collection("albums")
          .where("owner", isEqualTo: uid)
          .get();

      return data.docs.map((doc) => AlbumModel.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception("Error fetching albums: $e");
    }
  }
}
