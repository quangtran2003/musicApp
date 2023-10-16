import 'dart:io';

import 'package:dio/dio.dart';
import 'package:do_an/responstory/all_responstory.dart';
import 'package:do_an/responstory/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../net_working/chart.dart';
import '../net_working/models/artist.dart';
import '../responstory/http_sevice.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ChartResponstory c = ChartResponstory();

  TrackListArtistResponstory a = TrackListArtistResponstory(id: '5400939');

  TrackListPlaylistResponstory b =
      TrackListPlaylistResponstory(id: '1479458365');

  final List<BottomNavigationBarItem> navItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Me',
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState

    get();
  }

  void get() async {
    try {
      final response = await Dio()
          .get('https://deezerdevs-deezer.p.rapidapi.com/artist/5400939',
              options: Options(
                headers: {
                  'X-RapidAPI-Key':
                      '152022dccamsh730dc3f3b8248a6p18bb1djsnc35439081222',
                  'X-RapidAPI-Host': 'deezerdevs-deezer.p.rapidapi.com',
                },
              ));
      print(response.statusCode);
      print(response);
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.only(top: 20),
          child: const Text(
            'Listen now',
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 20, right: 20),
            child: Center(
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  Text(
                    'Search...',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 0.8,
              color: Colors.black54,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                'Playlists',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.access_alarm_outlined,
                  color: Colors.black,
                )),
            Container(
              height: x / 3.5,
              width: double.infinity,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {},
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          items: navItems,
          currentIndex: 0, // Index của tab hiện tại
          onTap: (int index) {
            // Xử lý khi người dùng chọn tab
            print('Selected tab: $index');
          },
        ),
      ),
    );
  }
}
