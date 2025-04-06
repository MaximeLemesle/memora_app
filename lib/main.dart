import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/config/theme/app_theme.dart';
import 'package:memora_app/features/album/data/data_sources/album.data_source.dart';
import 'package:memora_app/features/album/data/repositories/album.repository_impl.dart';
import 'package:memora_app/features/album/domain/usecases/create_new_album.usecase.dart';
import 'package:memora_app/features/album/domain/usecases/get_album_by_id.usecase.dart';
import 'package:memora_app/features/album/domain/usecases/get_albums_by_user.usecase.dart';
import 'package:memora_app/features/album/presentation/blocs/album.bloc.dart';
import 'package:memora_app/features/album/presentation/pages/album.page.dart';
import 'package:memora_app/features/album/presentation/pages/new_album.page.dart';
import 'package:memora_app/features/home/presentation/pages/home.page.dart';
import 'package:memora_app/features/landing/presentation/pages/landing.page.dart';
import 'package:memora_app/features/page/data/data_sources/page.data_source.dart';
import 'package:memora_app/features/page/data/repositories/page.repository_impl.dart';
import 'package:memora_app/features/page/domain/usecases/create_new_page.usecase.dart';
import 'package:memora_app/features/page/domain/usecases/get_pages_by_album.usecase.dart';
import 'package:memora_app/features/page/presentation/blocs/page.bloc.dart';
import 'package:memora_app/features/user/data/data-sources/user.data_source.dart';
import 'package:memora_app/features/user/data/repositories/user.repository_impl.dart';
import 'package:memora_app/features/user/domain/usecases/get_user.usecase.dart';
import 'package:memora_app/features/user/presentation/blocs/user.bloc.dart';
import 'package:memora_app/firebase_options.dart';
import 'package:memora_app/features/auth/presentation/pages/login.page.dart';
import 'package:memora_app/features/auth/presentation/pages/signup.page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final userRepository = UserRepositoryImpl(
    dataSource: UserDataSource(firestore: FirebaseFirestore.instance),
  );
  final albumRepository = AlbumRepositoryImpl(
    dataSource: AlbumDataSource(firestore: FirebaseFirestore.instance),
  );
  final pageRepository = PageRepositoryImpl(
    dataSource: PageDataSource(firestore: FirebaseFirestore.instance),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(
            GetUser(userRepository),
          ),
        ),
        BlocProvider(
          create: (context) => AlbumBloc(
            GetAlbumsByUser(albumRepository),
            GetAlbumById(albumRepository),
            CreateNewAlbum(albumRepository),
          ),
        ),
        BlocProvider<PageBloc>(
          create: (context) => PageBloc(
            GetPagesByAlbum(pageRepository),
            CreateNewPage(pageRepository),
          ),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memora',
      navigatorObservers: [routeObserver],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
      ],
      locale: const Locale('fr', 'FR'),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightMode,
      routes: {
        '/landing_page': (context) => const LandingPage(),
        '/home_page': (context) => const HomePage(),
        '/login_page': (context) => const LoginPage(),
        '/signup_page': (context) => const SignUpPage(),
        '/new_album_page': (context) => const NewAlbumPage(),
        '/album_page': (context) => const AlbumPage(),
      },
      initialRoute: '/landing_page',
    );
  }
}
