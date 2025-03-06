import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/domain/repository/album.repository.dart';

class GetAlbumsByUser {
  final AlbumRepository repository;

  GetAlbumsByUser(this.repository);

  Future<List<AlbumEntity>> call(String uid) async {
    return await repository.getAlbumsByUser(uid);
  }
}
