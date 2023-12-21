// ignore_for_file: invalid_use_of_protected_member

import 'package:do_an/module/artist/artist_controller.dart';
import 'package:do_an/refactoring/skeleton_list_song.dart';
import 'package:do_an/refactoring/song.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../../const.dart';
import '../../refactoring/icon.dart';
import '../../refactoring/text.dart';
import '../play_music/play_music_controller.dart';

class ArtistScreen extends GetView<ArtistController> {
  final _controllerPlayM = Get.put(PlayMusicController());
  ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    int? id = ModalRoute.of(context)?.settings.arguments as int;
    controller.getArtist(id);
    controller.getTrackListArtist(id);

    return Scaffold(
      body: Container(
        color: constColor,
        child: Column(
          children: [
            _buildAppBar(),
            _buildImageArtist(x, y),
            _buildBottomPlayMusic(y),
            _buildListSong()
          ],
        ),
      ),
    );
  }

  Expanded _buildListSong() {
    return Expanded(
      child: Obx(() {
        if (controller.trackListArtist.value == null) {
          return const Padding(
            padding: EdgeInsets.only(left: 10),
            child: SkeletonListSong(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
                itemCount: controller.trackListArtist.value?.data?.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      _controllerPlayM.stopMusic();
                      Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
                        'songId':
                            controller.trackListArtist.value?.data?[index].id,
                        'listTrack': controller.tracks.value,
                        'listIdSong': controller.listIdSong
                      });
                    },
                    child: MySong(
                        title: controller
                            .trackListArtist.value?.data?[index].title,
                        subTitle: controller
                            .trackListArtist.value?.data?[index].artist?.name,
                        url: controller.trackListArtist.value?.data?[index]
                            .album?.coverSmall),
                  );
                })),
          );
        }
      }),
    );
  }

  GestureDetector _buildBottomPlayMusic(double y) {
    return GestureDetector(
      onTap: () {
        _controllerPlayM.stopMusic();
        Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
          'songId': controller.trackListArtist.value?.data?[0].id,
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
            borderRadius: BorderRadius.circular(20), color: Colors.purple),
        child: MyText(
          text: 'Play music now',
          color: Colors.white,
        ),
      ),
    );
  }

  Obx _buildImageArtist(double x, double y) {
    return Obx(() => controller.artistData.value != null
        ? Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            height: x / 2.5,
            width: y * 4 / 5,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                  image: NetworkImage(
                      controller.artistData.value?.pictureMedium ?? ''),
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
        title: Obx(() => controller.artistData.value != null
            ? Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(right: 65),
                child: MyText(
                  text: controller.artistData.value?.name ?? '',
                  fontSize: 25,
                  color: Colors.black,
                ),
              )
            : Container(
                padding: const EdgeInsets.only(left: 60),
                alignment: Alignment.center,
                child: const SkeletonLine(
                  style: SkeletonLineStyle(width: 200),
                ),
              )));
  }
}
