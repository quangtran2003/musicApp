import 'package:do_an/net_working/models/track.dart';
import 'package:do_an/play_music/play_music_controller.dart';
import 'package:do_an/play_music/playmusic_screen/2nd_page.dart';
import 'package:do_an/play_music/playmusic_screen/first_page.dart';
import 'package:do_an/refactoring/icon.dart';
import 'package:do_an/refactoring/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../../const.dart';

class PlayMusicScreen extends GetWidget<PlayMusicController> {
  const PlayMusicScreen({super.key});
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);
    final Map<String, dynamic>? data = Get.arguments;
    final int? songId = data?['songId'] ?? 0;
    final List<TrackModel> listTrack = data?['listTrack'] ?? [];
    final List<int?> listIdSong = data?['listIdSong'] ?? [];
    final bool? isSongBottom = data?['isSongBottom'];
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    controller.initData(songId, listTrack, listIdSong, isSongBottom);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: constColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: x * 0.1,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const MyIcon(
                  icon: Icons.chevron_left,
                  size: 35,
                  color: Colors.black,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    if (controller.indexPage.value == 0) {
                      return controller.trackData.value != null
                          ? Center(
                              child: MyText(
                                  color: Colors.black,
                                  text:
                                      controller.trackData.value?.title ?? ''),
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 60),
                              child: Center(
                                child: SkeletonLine(
                                  style: SkeletonLineStyle(width: 200),
                                ),
                              ),
                            );
                    }
                    return Container(
                      alignment: Alignment.center,
                      child: MyText(
                        text: 'Music playlist',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    );
                  }),
                  IntrinsicHeight(
                    child: Container(
                      alignment: Alignment.center,
                      height: 3,
                      width: 35,
                      margin: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          cacheExtent: 500,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Obx(
                              () => Container(
                                decoration: BoxDecoration(
                                    color: controller.indexPage.value == index
                                        ? Colors.purple
                                        : const Color.fromARGB(
                                            255, 233, 129, 252),
                                    borderRadius: BorderRadius.circular(16)),
                                margin: const EdgeInsets.only(right: 3),
                                width: controller.indexPage.value == index
                                    ? 20
                                    : 10,
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
              actions: [
                Obx(() => controller.indexPage.value == 0
                    ? GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: MyIcon(
                            icon: Icons.more_horiz,
                            size: 35,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: MyIcon(
                          icon: Icons.more_horiz,
                          size: 35,
                          color: constColor,
                        ),
                      ))
              ],
            ),
            Expanded(
              flex: 1,
              child: PageView(
                  onPageChanged: (value) {
                    controller.checkIndexPage(value);
                  },
                  controller: pageController,
                  children: [
                    FirstPage(height: x, width: y),
                    SecondPage(
                        listIdSong: listIdSong,
                        listTrack: listTrack,
                        //  listViewController: listViewcontroller,
                        onSongSelected: () {
                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        })
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
