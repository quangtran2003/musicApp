// ignore_for_file: invalid_use_of_protected_member, override_on_non_overriding_member

import 'package:do_an/components/appBar.dart';
import 'package:do_an/components/container_album.dart';
import 'package:do_an/components/divider.dart';
import 'package:do_an/components/song.dart';
import 'package:do_an/components/text.dart';
import 'package:do_an/const.dart';
import 'package:do_an/module/home_screen/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../play_music/play_music_controller.dart';

class HomeScreen extends GetView<HomeController> {
  final _controllerPlayM = Get.put(PlayMusicController(),tag: "120");
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
      child: Column(
        children: [_buildAppBar(), _buildListArtist(x), _buildListSong()],
      ),
    ));
  }

  Expanded _buildListSong() {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: MyText(text: 'New Songs', fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Obx(
              () {
                return controller.tracks.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        padding: const EdgeInsets.only(left: 25, right: 20),
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 0),
                          shrinkWrap: true,
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
                                urlImage: controller.tracks[index].album?.coverSmall,
                                title: controller.tracks[index].title,
                                subTitle: controller.tracks[index].artist?.name,
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Column _buildListArtist(double x) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: const Text(
            'Artist',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SizedBox(
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
                      Get.toNamed(ARTIST_SCREEN, arguments: data.data?[0].artist?.id);
                    },
                    child: MyContainerAlbum(
                        urlImage: data.data?[0].contributors?[0].pictureMedium ?? '',
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
      ],
    );
  }

  Column _buildAppBar() {
    return Column(
      children: [
        MyAppBarHomePage(
          title: Container(
              margin: const EdgeInsets.only(top: 20),
              child: MyText(
                text: 'Listen now',
                fontSize: 32,
                fontWeight: FontWeight.bold,
              )),
        ),
        MyDivider()
      ],
    );
  }
}
