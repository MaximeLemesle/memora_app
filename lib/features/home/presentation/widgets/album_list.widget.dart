import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/presentation/blocs/album.bloc.dart';
import 'package:memora_app/features/home/presentation/widgets/album_cover.widget.dart';
import 'package:memora_app/features/home/presentation/widgets/album_description.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/add_new.widget.dart';

class AlbumListWidget extends StatelessWidget {
  final List<AlbumEntity> albums;
  const AlbumListWidget({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 644,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.85,
          initialPage: 0,
        ),
        padEnds: false,
        itemCount: albums.length + 1,
        itemBuilder: (context, index) {
          Widget child;

          if (index < albums.length) {
            /// Add all albums cover page
            final album = albums[index];
            child = _AlbumItemWidget(album: album);
          } else {
            /// Add the button to create a new album
            // child = const _AddAlbumWidget();
            child = AddNewWidget(
              text: Text(
                "Créer un nouvel album",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              onPressed: () async {
                final albumBloc = context.read<AlbumBloc>();
                final currentUser = FirebaseAuth.instance.currentUser;

                final result =
                    await Navigator.of(context).pushNamed('/new_album_page');

                if (result == true && currentUser != null) {
                  albumBloc.fetchAlbumsByUser(currentUser.uid);
                }
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

              // todo: Replace with CoverPageWidget
              child: CoverPage(
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
