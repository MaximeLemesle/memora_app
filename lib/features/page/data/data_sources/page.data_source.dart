import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memora_app/features/page/data/models/page.model.dart';

class PageDataSource {
  final FirebaseFirestore firestore;

  PageDataSource({required this.firestore});

  Future<void> createPage(String albumId, PageModel page) async {
    try {
      await firestore
          .collection("albums")
          .doc(albumId)
          .collection('pages')
          .doc(page.uid)
          .set(page.toJson());
    } catch (e) {
      throw Exception("Error creating page: $e");
    }
  }

  Future<List<PageModel>> getPages(String albumId) async {
    try {
      final snapshot = await firestore
          .collection('albums')
          .doc(albumId)
          .collection('pages')
          .get();

      return snapshot.docs
          .map((doc) => PageModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Error fetching page: $e");
    }
  }
}
