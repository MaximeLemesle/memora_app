import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/domain/usecases/create_new_album.usecase.dart';
import 'package:memora_app/features/album/domain/usecases/get_album_by_id.usecase.dart';
import 'package:memora_app/features/album/domain/usecases/get_albums_by_user.usecase.dart';

abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumsLoaded extends AlbumState {
  final List<AlbumEntity> albums;

  AlbumsLoaded(this.albums);
}

class AlbumLoaded extends AlbumState {
  final AlbumEntity album;

  AlbumLoaded(this.album);
}

class AlbumSuccess extends AlbumState {}

class AlbumError extends AlbumState {
  final String message;
  AlbumError(this.message);
}

class AlbumBloc extends Cubit<AlbumState> {
  final GetAlbumsByUser getAlbumsByUser;
  final GetAlbumById getAlbumById;
  final CreateNewAlbum createNewAlbum;

  AlbumBloc(
    this.getAlbumsByUser,
    this.getAlbumById,
    this.createNewAlbum,
  ) : super(AlbumInitial());

  Future<void> fetchAlbumsByUser(String owner) async {
    emit(AlbumLoading());
    try {
      final albums = await getAlbumsByUser(owner);
      emit(AlbumsLoaded(albums));
    } catch (e) {
      emit(AlbumError("Erreur lors de la récupération des albums: $e"));
    }
  }

  Future<void> fetchAlbumById(String albumId) async {
    emit(AlbumLoading());
    try {
      final album = await getAlbumById(albumId);
      emit(AlbumLoaded(album));
    } catch (e) {
      emit(AlbumError("Erreur lors de la récupération de l’album: $e"));
    }
  }

  Future<void> createAlbum(AlbumEntity album) async {
    try {
      await createNewAlbum(album);
      emit(AlbumSuccess());
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }
}
