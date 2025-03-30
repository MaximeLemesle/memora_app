import 'package:memora_app/features/page/domain/entities/page.entity.dart';

abstract class PageRepository {
  Future<List<PageEntity>> getPagesByAlbum(String albumId);
  Future<void> createPage(PageEntity page);
}
