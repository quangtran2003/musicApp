// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'package:do_an/module/play_music/play_music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../net_working/models/track.dart';
import '../../../refactoring/song.dart';

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
    return ListView.builder(
      itemCount: controller.trackList.value.length,
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
                ? Colors.pink.shade50
                : null,
            child: Obx(
              () => MySong(
                url: controller.trackList.value[index].album?.coverSmall,
                title: controller.trackList.value[index].title,
                subTitle: controller.trackList.value[index].artist?.name,
              ),
            ),
          ),
        );
      },
    );
  }
}
