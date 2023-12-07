import 'dart:io';

import 'package:do_an/album/albumbinding.dart';
import 'package:do_an/artist/artist_binding.dart';
import 'package:do_an/artist/artist_screen.dart';
import 'package:do_an/chart/chart_screen.dart';
import 'package:do_an/const.dart';
import 'package:do_an/home_screen/home_binding.dart';
import 'package:do_an/home_screen/home_screen.dart';
import 'package:do_an/login_resiger/login_bindings.dart';
import 'package:do_an/login_resiger/login_screen.dart';
import 'package:do_an/login_resiger/resiger_bindings.dart';
import 'package:do_an/login_resiger/resiger_screen.dart';
import 'package:do_an/main/main_binding.dart';
import 'package:do_an/main/main_screen.dart';
import 'package:do_an/play_music/play_music_binding.dart';
import 'package:do_an/playlist/playlist_binding.dart';
import 'package:do_an/playlist/playlist_screen.dart';
import 'package:do_an/search/enter_search_screen.dart';
import 'package:do_an/search/search_binding.dart';
import 'package:do_an/search/searrch_screen.dart';
import 'package:do_an/user/user_binding.dart';
import 'package:do_an/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'album/album_screen.dart';
import 'chart/chart_binding.dart';
import 'play_music/playmusic_screen/playmusic_screen.dart';

Future<void> main() async {
  // late final FirebaseApp app;
  // late final FirebaseAuth auth;
  // WidgetsFlutterBinding.ensureInitialized();
  // app = await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // auth = FirebaseAuth.instanceFor(app: app);
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: MAIN_SCREEN,
      initialBinding: MainBinding(),
      getPages: [
        GetPage(
            name: HOME_SCREEN,
            page: () => HomeScreen(),
            binding: HomeBinding()),
        GetPage(
            name: PLAY_MUSIC_SCREEN,
            page: () => const PlayMusicScreen(),
            binding: PlayMusicBinding()),
        GetPage(
            name: LOGIN_SCREEN,
            page: () => const Login(),
            binding: LoginBinding()),
        GetPage(
            name: RESEGER_SCREEN,
            page: () => const Resiger(),
            binding: ResigerBinding()),
        GetPage(
            name: SEARCH_SCREEN,
            page: () => SearchScreen(),
            binding: SearchBinding()),
        GetPage(
            name: ENTER_SEARCH_SCREEN,
            page: () => EnterSearchScreen(),
            binding: SearchBinding()),
        GetPage(
            name: ALBUM_SCREEN,
            page: () => AlbumScreen(),
            binding: AlbumBinding()),
        GetPage(
            name: CHART_SCREEN,
            page: () => ChartScreen(),
            binding: ChartBinding()),
        GetPage(
            name: ARTIST_SCREEN,
            page: () => ArtistScreen(),
            binding: ArtistBinding()),
        GetPage(
            name: PLAYLIST_SCREEN,
            page: () => PlaylistScreen(),
            binding: PlaylistBinDing()),
        GetPage(
            name: MAIN_SCREEN,
            page: () => MainScreen(),
            binding: MainBinding()),
        GetPage(
            name: USER_SCREEN,
            page: () => const UserScreen(),
            binding: UserBinding()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
