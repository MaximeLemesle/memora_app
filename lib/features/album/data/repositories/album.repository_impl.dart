import 'package:memora_app/features/album/data/data_sources/album.data_source.dart';
import 'package:memora_app/features/album/data/models/album.model.dart';
import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/domain/repository/album.repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumDataSource dataSource;

  AlbumRepositoryImpl({required this.dataSource});

  @override
  Future<List<AlbumEntity>> getAlbumsByUser(String owner) async {
    final List<AlbumModel> albums = await dataSource.getAlbumsByUser(owner);

    return albums.map((album) => album.toEntity()).toList();
  }

  @override
  Future<void> createAlbum(AlbumEntity album) async {
    final AlbumModel albumModel = AlbumModel.fromEntity(album);

    await dataSource.createAlbum(albumModel);
  }
}
