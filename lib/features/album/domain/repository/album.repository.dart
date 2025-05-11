import 'package:memora_app/features/album/domain/entities/album.entity.dart';

abstract class AlbumRepository {
  Future<List<AlbumEntity>> getAlbumsByUser(String owner);
  Future<AlbumEntity> getAlbumById(String albumId);
  Future<void> createAlbum(AlbumEntity album);
  Future<void> deleteAlbum(AlbumEntity album);
}
