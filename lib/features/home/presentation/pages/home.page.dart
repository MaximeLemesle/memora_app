import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/album/presentation/blocs/album.bloc.dart';
import 'package:memora_app/features/home/presentation/widgets/album_list.widget.dart';
import 'package:memora_app/core/widgets/main_app_bar.widget.dart';
import 'package:memora_app/core/widgets/main_nav_bar.widget.dart';
import 'package:memora_app/features/user/presentation/blocs/user.bloc.dart';
import 'package:memora_app/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  late final User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      context.read<UserBloc>().fetchUser(user!.uid);
      context.read<AlbumBloc>().fetchAlbumsByUser(user!.uid);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    if (user != null) {
      context.read<AlbumBloc>().fetchAlbumsByUser(user!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final username = _getUsername(state);

        return Scaffold(
          appBar: MainAppBar(username: username),
          body: BlocBuilder<AlbumBloc, AlbumState>(
            builder: (context, state) {
              if (state is AlbumLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AlbumError) {
                return Center(child: Text(state.message));
              } else if (state is AlbumsLoaded) {
                final albums = state.albums;
                return SizedBox.expand(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 6,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                'Mes albums',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),
                            ),
                            AlbumListWidget(albums: albums),
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
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}

String _getUsername(UserState state) {
  if (state is UserLoaded) {
    final username = state.user.name;
    return username[0].toUpperCase() + username.substring(1);
  } else if (state is UserLoading) {
    return "Chargement...";
  } else if (state is UserError) {
    return "Erreur utilisateur";
  }
  return "Invité";
}
