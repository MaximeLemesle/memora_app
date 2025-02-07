import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/album/data/repositories/album_repository.dart';
import 'package:memora_app/features/album/domain/usecases/fetch_albums.dart';
import 'package:memora_app/features/album/presentation/blocs/album_bloc.dart';
import 'package:memora_app/features/album/presentation/widgets/album_description.widget.dart';
import 'package:memora_app/features/album/presentation/widgets/album_cover.widget.dart';

class AlbumOverview extends StatelessWidget {
  const AlbumOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumBloc(
        fetchAlbums: FetchAlbums(
          repository: AlbumRepository(),
        ),
      )..add(FetchAlbumsEvent()),
      child: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumErrorState) {
            return Center(child: Text(state.message));
          } else if (state is AlbumLoadedState) {
            final albums = state.albums;

            if (albums.isEmpty) {
              return const Center(child: Text('Aucun album trouvé'));
            }

            return Container(
              height: 644,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(right: 24),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: albums.length,
                separatorBuilder: (context, index) => const SizedBox(width: 24),
                itemBuilder: (context, index) {
                  final album = albums[index];

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CoverPage(
                        title: album.title,
                        backgroundImage: album.backgroundImage,
                        dateStart: album.dateStart,
                        dateEnd: album.dateEnd,
                        members: album.members,
                      ),
                      const SizedBox(height: 24),
                      AlbumDescription(
                        owner: album.owner,
                        description: album.description,
                        totalPages: album.totalPages,
                        usedPages: album.usedPages,
                      ),
                    ],
                  );
                },
              ),
            );
          }

          // Afficher un état par défaut si aucune condition ne correspond
          return const SizedBox();
        },
      ),
    );
  }
}
