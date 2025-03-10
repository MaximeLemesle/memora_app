import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            title: 'Bonjour,',
            name: username,
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
                              )),
                            );
                          } else if (albumState is AlbumError) {
                            return Center(child: Text(albumState.message));
                          } else if (albumState is AlbumLoaded) {
                            return AlbumList(albums: albumState.albums);
                          }
                          return Text("Pas d'album pour le moment");
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
