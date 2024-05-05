import 'dart:io';

import 'package:do_an/const.dart';
import 'package:do_an/firebase_options.dart';
import 'package:do_an/module/album/albumbinding.dart';
import 'package:do_an/module/artist/artist_binding.dart';
import 'package:do_an/module/artist/artist_screen.dart';
import 'package:do_an/module/chart/chart_screen.dart';
import 'package:do_an/module/home_screen/home_binding.dart';
import 'package:do_an/module/home_screen/home_screen.dart';
import 'package:do_an/module/login_resiger/login/login_bindings.dart';
import 'package:do_an/module/login_resiger/login/login_screen.dart';
import 'package:do_an/module/login_resiger/resiger/resiger_bindings.dart';
import 'package:do_an/module/login_resiger/resiger/resiger_screen.dart';
import 'package:do_an/module/main/main_binding.dart';
import 'package:do_an/module/main/main_screen.dart';
import 'package:do_an/module/play_music/play_music_binding.dart';
import 'package:do_an/module/playlist/playlist_binding.dart';
import 'package:do_an/module/playlist/playlist_screen.dart';
import 'package:do_an/module/search/enter_search_screen.dart';
import 'package:do_an/module/search/search_binding.dart';
import 'package:do_an/module/search/searrch_screen.dart';
import 'package:do_an/module/user/user_binding.dart';
import 'package:do_an/module/user/user_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language/language_constant.dart';
import 'module/album/album_screen.dart';
import 'module/chart/chart_binding.dart';
import 'module/play_music/playmusic_screen/playmusic_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  Get.changeTheme(!isDarkMode ? ThemeData.light() : ThemeData.dark());
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
    static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
    Locale? _locale;

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }
    setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: MAIN_SCREEN,
      getPages: [
        GetPage(name: HOME_SCREEN, page: () => HomeScreen(), binding: HomeBinding()),
        GetPage(
            name: PLAY_MUSIC_SCREEN, page: () => PlayMusicScreen(), binding: PlayMusicBinding()),
        GetPage(name: LOGIN_SCREEN, page: () => const Login(), binding: LoginBinding()),
        GetPage(name: RESEGER_SCREEN, page: () => const Resiger(), binding: ResigerBinding()),
        GetPage(name: SEARCH_SCREEN, page: () => SearchScreen(), binding: SearchBinding()),
        GetPage(
            name: ENTER_SEARCH_SCREEN, page: () => EnterSearchScreen(), binding: SearchBinding()),
        GetPage(name: ALBUM_SCREEN, page: () => AlbumScreen(), binding: AlbumBinding()),
        GetPage(name: CHART_SCREEN, page: () => ChartScreen(), binding: ChartBinding()),
        GetPage(name: ARTIST_SCREEN, page: () => ArtistScreen(), binding: ArtistBinding()),
        GetPage(name: PLAYLIST_SCREEN, page: () => PlaylistScreen(), binding: PlaylistBinDing()),
        GetPage(name: MAIN_SCREEN, page: () => MainScreen(), binding: MainBinding()),
        GetPage(name: USER_SCREEN, page: () => UserScreen(), binding: UserBinding()),
      ],
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
    );
  }
}
