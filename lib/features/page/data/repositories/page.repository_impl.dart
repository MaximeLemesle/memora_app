import 'package:memora_app/features/page/data/data_sources/page.data_source.dart';
import 'package:memora_app/features/page/data/models/page.model.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/domain/repository/page.repository.dart';

class PageRepositoryImpl implements PageRepository {
  final PageDataSource dataSource;

  PageRepositoryImpl({required this.dataSource});

  @override
  Future<List<PageEntity>> getPagesByAlbum(String albumId) async {
    final List<PageModel> pages = await dataSource.getPages(albumId);
    return pages.map((page) => page.toEntity()).toList();
  }

  @override
  Future<void> createPage(String albumId, PageEntity page) async {
    final PageModel pageModel = PageModel.fromEntity(page);
    await dataSource.createPage(albumId, pageModel);
  }
}
