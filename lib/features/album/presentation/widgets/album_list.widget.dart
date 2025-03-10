import 'package:flutter/material.dart';
import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/presentation/widgets/album_description.widget.dart';
import 'package:memora_app/features/album/presentation/widgets/album_cover.widget.dart';

class AlbumList extends StatelessWidget {
  final List<AlbumEntity> albums;

  const AlbumList({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 644,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: albums.length,
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          final album = albums[index];

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              CoverPage(
                title: album.title,
                backgroundImage: album.backgroundImage,
                dateStart: album.dateStart,
                dateEnd: album.dateEnd,
                members: album.members,
              ),
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
}
