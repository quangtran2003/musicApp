// ignore_for_file: file_names

import 'package:do_an/const.dart';
import 'package:do_an/module/play_music/model_song_transfer.dart';
import 'package:do_an/module/play_music/play_music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SongBottom extends GetView<PlayMusicController> {
  const SongBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(controller.trackData.value?.title !=null) {
          Get.toNamed(PLAY_MUSIC_SCREEN, arguments: ModelSongTransfer(isSongBottom: true));
        }
      },
      child:   Obx(
        () =>controller.trackData.value?.title==null? SizedBox():  Container(
          height: 70,
          child: ListTile(
            leading: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  image: controller
                              .trackData.value?.album?.coverSmall !=null? DecorationImage(
                      image: NetworkImage(controller
                              .trackData.value?.album?.coverSmall??'' ),
                      fit: BoxFit.cover):
                      DecorationImage(image: AssetImage('assets/bgSong.png'), fit: BoxFit.cover)
                      ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    onTap: () {
                      controller.backSong();
                    },
                    child: const Icon(Icons.skip_previous)),
                GestureDetector(
                  onTap: () {
                    controller.checkPlaying();
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: controller.isPlaying.value
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow)),
                ),
                GestureDetector(
                    onTap: () {
                      controller.nextSong();
                    },
                    child: const Icon(Icons.skip_next)),
              ],
            ),
            subtitle: Text(
              controller.trackData.value?.artist?.name ?? '',
            ),
            title: Text(
              controller.trackData.value?.title ?? 'Click a song!',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
