import 'dart:async';

import 'package:do_an/components/icon.dart';
import 'package:do_an/components/text.dart';
import 'package:do_an/module/play_music/play_music_controller.dart';
import 'package:do_an/module/user/user_controller.dart';
import 'package:do_an/net_working/models/track.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';

import 'first_page.dart';
import 'second_page.dart';

class PlayMusicScreen extends GetWidget<PlayMusicController> {
  final _controllerUser = Get.put(UserController());
  PlayMusicScreen({super.key});
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);
    final Map<String, dynamic>? data = Get.arguments;
    final int? songId = data?['songId'] ?? null;
    final List<TrackModel> listTrack = data?['listTrack'] ?? [];
    final List<int?> listIdSong = data?['listIdSong'] ?? [];
    final bool? isSongBottom = data?['isSongBottom'];
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    controller.initData(songId, listTrack, listIdSong, isSongBottom);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAppBar(x, context, y),
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
                        onSongSelected: () {
                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                        })
                  ]),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(double x, BuildContext context, double y) {
    return AppBar(
      elevation: 0,
      toolbarHeight: x * 0.1,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },

        child: const MyIcon(
          icon: Icons.chevron_left,
          size: 35,
        ),
        //),
      ),
      title: _buildTitle(),
      actions: [_buildActions(context, y)],
    );
  }

  Obx _buildActions(BuildContext context, double y) {
    return Obx(() => controller.indexPage.value == 0
        ? GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (builderContext) {
                    return SafeArea(child: _buildBottomSheet(y, context));
                  });
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: MyIcon(
                icon: Icons.more_horiz,
                size: 35,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 20),
            child: MyIcon(
                icon: Icons.more_horiz, size: 35, color: Theme.of(context).scaffoldBackgroundColor),
          ));
  }

  Container _buildBottomSheet(double y, BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Obx(
          () => SizedBox(
            height: 200,
            width: y,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    _showTimePicker(context);
                  },
                  child: _buildButtonIconNavigartorBar(
                      Icons.timer, "Timer to turn off music", controller.isCountingDown.value),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(),
                ),
                GestureDetector(
                  onTap: () {
                    controller.checkPlaylist();
                    controller.savePlaylist();
                    _controllerUser.loadPlaylist();
                  },
                  child: _buildButtonIconNavigartorBar(
                      Icons.playlist_add, "Add to playlist", controller.isPlaylist.value),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(),
                ),
                GestureDetector(
                  onTap: () {
                    controller.checkFavorite();
                    controller.saveFavourite();
                    _controllerUser.loadfavourite();
                  },
                  child: _buildButtonIconNavigartorBar(
                      Icons.favorite_border, "Add to favourite", controller.isFavorite.value),
                ),
              ],
            ),
          ),
        ));
  }

  Column _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          if (controller.indexPage.value == 0) {
            return controller.trackData.value != null
                ? Center(
                    child: MyText(text: controller.trackData.value?.title ?? ''),
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
                              : const Color.fromARGB(255, 233, 129, 252),
                          borderRadius: BorderRadius.circular(16)),
                      margin: const EdgeInsets.only(right: 3),
                      width: controller.indexPage.value == index ? 20 : 10,
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget _buildButtonIconNavigartorBar(IconData icons, String text, bool check) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: MyIcon(
            icon: icons,
            size: 30,
            color: check ? Colors.purple : null,
          ),
        ),
        MyText(
          text: text,
          color: check ? Colors.purple : null,
        )
      ],
    );
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 5),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.purple,
            hintColor: Colors.purple,
            colorScheme: const ColorScheme.light(primary: Colors.purple),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      // Thời gian mặc định
    );

    if (pickedTime != null) {
      controller.countdownSeconds.value = pickedTime.hour * 3600 + pickedTime.minute * 60;
      controller.isCountingDown.value = true;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (controller.countdownSeconds.value > 0) {
          controller.countdownSeconds.value--;
        } else {
          timer.cancel();
          controller.isCountingDown.value = false;
          controller.pauserMusic();
        }
      });
    }
  }

  void handleIconClick(BuildContext context, String link) async {
    // Lưu đường link bằng cách sử dụng SharedPreferences
    saveLink(link);

    // Hiển thị một SnackBar để thông báo rằng đường link đã được lưu
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Đường link tạm thời đã được lưu: $link"),
      ),
    );
  }

  // Hàm lưu đường link vào SharedPreferences
  void saveLink(String link) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('temporaryLink', link);
  }
}
