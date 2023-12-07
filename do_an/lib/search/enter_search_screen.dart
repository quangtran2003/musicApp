// ignore_for_file: invalid_use_of_protected_member

import 'package:do_an/const.dart';
import 'package:do_an/net_working/models/search.dart';
import 'package:do_an/refactoring/container_album.dart';
import 'package:do_an/refactoring/icon.dart';
import 'package:do_an/refactoring/song.dart';
import 'package:do_an/refactoring/text.dart';
import 'package:do_an/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../play_music/play_music_controller.dart';

// ignore: must_be_immutable
class EnterSearchScreen extends GetView<ControllerSearch> {
  final _controllerPlayM = Get.put(PlayMusicController());
  final PageController _pageController = PageController(initialPage: 0);
  EnterSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.initIndex();
    return Scaffold(
      body: Container(
        color: constColor,
        child: Column(
          children: [
            AppBar(
              toolbarHeight: 60,
              elevation: 1,
              backgroundColor: constColor,
              automaticallyImplyLeading: false,
              leading: GestureDetector(
                onTap: () {
                  controller.restartData();
                  Get.back();
                },
                child: const MyIcon(
                  icon: Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              title: Container(
                margin: const EdgeInsets.only(right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildListTitle('Song', 0),
                    _buildListTitle('Album', 1),
                    _buildListTitle('Artist', 2),
                  ],
                ),
              ),
            ),
            Expanded(
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      controller.clickTiTle(value);
                    },
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      final value = controller.searchData.value;
                      switch (index) {
                        case 0:
                          return _buildSongSearch();
                        case 1:
                          if (value?.data?.length == 0 ||
                              value?.data?.length == null) {
                            return const SizedBox(
                              // height: 400,
                              child: Center(
                                child: Text('No result'),
                              ),
                            );
                          } else {
                            return _buildAlbumSearch(value);
                          }

                        case 2:
                          {
                            final value = controller.searchData.value;

                            if (value?.data?.length == 0 ||
                                value?.data?.length == null) {
                              return const SizedBox(
                                // height: 400,
                                child: Center(
                                  child: Text('No result'),
                                ),
                              );
                            } else {
                              return _buildArtistSearch(value);
                            }
                          }
                        //);
                        default:
                      }
                      return null;
                    }))
          ],
        ),
      ),
    );
  }

  Widget _buildArtistSearch(SearchModel? value) {
    return Obx(
      () => Container(
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
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${controller.uniqueArtists[index]?.pictureSmall}'),
                                fit: BoxFit.cover)),
                      ),
                      Expanded(
                          child:
                              Text('${controller.uniqueArtists[index]?.name}')),
                      const MyIcon(
                        icon: Icons.navigate_next_outlined,
                        color: Colors.black,
                        size: 25,
                      )
                    ],
                  ),
                );
              })),
    );
  }

  Widget _buildAlbumSearch(SearchModel? value) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
            itemCount: controller.uniqueAlbums.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              if (value == null) {
                return SkeletonItem(
                    child: Expanded(
                        child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ))));
              }
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
      ),
    );
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
                          // ignore: unrelated_type_equality_checks
                          index == controller.indexTitle.value
                              ? Colors.black
                              : Colors.grey),
                ),
                // ignore: unrelated_type_equality_checks
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
        return const SizedBox(
          // height: 400,
          child: Center(
            child: Text('No result'),
          ),
        );
      } else {
        return SizedBox(
            //height: 400,
            child: ListView.builder(
                itemCount: value?.data?.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        _controllerPlayM.stopMusic();

                        Get.toNamed(PLAY_MUSIC_SCREEN,
                            //arguments: value?.data?[index].id);
                            arguments: {
                              'songId': value?.data?[index].id,
                              'listTrack': controller.tracks.value,
                              'listIdSong': controller.listIdSong
                            });
                      },
                      child: MySong(
                        url: value?.data?[index].album?.coverSmall,
                        subTitle: value?.data?[index].artist?.name,
                        title: value?.data?[index].title,
                      ));
                }));
      }
    });
  }
}
