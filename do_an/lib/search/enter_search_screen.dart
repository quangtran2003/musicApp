import 'package:do_an/const.dart';
import 'package:do_an/net_working/models/search.dart';
import 'package:do_an/refactoring/icon.dart';
import 'package:do_an/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

// ignore: must_be_immutable
class EnterSearchScreen extends GetView<ControllerSearch> {
  final PageController _pageController = PageController(initialPage: 0);
  EnterSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Get.toNamed(HOME_SCREEN);
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
                    _buildListTitle('Bài hát', 0),
                    _buildListTitle('Album', 1),
                    _buildListTitle('Nghệ sĩ', 2),
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
                          return _buildSingSearch();
                        case 1:
                          if (value?.data?.length == 0 ||
                              value?.data?.length == null) {
                            return const SizedBox(
                              // height: 400,
                              child: Center(
                                child: Text('Không có kết quả'),
                              ),
                            );
                          } else {
                            return _buildAlbumSearch(value);
                          }

                        case 2:
                          //return Obx(() {
                          {
                            final value = controller.searchData.value;

                            if (value?.data?.length == 0 ||
                                value?.data?.length == null) {
                              return const SizedBox(
                                // height: 400,
                                child: Center(
                                  child: Text('Không có kết quả'),
                                ),
                              );
                            } else {
                              return _buildArtistSearch(value);
                            }
                          }
                        //);
                        default:
                      }
                    }))
          ],
        ),
      ),
    );
  }

  SizedBox _buildArtistSearch(SearchModel? value) {
    return SizedBox(
        // height: 400,
        child: ListView.builder(
            itemCount: controller.uniqueArtists.length,
            itemBuilder: (context, index) {
              print(controller.uniqueArtists[index]?.pictureSmall);
              return Row(
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
                      child: Text('${controller.uniqueArtists[index]?.name}')),
                  const MyIcon(
                    icon: Icons.navigate_next_outlined,
                    color: Colors.black,
                    size: 25,
                  )
                ],
              );
            }));
  }

  GridView _buildAlbumSearch(SearchModel? value) {
    return GridView.builder(
        itemCount: controller.uniqueAlbums.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          if (value == null) {
            return SkeletonItem(
                child: Expanded(
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.red,
                        ))));
          }
          return Container(
            margin: EdgeInsets.all(10),
            // ignore: sort_child_properties_last
            child: Column(children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      //color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(
                              '${controller.uniqueAlbums[index]?.coverMedium}'
                              // '${value.data?[index].album?.coverMedium}'
                              //"https://duhocminhkhang.com/wp-content/uploads/2020/01/T%E1%BB%95ng-h%E1%BB%A3p-h%C3%ACnh-%E1%BA%A3nh-g%C3%A1i-xinh-%C4%91eo-m%E1%BA%AFt-k%C3%ADnh-c%E1%BB%B1c-cute-10-1.jpg"
                              ),
                          fit: BoxFit.cover)),
                ),
              ),
              Container(
                // ignore: sort_child_properties_last
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Flexible(
                  child: Center(
                    child: Text(controller.uniqueAlbums[index]?.title ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                        )),
                  ),
                ),
              )
            ]),
            // decoration:
            //     BoxDecoration(borderRadius: BorderRadius.circular(30)),
          );
          ;
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

  Obx _buildSingSearch() {
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
            child: Text('Không có kết quả'),
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
                      Get.toNamed(PLAY_MUSIC_SCREEN,
                          arguments: value?.data?[index]);
                    },
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image:
                                    AssetImage('assets/sing_background.jpg'))),
                      ),
                      subtitle: Text(value?.data?[index].artist?.name ?? ''),
                      title: Flexible(
                          child: Text(value?.data?[index].title ?? '')),
                    ),
                  );
                }));
      }
    });
  }
}
