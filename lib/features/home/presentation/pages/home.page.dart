import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/home/presentation/widgets/album_list.widget.dart';
import 'package:memora_app/core/widgets/main_app_bar.widget.dart';
import 'package:memora_app/core/widgets/main_nav_bar.widget.dart';
import 'package:memora_app/features/user/presentation/blocs/user.bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      context.read<UserBloc>().fetchUser(user!.uid);
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
                      AlbumListWidget(user: user!),
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
