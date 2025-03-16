import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/features/album/presentation/blocs/album.bloc.dart';
import 'package:memora_app/features/album/presentation/widgets/album_list.widget.dart';
import 'package:memora_app/core/widgets/main_app_bar.widget.dart';
import 'package:memora_app/core/widgets/main_nav_bar.widget.dart';
import 'package:memora_app/features/user/presentation/blocs/user.bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      context.read<UserBloc>().fetchUser(currentUser.uid);
      context.read<AlbumBloc>().fetchAlbums(currentUser.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        String username = "Invité";

        if (state is UserLoaded) {
          username = state.user.name;
        } else if (state is UserLoading) {
          username = "Chargement...";
        } else if (state is UserError) {
          username = "Erreur utilisateur";
        }

        return Scaffold(
          appBar: MainAppBar(
            username:
                username.substring(0, 1).toUpperCase() + username.substring(1),
          ),
          body: SizedBox.expand(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Mes albums',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ),
                      BlocBuilder<AlbumBloc, AlbumState>(
                        builder: (context, albumState) {
                          if (albumState is AlbumLoading) {
                            return SizedBox(
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                            );
                          } else if (albumState is AlbumError) {
                            return Center(child: Text(albumState.message));
                          } else if (albumState is AlbumLoaded) {
                            if (albumState.albums.isEmpty) {
                              return Center(
                                child: Container(
                                  height: 500,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainer,
                                    border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.outline,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(height: 32),
                                      ButtonWidget(
                                        label: 'Créer mon premier album',
                                        variant: ButtonVariant.primary,
                                        size: ButtonSize.big,
                                        iconPosition: ButtonIcon.left,
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/new_album_page',
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return AlbumList(albums: albumState.albums);
                          }
                          return Text(
                            "Une erreur s'est produite. Essayer de relancer l'application.",
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: MainNavBar(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
