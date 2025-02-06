import 'package:equatable/equatable.dart';
import 'package:memora_app/features/album/domain/entities/album_entity.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<AlbumEntity> albums;

  const AlbumLoaded({required this.albums});

  @override
  List<Object> get props => [albums];
}

class AlbumError extends AlbumState {
  final String message;

  const AlbumError({required this.message});

  @override
  List<Object> get props => [message];
}
