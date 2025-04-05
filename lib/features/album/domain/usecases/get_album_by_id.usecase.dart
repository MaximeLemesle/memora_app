import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/domain/repository/album.repository.dart';

class GetAlbumById {
  final AlbumRepository repository;

  GetAlbumById(this.repository);

  Future<AlbumEntity> call(String albumId) async {
    return await repository.getAlbumById(albumId);
  }
}
