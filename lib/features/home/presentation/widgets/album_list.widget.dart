import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/presentation/blocs/album.bloc.dart';
import 'package:memora_app/features/home/presentation/widgets/album_cover.widget.dart';
import 'package:memora_app/features/home/presentation/widgets/album_description.widget.dart';

class AlbumList extends StatelessWidget {
  final List<AlbumEntity> albums;
  const AlbumList({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 644,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 24),
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.85,
          initialPage: 0,
        ),
        padEnds: false,
        itemCount: albums.length + 1,
        itemBuilder: (context, index) {
          if (index < albums.length) {
            final album = albums[index];

            // Fetch the user with the ownerId
            return Padding(
              padding: const EdgeInsets.only(right: 24),
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(album.ownerId)
                    .snapshots(),
                builder: (context, snapshot) {
                  final userName =
                      snapshot.data?.get('name') ?? 'Utilisateur inconnu';

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 24,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/album_page',
                            arguments: album,
                          );
                        },
                        child: CoverPage(
                          title: album.title,
                          backgroundImage: album.backgroundImage,
                          startDate: album.startDate,
                          endDate: album.endDate,
                          members: album.members ?? [],
                        ),
                      ),
                      AlbumDescription(
                        owner: userName,
                        description: album.description ?? '',
                      ),
                    ],
                  );
                },
              ),
            );
          } else {
            // Add the button to create a new album
            return Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 450,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    color: Colors.transparent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 16,
                    children: [
                      ButtonWidget(
                        label: '',
                        variant: ButtonVariant.tertiary,
                        size: ButtonSize.big,
                        iconPosition: ButtonIcon.only,
                        icon: CupertinoIcons.add,
                        onPressed: () async {
                          final albumBloc = context.read<AlbumBloc>();
                          final currentUser = FirebaseAuth.instance.currentUser;

                          final result = await Navigator.of(context)
                              .pushNamed('/new_album_page');

                          if (result == true && currentUser != null) {
                            albumBloc.fetchAlbums(currentUser.uid);
                          }
                        },
                      ),
                      Text(
                        "Créer un nouvel album",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
