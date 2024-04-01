// ignore_for_file: invalid_use_of_protected_member

import 'package:do_an/module/play_music/play_music_controller.dart';
import 'package:do_an/module/playlist/playlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../../components/icon.dart';
import '../../components/song.dart';
import '../../components/text.dart';
import '../../const.dart';

class PlaylistScreen extends GetView<PlayListController> {
  final _controllerPlayM = Get.put(PlayMusicController());
  PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int? id = ModalRoute.of(context)?.settings.arguments as int;
    controller.getPlaylistData(id);

    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(),
          _buildImagePlaylist(x, y),
          _buildBottomPlayMusic(y),
          _buildListSong()
        ],
      ),
    );
  }

  Obx _buildListSong() {
    return Obx(() {
      if (controller.playlistData.value == null) {
        return Expanded(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SkeletonListTile(
                      leadingStyle: SkeletonAvatarStyle(
                          borderRadius: BorderRadius.circular(10), width: 55, height: 55),
                      titleStyle: const SkeletonLineStyle(width: 300),
                      subtitleStyle: const SkeletonLineStyle(width: 50),
                    );
                  })),
        );
      } else {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
                itemCount: controller.playlistData.value?.tracks?.data?.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      _controllerPlayM.stopMusic();
                      Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
                        'songId': controller.playlistData.value?.tracks?.data?[index].id,
                        'listTrack': controller.tracks.value,
                        'listIdSong': controller.listIdSong
                      });
                    },
                    child: MySong(
                        title: controller.playlistData.value?.tracks?.data?[index].title,
                        subTitle: controller.playlistData.value?.tracks?.data?[index].artist?.name,
                        urlImage:
                            controller.playlistData.value?.tracks?.data?[index].album?.coverSmall),
                  );
                })),
          ),
        );
      }
    });
  }

  GestureDetector _buildBottomPlayMusic(double y) {
    return GestureDetector(
      onTap: () {
        _controllerPlayM.stopMusic();

        Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
          'songId': controller.playlistData.value?.tracks?.data?[0].id,
          'listTrack': controller.tracks.value,
          'listIdSong': controller.listIdSong
        });
      },
      child: Container(
        height: 40,
        width: y,
        margin: const EdgeInsets.fromLTRB(38, 0, 38, 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.purple),
        child: MyText(
          text: 'Play music now',
          color: Colors.white,
        ),
      ),
    );
  }

  Obx _buildImagePlaylist(double x, double y) {
    return Obx(() => controller.playlistData.value != null
        ? Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            height: x / 2.5,
            width: y * 4 / 5,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                  image: NetworkImage(controller.playlistData.value?.pictureMedium ?? ''),
                  fit: BoxFit.cover),
              shape: BoxShape.rectangle,
            ),
          )
        : SkeletonAvatar(
            style: SkeletonAvatarStyle(
                padding: const EdgeInsets.symmetric(vertical: 20),
                height: y * 4 / 5,
                width: y * 4 / 5,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
          ));
  }

  AppBar _buildAppBar() {
    return AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const MyIcon(
            icon: Icons.arrow_back_ios,
            size: 25,
          ),
        ),
        title: Obx(() => controller.playlistData.value != null
            ? Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(right: 65),
                child: MyText(
                  text: controller.playlistData.value?.title ?? '',
                  fontSize: 25,
                ),
              )
            : const Padding(
                padding: EdgeInsets.only(left: 60),
                child: Center(
                  child: SkeletonLine(
                    style: SkeletonLineStyle(width: 200),
                  ),
                ),
              )));
  }
}
