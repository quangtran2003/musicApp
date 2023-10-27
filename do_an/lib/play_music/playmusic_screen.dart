import 'package:do_an/const.dart';
import 'package:do_an/net_working/models/search.dart';
import 'package:do_an/play_music/play_music_controller.dart';
import 'package:do_an/refactoring/icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PlayMusicScreen extends GetView<PlayMusicController> {
  PlayMusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DataSearch value = ModalRoute.of(context)?.settings.arguments as DataSearch;
    controller.onDurationChanged();
    controller.onPositionChanged();
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
                  Get.toNamed(HOME_SCREEN);
                },
                child: const MyIcon(
                  icon: Icons.chevron_left,
                  size: 35,
                  color: Colors.black,
                ),
              ),
              title: Center(
                child: Flexible(
                  child: Text(
                    value.title ?? '',
                    style:
                        const TextStyle(color: Color.fromARGB(255, 15, 12, 12)),
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const MyIcon(
                    icon: Icons.more_horiz,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 20),
                          height: y * 4 / 5,
                          width: y * 4 / 5,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    value.album?.coverMedium ?? ''),
                                fit: BoxFit.cover),
                            shape: BoxShape.rectangle,
                          ),
                        )),
                        Container(
                          child: Lottie.asset(
                            'assets/menody.json', // Đường dẫn đến tệp JSON Lottie trong dự án
                            height: 50, // Độ cao của widget
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const MyIcon(
                              icon: Icons.share,
                            ),
                            Text(
                              value.artist?.name ?? '',
                              style: TextStyle(),
                            ),
                            const MyIcon(
                              icon: Icons.favorite,
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(horizontal: y * 0.1),
                          child: Column(
                            children: [
                              Obx(
                                () => Slider(
                                  inactiveColor:
                                      const Color.fromARGB(255, 185, 113, 197),
                                  activeColor: Color.fromARGB(255, 44, 12, 50),
                                  min: 0.0,
                                  max: controller.durationInt.value.toDouble(),
                                  value:
                                      controller.positionInt.value.toDouble(),
                                  onChanged: (value) {
                                    controller.seek(value);
                                  },
                                ),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    Text('${controller.positionString.value}'),
                                    Expanded(child: Container()),
                                    controller.durationString.value != null
                                        ? Text(
                                            '${controller.durationString.value}')
                                        : Container(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const MyIcon(
                                icon: Icons.shuffle,
                              ),
                              const MyIcon(
                                icon: Icons.skip_previous,
                                size: 40,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.checkPlaying();
                                  controller.loadMusic(value?.preview ?? '');
                                },

                                child: Obx(
                                  () => controller.isPlaying.value
                                      ? Container(
                                          height: 70,
                                          width: 70,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/pause.png"),
                                                fit: BoxFit.cover),
                                          ))
                                      : Container(
                                          height: 70,
                                          width: 70,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/play.jpg"),
                                                fit: BoxFit.cover),
                                          )),
                                ),
                                //
                              ),
                              const MyIcon(icon: Icons.skip_next, size: 40),
                              const MyIcon(
                                icon: Icons.repeat,
                              ),
                            ],
                          ),
                        ),
                        _buildBottomNavigatorBar(),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Container _buildBottomNavigatorBar() {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildButtonIconNavigartorBar(Icons.timer, "Hẹn giờ"),
          _buildButtonIconNavigartorBar(
              Icons.playlist_add_check, "Tạo playlist"),
          _buildButtonIconNavigartorBar(
              Icons.download_for_offline, "Tải xuống"),
        ],
      ),
    );
  }

  Column _buildButtonIconNavigartorBar(IconData icons, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyIcon(
          icon: icons,
          size: 30,
        ),
        Text(text)
      ],
    );
  }
}
