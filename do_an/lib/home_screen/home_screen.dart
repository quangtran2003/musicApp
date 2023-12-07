// ignore_for_file: invalid_use_of_protected_member, override_on_non_overriding_member

import 'package:do_an/const.dart';
import 'package:do_an/home_screen/homecontroller.dart';
import 'package:do_an/refactoring/appBar.dart';
import 'package:do_an/refactoring/container_album.dart';
import 'package:do_an/refactoring/song.dart';
import 'package:do_an/refactoring/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../play_music/play_music_controller.dart';

class HomeScreen extends GetView<HomeController> {
  final _controllerPlayM = Get.put(PlayMusicController());

  HomeScreen({super.key});
  @override
  void onInit() {
    controller.randomId();
  }

  @override
  Widget build(BuildContext context) {
    controller.getArtist();
    controller.getSong();
    final x = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      color: constColor,
      child: Column(
        children: [
          MyAppBarHomePage(
            title: Container(
                margin: const EdgeInsets.only(top: 20),
                child: MyText(
                  text: 'Listen now',
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            height: 0.8,
            color: Colors.black54,
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: const Text(
              'Artist',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              height: x / 3,
              child: Obx(
                () => PageView.builder(
                  controller: PageController(
                    viewportFraction: 0.75,
                  ),
                  itemCount: controller.artists.length,
                  itemBuilder: (context, index) {
                    final data = controller.artists[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(ARTIST_SCREEN,
                            arguments: data.data?[0].artist?.id);
                      },
                      child: MyContainerAlbum(
                          urlImage:
                              data.data?[0].contributors?[0].pictureMedium ??
                                  '',
                          boderRadius: 20,
                          mytext: MyText(
                            text: data.data?[0].contributors?[0].name ?? '',
                            fontSize: 20,
                          )),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              'New Songs',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Obx(() {
            return Container(
              padding: const EdgeInsets.only(left: 25, right: 20),
              child: ListView.builder(
                itemCount: controller.tracks.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _controllerPlayM.stopMusic();

                      Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
                        'songId': controller.tracks[index].id,
                        'listTrack': controller.tracks.value,
                        'listIdSong': controller.listIdSong
                      });
                    },
                    child: MySong(
                      url: controller.tracks[index].album?.coverSmall,
                      title: controller.tracks[index].title,
                      subTitle: controller.tracks[index].artist?.name,
                    ),
                  );
                },
              ),
            );
          }))
        ],
      ),
    ));
  }
}
