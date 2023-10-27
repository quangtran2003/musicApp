import 'dart:io';
import 'package:do_an/const.dart';
import 'package:do_an/home_screen/home_binding.dart';
import 'package:do_an/home_screen/home_screen.dart';
import 'package:do_an/login_resiger/login_bindings.dart';
import 'package:do_an/login_resiger/login_screen.dart';
import 'package:do_an/login_resiger/resiger_bindings.dart';
import 'package:do_an/login_resiger/resiger_screen.dart';
import 'package:do_an/net_working/getx_model/album_getx/album_binding.dart';
import 'package:do_an/play_music/play_music_binding.dart';
import 'package:do_an/search/enter_search_screen.dart';
import 'package:do_an/search/search_binding.dart';
import 'package:do_an/search/searrch_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'album_playlist_artist/album_screen.dart';
import 'play_music/playmusic_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
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
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: HOME_SCREEN,
      getPages: [
        GetPage(
            name: HOME_SCREEN,
            page: () => HomeScreen(),
            binding: HomeBinding()),
        GetPage(
            name: PLAY_MUSIC_SCREEN,
            page: () => PlayMusicScreen(),
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
            page: () => const SearchScreen(),
            binding: SearchBinding()),
        GetPage(
            name: ENTER_SEARCH_SCREEN,
            page: () => EnterSearchScreen(),
            binding: SearchBinding()),
        GetPage(
            name: ALBUM_SCREEN,
            page: () => const AlbumScreen(),
            binding: AlbumBinding()),
        // GetPage(
        //     name: PLAYLIST_SCREEN,
        //     page: () => const Login(),
        //     binding: LoginBinding()),
        // GetPage(
        //     name: RESEGER_SCREEN,
        //     page: () => const Resiger(),
        //     binding: ResigerBinding()),
        // GetPage(
        //     name: SEARCH_SCREEN,
        //     page: () => const SearchScreen(),
        //     binding: SearchBinding()),
        // GetPage(
        //     name: ENTER_SEARCH_SCREEN,
        //     page: () => EnterSearchScreen(),
        //     binding: SearchBinding()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
