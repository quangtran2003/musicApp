// ignore_for_file: prefer_is_empty

import 'package:do_an/components/divider.dart';
import 'package:do_an/components/icon.dart';
import 'package:do_an/components/song.dart';
import 'package:do_an/components/text.dart';
import 'package:do_an/const.dart';
import 'package:do_an/language/language.dart';
import 'package:do_an/language/language_constant.dart';
import 'package:do_an/module/login_resiger/resiger/resiger_controller.dart';
import 'package:do_an/module/play_music/play_music_controller.dart';
import 'package:do_an/module/search/search_controller.dart';
import 'package:do_an/module/user/user_controller.dart';
import 'package:do_an/net_working/models/track.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../play_music/model_song_transfer.dart';

class UserScreen extends GetView<UserController> {
  final controllerSearch = Get.put(ControllerSearch());
  final controllerResiger = Get.put(ResigerController());
  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: MyText(
          text: translation().me,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              controllerSearch.restartData();
              Get.toNamed(SEARCH_SCREEN);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Center(
                child: Row(
                  children: [
                    const MyIcon(icon: Icons.search),
                    MyText(
                      text: translation().search,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Column(
              children: [MyDivider()],
            ),
            _buidGridView(context, x),
            _buildHistoryPlay(),
          ],
        ),
      ),
      drawer: Drawer(
        child: Obx(
          () => ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                    Flexible(
                        child: Text(
                      controller.userName.value ?? 'Unknown',
                    ))
                  ],
                ),
              ),
              ListTile(
                title: Text(translation().darkMode),
                onTap: () {
                  controller.changeDarkMode();
                },
                trailing: Stack(
                  alignment: controller.isDarkMode.value == false
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  children: [
                    Container(
                      height: 25,
                      width: 50,
                      decoration: BoxDecoration(
                          color: controller.isDarkMode.value == true
                              ? Colors.purple
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              MyDivider(
                top: 0,
                bottom: 0,
              ),
              ListTile(
                title: Text(translation().logOut),
                trailing: Icon(
                  Icons.output,
                  size: 27,
                ),
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      elevation: 0,
                      builder: (builderContext) {
                        return _buildNotification('text', 0, true, context);
                      });
                  // Get.toNamed(LOGIN_SCREEN); // Đóng drawer
                },
              ),
              MyDivider(
                top: 0,
                bottom: 0,
              ),
              ListTile(
                title: Text(
                  translation().changeLanguage,
                  maxLines: 1,
                ),
                trailing: DropdownButton<Language>(
                  iconSize: 30,
                  hint: Text(translation().language),
                  onChanged: (Language? language) async {
                    if (language != null) {
                      Locale _locale = await setLocale(language.languageCode);
                      MyApp.setLocale(context, _locale);
                    }
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize: 30),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buidGridView(BuildContext context, double x) {
    return GridView(
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        Obx(() => _buildMyContainer(translation().playlist, context, x,
            controller.playlistTracks, controller.playlist.value)),
        Obx(() => _buildMyContainer(translation().favourite, context, x,
            controller.favouriteTracks, controller.favourite.value))
      ],
    );
  }

  Widget _buildHistoryPlay() {
    return Expanded(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: MyText(
              text: translation().listeningHistory,
              textAlign: TextAlign.start,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.loadingHistory.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.historyTracks.length == 0) {
                return Center(child: MyText(text: translation().noResult));
              } else {
                return ListView.builder(
                    itemCount: controller.historyTracks.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (Get.isRegistered<PlayMusicController>()) {
                            Get.find<PlayMusicController>().stopMusic();
                          }
                          List<int> listIdSongHis = controller.historyPlay.value
                                  ?.map((str) => int.parse(str))
                                  .toList() ??
                              [];

                          Get.toNamed(
                            PLAY_MUSIC_SCREEN,
                            arguments: ModelSongTransfer(
                              listIdSong: listIdSongHis,
                              listTrack: controller.historyTracks,
                              songId: controller.historyTracks[index].id,
                            ),
                          );
                        },
                        child: MySong(
                          urlImage:
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

  Widget _buildMyContainer(String text, BuildContext context, double x,
      RxList<TrackModel> tracks, List<String>? listId) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (builderContext) {
              return _buildBottomSheet(x, text, tracks, listId, context);
            });
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(
                    0, 2), // Điều chỉnh offset để bóng xuất hiện dưới phần tử
                blurRadius: 3,
                spreadRadius: -1, // Đặt giá trị âm để đổ bóng chỉ phía dưới
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

  SafeArea _buildBottomSheet(double x, String text, RxList<TrackModel> tracks,
      List<String>? listId, BuildContext context) {
    return SafeArea(
        child: Container(
      height: x * 3 / 4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).scaffoldBackgroundColor),
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
                foregroundColor: Colors.white,
              ),
              child: GestureDetector(
                  onTap: () {
                    if (Get.isRegistered<PlayMusicController>()) {
                      Get.find<PlayMusicController>().stopMusic();
                    }
                    List<int> intList =
                        listId?.map((str) => int.parse(str)).toList() ?? [];
                    Get.toNamed(
                      PLAY_MUSIC_SCREEN,
                      arguments: ModelSongTransfer(
                        listIdSong: intList,
                        listTrack: tracks,
                        songId: tracks[0].id,
                      ),
                    );
                  },
                  child: MyText(text: translation().playMusicNow)),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    if (tracks.length == 0) {
                      return MyText(text: translation().noResult);
                    } else {
                      return GestureDetector(
                        onTap: () {
                          if (Get.isRegistered<PlayMusicController>()) {
                            Get.find<PlayMusicController>().stopMusic();
                          }
                          List<int> intList =
                              listId?.map((str) => int.parse(str)).toList() ??
                                  [];

                          Get.toNamed(
                            PLAY_MUSIC_SCREEN,
                            arguments: ModelSongTransfer(
                              listIdSong: intList,
                              listTrack: tracks,
                              songId: tracks[index].id,
                            ),
                          );
                        },
                        child: MySong(
                          widget: GestureDetector(
                            onTap: () {
                              Get.back();
                              showModalBottomSheet(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (builderContext) {
                                    return _buildNotification(
                                        text, index, false, context);
                                  });
                            },
                            child: const Icon(Icons.delete),
                          ),
                          urlImage: tracks[index].album?.coverSmall,
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

  Widget _buildNotification(
      String? text, int index, bool? isLogOut, BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Get.isDarkMode
                    ? Colors.black
                    : Theme.of(context).scaffoldBackgroundColor),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    isLogOut == true
                        ? translation().comfirm
                        : translation().noti,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                isLogOut == true
                    ? SizedBox()
                    : MyText(
                        text: translation().comfirmDelete,
                        fontWeight: FontWeight.bold,
                      ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.shade500,
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                translation().cancel,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
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
                            color: const Color.fromARGB(255, 252, 17, 0),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                if (isLogOut == true) {
                                  controllerResiger.handleSignOut();
                                  Get.offAllNamed(LOGIN_SCREEN);
                                } else {
                                  text == "Favourite"
                                      ? controller.deletefavourite(index)
                                      : controller.deletePlaylist(index);

                                  Get.back();
                                }
                              },
                              child: Text(
                                translation().contiune,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
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
        ],
      ),
    );
  }
}
