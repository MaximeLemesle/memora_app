import 'package:memora_app/features/album/data/repositories/album_repository.dart';
import 'package:memora_app/features/album/domain/entities/album_entity.dart';

class FetchAlbums {
  final AlbumRepository repository;

  FetchAlbums({required this.repository});

  Future<List<AlbumEntity>> call() async {
    final models = await repository.fetchAlbums();

    return models.map((model) => model.toEntity()).toList();
  }
}
