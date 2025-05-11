import 'package:memora_app/features/page/data/data_sources/page.data_source.dart';
import 'package:memora_app/features/page/data/models/page.model.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/domain/repository/page.repository.dart';

class PageRepositoryImpl implements PageRepository {
  final PageDataSource dataSource;

  PageRepositoryImpl({required this.dataSource});

  @override
  Future<List<PageEntity>> getPagesByAlbum(String albumId) async {
    final List<PageModel> pages = await dataSource.getPagesByAlbum(albumId);
    return pages.map((page) => page.toEntity()).toList();
  }

  @override
  Future<void> createPage(PageEntity page) async {
    final PageModel pageModel = PageModel.fromEntity(page);
    await dataSource.createPage(pageModel);
  }

  @override
  Future<void> updatePage(PageEntity newPage) async {
    final PageModel pageModel = PageModel.fromEntity(newPage);
    await dataSource.updatePage(pageModel);
  }

  @override
  Future<int> getPageCountByAlbum(String albumId) async {
    return await dataSource.getPageCountByAlbum(albumId);
  }

  @override
  Future<void> deletePage(PageEntity page) async {
    final PageModel pageModel = PageModel.fromEntity(page);

    await dataSource.deletePage(pageModel);
  }
}
