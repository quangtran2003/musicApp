import 'package:do_an/module/play_music/play_music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';

import '../../../const.dart';
import '../../../refactoring/icon.dart';
import '../../../refactoring/text.dart';

class FirstPage extends GetView<PlayMusicController> {
  final double height;
  final double width;
  const FirstPage({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    // Get.changeTheme(theme)
    return Column(
      children: [
        Obx(() => controller.trackData.value != null
            ? Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                height: height / 2.5,
                width: width * 4 / 5,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: NetworkImage(
                          controller.trackData.value?.album?.coverMedium ?? ''),
                      fit: BoxFit.cover),
                  shape: BoxShape.rectangle,
                ),
              )
            : SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    height: height * 2 / 5,
                    width: width * 3.5 / 5,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              )),
        Obx(
          () => Container(
            child: Lottie.asset(
              'assets/menody.json',
              height: 50,
              animate: controller.isPlaying.value,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  controller.getLinkSong(context,
                      controller.trackData.value?.preview ?? '', height);
                },
                child: const MyIcon(
                  icon: Icons.share,
                ),
              ),
              Obx(() {
                if (controller.trackData.value != null) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(ARTIST_SCREEN,
                          arguments: controller.trackData.value?.artist?.id);
                    },
                    child: MyText(
                        fontSize: 17,
                        text: controller.trackData.value?.artist?.name ?? ''),
                  );
                } else {
                  return const SkeletonLine(
                    style: SkeletonLineStyle(width: 100),
                  );
                }
              }),
              GestureDetector(
                onTap: () {
                  controller.checkFavorite();
                },
                child: Obx(
                  () => MyIcon(
                      icon: controller.isFavorite.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          controller.isFavorite.value ? Colors.purple : null),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            children: [
              Obx(
                () => Slider(
                  inactiveColor: const Color.fromARGB(255, 185, 113, 197),
                  activeColor: const Color.fromARGB(255, 44, 12, 50),
                  min: 0.0,
                  max: controller.durationInt.value.toDouble(),
                  value: controller.positionInt.value.toDouble(),
                  onChanged: (value) {
                    controller.audioPlayer
                        .seek(Duration(seconds: value.toInt()));
                  },
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    Text(controller.positionString.value),
                    Expanded(flex: 1, child: Container()),
                    controller.durationString.value != null
                        ? Text('${controller.durationString.value}')
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  controller.onLoopListTrack();
                },
                child: Obx(
                  () => MyIcon(
                    icon: Icons.shuffle,
                    color:
                        controller.loopListTrack.value ? Colors.purple : null,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.backSong();
                },
                child: const MyIcon(
                  icon: Icons.skip_previous,
                  size: 40,
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.checkPlaying();
                },
                child: Obx(
                  () => Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          controller.isPlaying.value
                              ? "assets/pause.png"
                              : "assets/play.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    controller.nextSong();
                  },
                  child: const MyIcon(icon: Icons.skip_next, size: 40)),
              GestureDetector(
                onTap: () {
                  controller.onLoopSong();
                },
                child: Obx(() => controller.loopSong.value
                    ? const MyIcon(
                        icon: Icons.repeat_one,
                        color: Colors.purple,
                      )
                    : const MyIcon(
                        icon: Icons.repeat,
                      )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void handleIconClick(BuildContext context, String link) async {
    saveLink(link);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Đường link tạm thời đã được lưu: $link"),
      ),
    );
  }

  void saveLink(String link) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('temporaryLink', link);
  }
}
