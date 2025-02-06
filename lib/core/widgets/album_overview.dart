import 'package:flutter/material.dart';
import 'package:memora_app/features/album/data/models/album_model.dart';
import 'package:memora_app/features/album/data/repositories/album_repository.dart';
import 'package:memora_app/features/album/presentation/album_description.dart';
import 'package:memora_app/features/album/presentation/pages/cover_page.dart';

class AlbumOverview extends StatefulWidget {
  const AlbumOverview({super.key});

  @override
  State<AlbumOverview> createState() => _AlbumOverviewState();
}

class _AlbumOverviewState extends State<AlbumOverview> {
  late final AlbumRepository albumRepository;

  @override
  void initState() {
    super.initState();
    albumRepository = AlbumRepository();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AlbumModel>>(
      future: albumRepository.fetchAlbums(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Aucun album trouvé'));
        }

        final albums = snapshot.data!;

        return SizedBox(
          height: 644,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: albums.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: 24), // Espacement entre les éléments
            itemBuilder: (context, index) {
              final album = albums[index];

              return Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CoverPage(
                      title: album.title,
                      backgroundImage: album.backgroundImage,
                      dateStart: album.dateStart,
                      dateEnd: album.dateEnd,
                    ),
                    SizedBox(height: 24),
                    AlbumDescription(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
