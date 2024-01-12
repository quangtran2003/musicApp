// ignore_for_file: prefer_is_empty

import 'package:do_an/const.dart';
import 'package:do_an/module/play_music/play_music_controller.dart';
import 'package:do_an/module/user/user_controller.dart';
import 'package:do_an/net_working/models/track.dart';
import 'package:do_an/refactoring/appBar.dart';
import 'package:do_an/refactoring/icon.dart';
import 'package:do_an/refactoring/song.dart';
import 'package:do_an/refactoring/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreen extends GetView<UserController> {
  final _controllerPlayM = Get.put(PlayMusicController());

  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadHistoryPlay();
    controller.loadPlaylist();
    controller.loadfavourite();
    final x = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: constColor,
      child: Column(children: [
        _buildAppBar(),
        _buidGridView(context, x),
        _buildHistoryPlay()
      ]),
    ));
  }

  Container _buidGridView(BuildContext context, double x) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(15),
      child: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          Obx(() => _buildMyContainer('PlayList', context, x,
              controller.playlistTracks, controller.playlist.value)),
          Obx(() => _buildMyContainer('Favourite', context, x,
              controller.favouriteTracks, controller.favourite.value))
        ],
      ),
    );
  }

  Widget _buildHistoryPlay() {
    return Expanded(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: MyText(
              text: 'Listening history',
              textAlign: TextAlign.start,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.historyTracks.length == 0) {
                return MyText(text: 'No result!');
              } else {
                return ListView.builder(
                    itemCount: controller.historyTracks.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _controllerPlayM.stopMusic();
                          List<int> intList = controller.historyPlay.value
                                  ?.map((str) => int.parse(str))
                                  .toList() ??
                              [];
                          Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
                            'songId': controller.historyTracks[index].id,
                            'listTrack': controller.historyTracks,
                            'listIdSong': intList
                          });
                        },
                        child: MySong(
                          url:
                              controller.historyTracks[index].album?.coverSmall,
                          title: controller.historyTracks[index].title,
                          subTitle:
                              controller.historyTracks[index].artist?.name,
                        ),
                      );
                    });
              }
            }),
          ),
        ],
      ),
    );
  }

  Column _buildAppBar() {
    return Column(
      children: [
        MyAppBarHomePage(
          title: Container(
              margin: const EdgeInsets.only(top: 20),
              child:  MyText(
                text: 'Me',
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
      ],
    );
  }

  Widget _buildMyContainer(String text, BuildContext context, double x,
      RxList<TrackModel> tracks, List<String>? listId) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (builderContext) {
              return _buildBottomSheet(x, text, tracks, listId);
            });
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(3, 1),
                blurRadius: 3,
                spreadRadius: 5,
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.all(8.0),
              child: MyIcon(
                icon: text == 'Favourite'
                    ? Icons.favorite
                    : Icons.playlist_play_sharp,
                color: Colors.purple,
                size: 40,
              ),
            ),
            Expanded(child: Container()),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 20, bottom: 15),
              child: MyText(
                text: text,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(
              () => Container(
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.only(left: 20, bottom: 15),
                child: MyText(
                  text: tracks.length.toString(),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SafeArea _buildBottomSheet(
      double x, String text, RxList<TrackModel> tracks, List<String>? listId) {
    return SafeArea(
        child: Container(
      height: x * 3 / 4,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          const Center(
            child: Icon(
              Icons.menu,
              size: 35,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: MyText(
                text: text,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: const Size(double.infinity, 40),
                  foregroundColor: Colors.white),
              child: GestureDetector(
                  onTap: () {
                    _controllerPlayM.stopMusic();
                    List<int> intList =
                        listId?.map((str) => int.parse(str)).toList() ?? [];
                    Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
                      'songId': tracks[0].id,
                      'listTrack': tracks,
                      'listIdSong': intList
                    });
                  },
                  child: MyText(text: 'Play music now!')),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    if (tracks.length == 0) {
                      return MyText(text: 'No result!');
                    } else {
                      return GestureDetector(
                        onTap: () {
                          _controllerPlayM.stopMusic();
                          List<int> intList =
                              listId?.map((str) => int.parse(str)).toList() ??
                                  [];
                          Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
                            'songId': tracks[index].id,
                            'listTrack': tracks,
                            'listIdSong': intList
                          });
                        },
                        child: MySong(
                          widget: GestureDetector(
                            onTap: () {
                              Get.back();
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (builderContext) {
                                    return _buildNotification(text, index);
                                  });
                            },
                            child: const Icon(Icons.delete),
                          ),
                          url: tracks[index].album?.coverSmall,
                          title: tracks[index].title,
                          subTitle: tracks[index].artist?.name,
                        ),
                      );
                    }
                  }))
        ],
      ),
    ));
  }

  SafeArea _buildNotification(String text, int index) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        height: 150,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Notification',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const Text('Confirm deletion?'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red,
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            text == "Favourite"
                                ? controller.deletefavourite(index)
                                : controller.deletePlaylist(index);

                            Get.back();
                          },
                          child: const Text(
                            'Contiune',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
