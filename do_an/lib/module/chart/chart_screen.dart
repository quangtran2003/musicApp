// ignore_for_file: invalid_use_of_protected_member

import 'package:do_an/components/appBar.dart';
import 'package:do_an/components/divider.dart';
import 'package:do_an/components/song.dart';
import 'package:do_an/components/text.dart';
import 'package:do_an/module/chart/chart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../../components/container_album.dart';
import '../../const.dart';
import '../play_music/play_music_controller.dart';

class ChartScreen extends GetView<ChartController> {
  final _controllerPlayM = Get.find<PlayMusicController>();

  ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getChartData();
    final y = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            children: [
              _buildAppBar(y),
              _buildListArtist(),
              _buildListPlaylist(),
              _buildListSong(),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildListSong() {
    return Column(
      children: [
        Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.only(top: 25),
            child: MyText(
              text: 'Best Song',
              fontSize: 20,
              fontStyle: FontStyle.italic,
            )),
        SizedBox(
          height: 300,
          child: Obx(() {
            final value = controller.chartData.value;
            if (value != null) {
              return ListView.builder(
                  itemCount: value.tracks?.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _controllerPlayM.stopMusic();

                        Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
                          'songId': value.tracks?.data?[index].id,
                          'listTrack': controller.tracks.value,
                          'listIdSong': controller.listIdSong
                        });
                      },
                      child: MySong(
                        url: value.tracks?.data?[index].album?.coverSmall,
                        title: value.tracks?.data?[index].title,
                        subTitle: value.tracks?.data?[index].artist?.name,
                      ),
                    );
                  });
            } else {
              return SizedBox(
                height: 100,
                child: SkeletonListView(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 70,
                    );
                  },
                ),
              );
            }
          }),
        ),
      ],
    );
  }

  Column _buildListPlaylist() {
    return Column(
      children: [
        Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: MyText(
              text: 'Best Playlist',
              fontSize: 20,
              fontStyle: FontStyle.italic,
            )),
        Obx(() {
          final value = controller.chartData.value;
          if (value == null) {
            return SizedBox(
              height: 150,
              child: SkeletonListView(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  );
                },
              ),
            );
          } else {
            return Container(
              height: 150,
              padding: const EdgeInsets.only(left: 17),
              child: ListView.builder(
                  // itemExtent: 250, // Độ rộng của mỗi mục
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(PLAYLIST_SCREEN, arguments: value.playlists?.data?[index].id);
                        },
                        child: MyContainerAlbum(
                            width: 180,
                            urlImage: value.playlists?.data?[index].pictureMedium ?? '',
                            boderRadius: 16,
                            mytext: MyText(
                              text: value.playlists?.data?[index].title ?? '',
                              fontSize: 20,
                              maxLine: 1,
                            )),
                      );
                    }
                  }),
            );
          }
        }),
      ],
    );
  }

  Column _buildListArtist() {
    return Column(
      children: [
        Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.only(top: 30, bottom: 10),
            child: MyText(
              text: 'Best Artist',
              fontSize: 20,
              fontStyle: FontStyle.italic,
            )),
        Obx(() {
          final value = controller.chartData.value;
          if (value != null) {
            return SizedBox(
              height: 120,
              child: ListView.builder(
                  //  padding: EdgeInsets.symmetric(horizontal: 5),
                  scrollDirection: Axis.horizontal,
                  itemCount: value.artists?.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(ARTIST_SCREEN, arguments: value.artists?.data?[index].id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      '${value.artists?.data?[index].pictureSmall}',
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                              width: 100,
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              child: MyText(
                                  maxLine: 1,
                                  fontSize: 16,
                                  text: controller.shortenText(
                                      value.artists?.data?[index].name ?? '', 10))),
                        ],
                      ),
                    );
                  }),
            );
          } else {
            return SizedBox(
              height: 100,
              child: SkeletonListView(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                  );
                },
              ),
            );
          }
        }),
      ],
    );
  }

  Column _buildAppBar(double y) {
    return Column(
      children: [
        MyAppBarHomePage(
          title: Container(
              margin: const EdgeInsets.only(top: 20),
              child: MyText(
                text: 'CHART',
                fontSize: 32,
                fontWeight: FontWeight.bold,
              )),
        ),
        MyDivider()
      ],
    );
  }
}
