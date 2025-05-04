import 'package:memora_app/features/page/domain/repository/page.repository.dart';

class GetPageCountByAlbumUsecase {
  final PageRepository repository;

  GetPageCountByAlbumUsecase(this.repository);

  Future<int> call(String albumId) async {
    return await repository.getPageCountByAlbum(albumId);
  }
}
