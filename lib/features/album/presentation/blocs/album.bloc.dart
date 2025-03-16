import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/domain/usecases/create_new_album.usecase.dart';
import 'package:memora_app/features/album/domain/usecases/get_albums_by_user.usecase.dart';

abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<AlbumEntity> albums;

  AlbumLoaded(this.albums);
}

class AlbumSuccess extends AlbumState {}

class AlbumError extends AlbumState {
  final String message;
  AlbumError(this.message);
}

class AlbumBloc extends Cubit<AlbumState> {
  final GetAlbumsByUser getAlbumsByUser;
  final CreateNewAlbum createNewAlbum;

  AlbumBloc(
    this.getAlbumsByUser,
    this.createNewAlbum,
  ) : super(AlbumInitial());

  Future<void> fetchAlbums(String owner) async {
    emit(AlbumLoading());
    try {
      final albums = await getAlbumsByUser(owner);
      emit(AlbumLoaded(albums));
    } catch (e) {
      emit(AlbumError("Error: $e"));
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
