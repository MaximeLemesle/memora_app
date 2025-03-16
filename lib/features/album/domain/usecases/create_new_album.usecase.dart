import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/domain/repository/album.repository.dart';

class CreateNewAlbum {
  final AlbumRepository repository;

  CreateNewAlbum(this.repository);

  Future<void> call(AlbumEntity album) async {
    if (album.title.isEmpty) {
      throw Exception("Le titre de l'album est obligatoire.");
    }

    if (album.backgroundImage.isEmpty) {
      throw Exception("Une photo de couverture est obligatoire.");
    }

    await repository.createAlbum(album);
  }
}
