// ignore_for_file: invalid_use_of_protected_member

import 'package:do_an/const.dart';
import 'package:do_an/refactoring/icon.dart';
import 'package:do_an/refactoring/song.dart';
import 'package:do_an/refactoring/text.dart';
import 'package:do_an/refactoring/text_field.dart';
import 'package:do_an/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../play_music/play_music_controller.dart';

class SearchScreen extends GetView<ControllerSearch> {
  final _controllerPlayM = Get.put(PlayMusicController());

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    //  controller.restartData();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 236, 225, 225),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child:
                MyIcon(icon: Icons.arrow_back_ios_rounded, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: y * 4.3 / 5,
                child: MyTextField(
                  textColor: Colors.black,
                  textHint: 'Enter your song',
                  onChange: (value) {
                    controller.getSearch(value);
                  },
                  onEditingComplete: () {
                    controller.gethistory(controller.resultSearch.value);
                    controller.uniqueAlbums.clear();
                    controller.uniqueArtists.clear();
                    controller.getListAlbum(controller.searchData.value);
                    controller.getListArtist(controller.searchData.value);

                    Get.toNamed(ENTER_SEARCH_SCREEN);
                  },
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: x,
          color: const Color.fromARGB(255, 236, 225, 225),
          child: Column(
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                  ),
                ],
              ),
              Obx(() {
                final value = controller.searchData.value;
                if (controller.checkData.value == null ||
                    value?.data?.length == 0) {
                  return SizedBox(
                    height: 500,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 30),
                          alignment: Alignment.bottomLeft,
                          child: MyText(
                            text: 'History',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (controller.history.isEmpty)
                          Expanded(
                              child: Center(child: MyText(text: 'No result')))
                        else
                          Expanded(
                            child: ListView.builder(
                                itemCount: controller.history.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller
                                          .getSearch(controller.history[index]);
                                      Get.toNamed(ENTER_SEARCH_SCREEN);
                                    },
                                    child: ListTile(
                                        leading: const Icon(Icons.search),
                                        trailing: const Icon(
                                          Icons.navigate_next_outlined,
                                          size: 30,
                                        ),
                                        title: Container(
                                          alignment: Alignment.centerLeft,
                                          child: MyText(
                                              text: controller.history[index]),
                                        )),
                                  );
                                }),
                          ),
                      ],
                    ),
                  );
                }
                if (value == null) {
                  return SizedBox(
                    height: 500,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/loading.gif'))),
                    ),
                  );
                }

                return Expanded(
                    //    height: 400,
                    child: ListView.builder(
                        itemCount: value.data?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _controllerPlayM.stopMusic();

                              Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
                                'songId': value.data?[index].id,
                                'listTrack': controller.tracks.value,
                                'listIdSong': controller.listIdSong
                              });
                            },
                            child: MySong(
                              icon: Icons.search,
                              title: value.data?[index].title ?? '',
                              subTitle: value.data?[index].artist?.name ?? '',
                            ),
                          );
                        }));
              })
            ],
          ),
        ),
      ),
    );
  }
}
