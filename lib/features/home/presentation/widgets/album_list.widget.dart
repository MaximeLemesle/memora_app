import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/presentation/blocs/album.bloc.dart';
import 'package:memora_app/features/home/presentation/widgets/album_description.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/add_new.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/cover_page.widget.dart';

class AlbumListWidget extends StatefulWidget {
  final User user;

  const AlbumListWidget({super.key, required this.user});

  @override
  State<AlbumListWidget> createState() => _AlbumListWidgetState();
}

class _AlbumListWidgetState extends State<AlbumListWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumBloc>().fetchAlbumsByUser(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 644,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading || state is AlbumInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumsLoaded) {
            /// Display special message if no albums are found
            if (state.albums.isEmpty) {
              return _EmptyAlbumWidget();
            }

            final albums = state.albums;

            return PageView.builder(
              controller: PageController(viewportFraction: 0.85),
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
                  child = AddNewWidget(
                    text: Text(
                      "Créer un nouvel album",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    onPressed: () async {
                      final albumBloc = context.read<AlbumBloc>();
                      final currentUser = FirebaseAuth.instance.currentUser;

                      final result = await Navigator.of(context)
                          .pushNamed('/new_album_page');

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
            );
          } else if (state is AlbumError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
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
              child: CoverPageWidget(
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

class _EmptyAlbumWidget extends StatelessWidget {
  const _EmptyAlbumWidget();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 500,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "☹️",
              style: TextStyle(fontSize: 50),
            ),
            Text(
              "Oh là là ! C'est un peu vide par ici...",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 32),
            ButtonWidget(
              label: 'Créer mon premier album',
              variant: ButtonVariant.primary,
              size: ButtonSize.big,
              iconPosition: ButtonIcon.left,
              onPressed: () async {
                final albumBloc = context.read<AlbumBloc>();
                final currentUser = FirebaseAuth.instance.currentUser;

                final result =
                    await Navigator.of(context).pushNamed('/new_album_page');

                if (result == true && currentUser != null) {
                  albumBloc.fetchAlbumsByUser(currentUser.uid);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
