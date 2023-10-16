import 'dart:io';

import 'package:do_an/const.dart';
import 'package:do_an/home_screen/home_screen.dart';
import 'package:do_an/login_resiger/login.dart';
import 'package:do_an/login_resiger/resiger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen/playmusic_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: HOME_SCREEN,
      home: HomeScreen(),
      getPages: [
        GetPage(name: HOME_SCREEN, page: () => HomeScreen()),
        GetPage(name: PLAY_MUSIC_SCREEN, page: () => PlayMusicScreen()),
        GetPage(name: LOGIN_SCREEN, page: () => Login()),
        GetPage(name: RESEGER_SCREEN, page: () => Resiger()),
        //GetPage(name: name, page: page)
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
