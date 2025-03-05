import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memora_app/features/album/data/models/album.model.dart';

class AlbumRepository {
  final FirebaseFirestore _firestore;

  AlbumRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Récupère tous les albums depuis Firestore
  Future<List<AlbumModel>> fetchAlbums() async {
    try {
      final snapshot = await _firestore.collection('albums').get();

      return snapshot.docs.map((doc) {
        return AlbumModel.fromMap(doc.data());
      }).toList();
    } catch (error) {
      throw Exception('Erreur lors de la récupération des albums : $error');
    }
  }
}
