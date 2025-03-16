import 'package:memora_app/features/album/domain/entities/album.entity.dart';

abstract class AlbumRepository {
  Future<List<AlbumEntity>> getAlbumsByUser(String owner);
  Future<void> createAlbum(AlbumEntity album);
}
