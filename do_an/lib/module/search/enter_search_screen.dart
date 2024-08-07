// ignore_for_file: invalid_use_of_protected_member, prefer_is_empty

import 'package:do_an/components/container_album.dart';
import 'package:do_an/components/icon.dart';
import 'package:do_an/components/image.dart';
import 'package:do_an/components/song.dart';
import 'package:do_an/components/text.dart';
import 'package:do_an/const.dart';
import 'package:do_an/module/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../language/language_constant.dart';
import '../play_music/model_song_transfer.dart';
import '../play_music/play_music_controller.dart';

class EnterSearchScreen extends GetView<ControllerSearch> {
  final PageController _pageController = PageController(initialPage: 0);
  EnterSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [_buildAppBar(), _buildBody()],
        ),
      ),
    );
  }

  Expanded _buildBody() {
    return Expanded(
        child: PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              controller.clickTiTle(value);
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return _buildSongSearch();
                case 1:
                  return _buildAlbumSearch();
                case 2:
                  return _buildArtistSearch();
                default:
              }
              return null;
            }));
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 60,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () {
          controller.restartData();
          Get.back();
        },
        child: const MyIcon(
          icon: Icons.arrow_back_ios,
        ),
      ),
      title: Container(
        margin: const EdgeInsets.only(right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildListTitle(translation().song, 0),
            _buildListTitle(translation().album, 1),
            _buildListTitle(translation().artist, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildArtistSearch() {
    return Obx(() {
      if (controller.checkData.value == null) {
        return Center(
          child: MyText(text: translation().noResult),
        );
      }
      if (controller.searchData.value?.data == null) {
        return Container(
            // height: x,
            alignment: Alignment.center,
            child: const CircularProgressIndicator());
      }

      return Container(
          padding: const EdgeInsets.only(right: 20),
          // height: 400,
          child: ListView.builder(
              itemCount: controller.uniqueArtists.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(ARTIST_SCREEN,
                        arguments: controller.uniqueArtists[index]?.id);
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        height: 70,
                        width: 70,
                        child: imageNetwork(
                            '${controller.uniqueArtists[index]?.pictureSmall}',
                            isArtist: true),
                      ),
                      Expanded(
                          child:
                              Text('${controller.uniqueArtists[index]?.name}')),
                      const MyIcon(
                        icon: Icons.navigate_next_outlined,
                        size: 25,
                      )
                    ],
                  ),
                );
              }));
    });
  }

  Widget _buildAlbumSearch() {
    return Obx(() {
      if (controller.checkData.value == null) {
        return Center(
          child: MyText(text: translation().noResult),
        );
      }
      if (controller.searchData.value?.data == null) {
        return Container(
            // height: x,
            alignment: Alignment.center,
            child: const CircularProgressIndicator());
      }

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 0),
            itemCount: controller.uniqueAlbums.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(ALBUM_SCREEN,
                      arguments: controller.uniqueAlbums[index]?.id);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MyContainerAlbum(
                      right: 0,
                      urlImage:
                          controller.uniqueAlbums[index]?.coverMedium ?? '',
                      mytext: MyText(
                          text: controller.uniqueAlbums[index]?.title ?? '')),
                ),
              );
              //
            }),
      );
    });
  }

  GestureDetector _buildListTitle(String text, int index) {
    return GestureDetector(
        onTap: () {
          controller.clickTiTle(index);
          _pageController.animateToPage(controller.indexTitle.value,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        },
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      color:
                          index == controller.indexTitle.value
                              ? Get.isDarkMode
                                  ? Colors.white
                                  : Colors.black
                              : Colors.grey),
                ),
                index == controller.indexTitle.value
                    ? Container(
                        height: 4,
                        width: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.purple,
                        ),
                      )
                    : Container()
              ],
            )));
  }

  Obx _buildSongSearch() {
    return Obx(() {
      final value = controller.searchData.value;
      if (controller.checkData.value == null) {
        return Container();
      }
      if (value?.data == null) {
        return Container(
            // height: x,
            alignment: Alignment.center,
            child: const CircularProgressIndicator());
      }
      if (value?.data?.length == 0) {
        return SizedBox(
          child: Center(
            child: Text(translation().noResult),
          ),
        );
      } else {
        return SizedBox(
            //height: 400,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 0),
                itemCount: value?.data?.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        if (Get.isRegistered<PlayMusicController>()) {
                          Get.find<PlayMusicController>().stopMusic();
                        }
                        Get.toNamed(
                          PLAY_MUSIC_SCREEN,
                          arguments: ModelSongTransfer(
                            listIdSong: controller.listIdSong,
                            listTrack: controller.tracks.value,
                            songId: value?.data?[index].id,
                          ),
                        );
                      },
                      child: MySong(
                        urlImage: value?.data?[index].album?.coverSmall,
                        subTitle: value?.data?[index].artist?.name,
                        title: value?.data?[index].title,
                      ));
                }));
      }
    });
  }
}
