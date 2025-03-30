import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memora_app/features/page/data/models/page.model.dart';

class PageDataSource {
  final FirebaseFirestore firestore;

  PageDataSource({required this.firestore});

  Future<void> createPage(PageModel page) async {
    try {
      await firestore.collection("pages").doc(page.uid).set(page.toJson());
    } catch (e) {
      throw Exception("Error creating page: $e");
    }
  }

  Future<List<PageModel>> getPagesByAlbum(String albumId) async {
    try {
      // Get all the pages in an album
      final snapshot = await firestore
          .collection("pages")
          .where("album_id", isEqualTo: albumId)
          .get();

      List<PageModel> pages = [];
      for (var doc in snapshot.docs) {
        PageModel page = PageModel.fromJson(doc.data(), doc.id);
        pages.add(page);
      }

      return pages;
    } catch (e) {
      throw Exception("Error fetching page: $e");
    }
  }
}
