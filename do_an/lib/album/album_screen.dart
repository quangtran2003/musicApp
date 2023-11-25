// ignore_for_file: invalid_use_of_protected_member

import 'package:do_an/album/album_controller.dart';
import 'package:do_an/const.dart';
import 'package:do_an/refactoring/icon.dart';
import 'package:do_an/refactoring/skeleton_list_song.dart';
import 'package:do_an/refactoring/song.dart';
import 'package:do_an/refactoring/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../play_music/play_music_controller.dart';

class AlbumScreen extends GetView<AlbumController> {
  final _controllerPlayM = Get.put(PlayMusicController());

  AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context)?.settings.arguments as int;
    controller.getAlbum(id);
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: constColor,
        child: Column(
          children: [
            AppBar(
                backgroundColor: constColor,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const MyIcon(
                    icon: Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                title: Obx(() => controller.albumData.value != null
                    ? Container(
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.only(right: 65),
                        child: MyText(
                          text: controller.albumData.value?.title ?? '',
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: Center(
                          child: SkeletonLine(
                            style: SkeletonLineStyle(width: 200),
                          ),
                        ),
                      ))),
            Obx(() => controller.albumData.value != null
                ? Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    height: x / 2.5,
                    width: y * 4 / 5,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(
                              controller.albumData.value?.coverMedium ?? ''),
                          fit: BoxFit.cover),
                      shape: BoxShape.rectangle,
                    ),
                  )
                : SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        height: y * 4 / 5,
                        width: y * 4 / 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                  )),
            GestureDetector(
              onTap: () {
                _controllerPlayM.stopMusic();

                Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
                  'songId': controller.albumData.value?.tracks?.data?[0].id,
                  'listTrack': controller.tracks.value,
                  'listIdSong': controller.listIdSong
                });
              },
              child: Container(
                height: 40,
                width: y,
                margin: const EdgeInsets.fromLTRB(38, 0, 38, 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple),
                child: MyText(
                  text: 'Play music now',
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.albumData.value == null) {
                  return const SkeletonListSong();
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                        itemCount:
                            controller.albumData.value?.tracks?.data?.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              _controllerPlayM.stopMusic();

                              Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
                                'songId': controller
                                    .albumData.value?.tracks?.data?[index].id,
                                'listTrack': controller.tracks.value,
                                'listIdSong': controller.listIdSong
                              });
                            },
                            child: MySong(
                                title: controller.albumData.value?.tracks
                                    ?.data?[index].title,
                                subTitle: controller.albumData.value?.tracks
                                    ?.data?[index].artist?.name,
                                url: controller.albumData.value?.tracks
                                    ?.data?[index].album?.coverSmall),
                          );
                        })),
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
