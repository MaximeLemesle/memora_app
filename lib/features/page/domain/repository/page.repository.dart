import 'package:memora_app/features/page/domain/entities/page.entity.dart';

abstract class PageRepository {
  Future<void> createPage(String albumId, PageEntity page);
  Future<List<PageEntity>> getPagesByAlbum(String albumId);
}
