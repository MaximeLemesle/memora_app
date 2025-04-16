import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/presentation/widgets/album_cover.widget.dart';
import 'package:memora_app/features/home/presentation/widgets/album_description.widget.dart';
import 'package:memora_app/features/home/presentation/widgets/empty_album_list.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/add_new.widget.dart';

class AlbumListWidget extends StatelessWidget {
  final List<AlbumEntity> albums;

  const AlbumListWidget({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    /// Display special widget if no albums are found
    if (albums.isEmpty) {
      return const EmptyAlbumListWidget();
    }

    return SizedBox(
      height: 644,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.85),
        padEnds: false,
        itemCount: albums.length + 1,
        itemBuilder: (context, index) {
          Widget child;

          if (index < albums.length) {
            /// Display the albums cover
            final album = albums[index];
            child = _AlbumItemWidget(album: album);
          } else {
            /// Display the button to create a new album
            child = AddNewWidget(
              text: Text(
                "Créer un nouvel album",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/new_album_page');
              },
            );
          }

          final isFirst = index == 0;
          final isLast = index == albums.length;

          return Padding(
            padding: EdgeInsets.only(
              left: isFirst ? 24 : 8,
              right: isLast ? 24 : 8,
            ),
            child: child,
          );
        },
      ),
    );
  }
}

class _AlbumItemWidget extends StatelessWidget {
  final AlbumEntity album;

  const _AlbumItemWidget({required this.album});

  @override
  Widget build(BuildContext context) {
    // todo: Clean the user name fetch
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(album.ownerId)
          .snapshots(),
      builder: (context, snapshot) {
        final userName = snapshot.data?.get('name') ?? 'Utilisateur inconnu';

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/album_page',
                  arguments: album,
                );
              },
              child: AlbumCoverWidget(
                title: album.title,
                backgroundImage: album.backgroundImage,
                startDate: album.startDate,
                endDate: album.endDate,
                members: album.members ?? [],
              ),
            ),
            const SizedBox(height: 24),
            AlbumDescription(
              owner: userName,
              description: album.description ?? '',
            ),
          ],
        );
      },
    );
  }
}
