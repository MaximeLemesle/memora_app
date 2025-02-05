import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/album_response.dart';

class AlbumService {
  final FirebaseFirestore _firestore;

  AlbumService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Récupère tous les albums depuis Firestore
  Future<List<AlbumResponse>> fetchAlbums() async {
    try {
      final snapshot = await _firestore.collection('albums').get();

      return snapshot.docs.map((doc) {
        return AlbumResponse.fromMap(doc.data());
      }).toList();
    } catch (error) {
      throw Exception('Erreur lors de la récupération des albums : $error');
    }
  }
}
