import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/domain/repository/page.repository.dart';

class GetPagesByAlbumUsecase {
  final PageRepository repository;

  GetPagesByAlbumUsecase(this.repository);

  Future<List<PageEntity>> call(String albumId) async {
    return await repository.getPagesByAlbum(albumId);
  }
}
