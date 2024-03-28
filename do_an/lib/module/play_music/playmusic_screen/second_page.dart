// ignore_for_file: must_be_immutable

import 'package:do_an/const.dart';
import 'package:do_an/module/play_music/play_music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/song.dart';
import '../../../net_working/models/track.dart';

class SecondPage extends GetView<PlayMusicController> {
  Function onSongSelected;
  List<TrackModel> listTrack;
  List<int?> listIdSong;

  SecondPage({
    super.key,
    required this.onSongSelected,
    required this.listTrack,
    required this.listIdSong,
  });

  @override
  Widget build(BuildContext context) {
    return controller.trackList.length!=0
        ? ListView.builder(
            itemCount: controller.trackList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onSongSelected();
                  controller.updateData(listTrack[index]);
                  controller.indexSong.value = index;
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 25, right: 20),
                  color: index == controller.indexSong.value
                      ? Get.isDarkMode
                          ? bottomDarkModeColor
                          : Colors.pink.shade50
                      : null,
                  child: Obx(
                    () => MySong(
                      url: controller.trackList[index].album?.coverSmall,
                      title: controller.trackList[index].title,
                      subTitle: controller.trackList[index].artist?.name,
                    ),
                  ),
                ),
              );
            },
          )
        : SizedBox();
  }
}
