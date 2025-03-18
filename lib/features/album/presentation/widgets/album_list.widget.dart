import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
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
        itemCount: albums.length + 1,
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          if (index < albums.length) {
            final album = albums[index];

            // Fetch the user with the ownerId
            return StreamBuilder<DocumentSnapshot>(
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
                    CoverPage(
                      title: album.title,
                      backgroundImage: album.backgroundImage,
                      startDate: album.startDate,
                      endDate: album.endDate,
                      members: album.members ?? [],
                    ),
                    AlbumDescription(
                      owner: userName,
                      description: album.description ?? '',
                    ),
                  ],
                );
              },
            );
          } else {
            // Add the button to create a new album
            return Align(
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
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/new_album_page',
                        );
                      },
                    ),
                    Text(
                      "Créer un nouvel album",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
