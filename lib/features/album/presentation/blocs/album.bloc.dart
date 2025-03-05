import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/domain/usecases/fetch_albums.usecase.dart';

abstract class AlbumEvent {}

class FetchAlbumsEvent extends AlbumEvent {}

abstract class AlbumState {}

class AlbumLoadingState extends AlbumState {}

class AlbumLoadedState extends AlbumState {
  final List<AlbumEntity> albums;

  AlbumLoadedState({required this.albums});
}

class AlbumErrorState extends AlbumState {
  final String message;

  AlbumErrorState({required this.message});
}

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final FetchAlbums fetchAlbums;

  AlbumBloc({required this.fetchAlbums}) : super(AlbumLoadingState()) {
    on<FetchAlbumsEvent>((event, emit) async {
      emit(AlbumLoadingState());

      try {
        final albums = await fetchAlbums();
        emit(AlbumLoadedState(albums: albums));
      } catch (error) {
        emit(AlbumErrorState(message: error.toString()));
      }
    });
  }
}
