// ignore_for_file: invalid_use_of_protected_member, prefer_is_empty

import 'package:do_an/components/icon.dart';
import 'package:do_an/components/song.dart';
import 'package:do_an/components/text.dart';
import 'package:do_an/components/text_field.dart';
import 'package:do_an/const.dart';
import 'package:do_an/module/search/search_controller.dart';
import 'package:do_an/net_working/models/search.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../language/language_constant.dart';
import '../play_music/play_music_controller.dart';

class SearchScreen extends GetView<ControllerSearch> {
  final _controllerPlayM = Get.put(PlayMusicController());

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    controller.loadSearchHistory();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: MyIcon(icon: Icons.arrow_back_ios_rounded),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: y * 4.3 / 5,
                child: MyTextField(
                  autoFocus: true,
                  textHint: translation().enterYourSong,
                  textColor: Get.isDarkMode ? Colors.white : Colors.black,
                  onChange: (value) async {
                    EasyDebounce.debounce(
                        'my-debouncer', const Duration(milliseconds: 300),
                        () async {
                      await controller.getSearch(value);
                    });
                  },
                  onEditingComplete: () {
                    controller
                        .saveSearchHistory(controller.resultSearch.value ?? '');
                    Get.toNamed(ENTER_SEARCH_SCREEN);
                  },
                )),
          ),
        ],
      ),
      body: SizedBox(
        height: x,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: x,
            child: Column(
              children: [
                Obx(() {
                  final value = controller.searchData.value;
                  if (controller.checkData.value == null ||
                      value?.data?.length == 0) {
                    return _buildHistory();
                  }
                  if (value == null) {
                    return const SizedBox(
                      height: 500,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return _buildResultSearch(x, value);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildResultSearch(double x, SearchModel value) {
    return SizedBox(
        height: x,
        child: ListView.builder(
            itemCount: value.data?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.saveSearchHistory(value.data?[index].title ?? '');
                  _controllerPlayM.stopMusic();
                  Get.close(0);
                  Get.toNamed(PLAY_MUSIC_SCREEN, arguments: {
                    'songId': value.data?[index].id,
                    'listTrack': controller.tracks.value,
                    'listIdSong': controller.listIdSong
                  });
                },
                child: MySong(
                  iconLeading: Icons.search,
                  title: value.data?[index].title ?? '',
                  subTitle: value.data?[index].artist?.name ?? '',
                ),
              );
            }));
  }

  SizedBox _buildHistory() {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 30),
            alignment: Alignment.bottomLeft,
            child: MyText(
              text: translation().history,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (controller.dataHistory.value?.length == 0)
            Expanded(
              child: Center(
                child: MyText(text: translation().noResult),
              ),
            )
          else if (controller.dataHistory.value != null)
            Expanded(
              child: ListView.builder(
                  itemCount: controller.dataHistory.value?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        controller.uniqueAlbums.clear();
                        controller.uniqueArtists.clear();
                        controller.getSearch(
                            controller.dataHistory.value?[index] ?? '');

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
                                text: controller.dataHistory.value![index]),
                          )),
                    );
                  }),
            ),
        ],
      ),
    );
  }
}
