import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/album/domain/usecases/fetch_albums.dart';
import 'package:memora_app/features/album/presentation/blocs/album_event.dart';
import 'package:memora_app/features/album/presentation/blocs/album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final FetchAlbums fetchAlbums;

  AlbumBloc({required this.fetchAlbums}) : super(AlbumInitial()) {
    on<LoadAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await fetchAlbums();
        emit(AlbumLoaded(albums: albums));
      } catch (error) {
        emit(AlbumError(
            message: 'Erreur lors de la récupération des pages : $error'));
      }
    });
  }
}
