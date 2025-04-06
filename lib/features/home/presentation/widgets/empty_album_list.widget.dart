import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/features/album/presentation/blocs/album.bloc.dart';

class EmptyAlbumListWidget extends StatelessWidget {
  const EmptyAlbumListWidget({super.key});

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
