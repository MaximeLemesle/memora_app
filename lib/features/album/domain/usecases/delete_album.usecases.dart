import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/domain/repository/album.repository.dart';
import 'package:memora_app/features/page/domain/usecases/delete_page.usecase.dart';
import 'package:memora_app/features/page/domain/usecases/get_pages_by_album.usecase.dart';

class DeleteAlbumUsecase {
  final AlbumRepository repository;
  final GetPagesByAlbumUsecase getPages;
  final DeletePageUsecase deletePage;

  DeleteAlbumUsecase(this.repository, this.getPages, this.deletePage);

  Future<void> call(AlbumEntity album) async {
    /// Delete all pages in the album
    final pages = await getPages(album.uid);
    for (final page in pages) {
      await deletePage(page);
    }

    /// Delete the album
    await repository.deleteAlbum(album);
  }
}
