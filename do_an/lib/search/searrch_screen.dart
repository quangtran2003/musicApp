import 'package:do_an/const.dart';
import 'package:do_an/refactoring/icon.dart';
import 'package:do_an/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends GetView<ControllerSearch> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 236, 225, 225),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const MyIcon(
              icon: Icons.arrow_back_ios_rounded, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: y * 4.3 / 5,
              child: TextField(
                onEditingComplete: () {
                  controller.uniqueAlbums.clear();
                  controller.uniqueArtists.clear();
                  controller.getListAlbum(controller.searchData.value);
                  controller.getListArtist(controller.searchData.value);

                  Get.toNamed(ENTER_SEARCH_SCREEN);
                },
                onChanged: (value) {
                  controller.getSearch(value);
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsetsDirectional.symmetric(
                      horizontal: 20, vertical: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'Nhập từ khóa...',
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
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
                if (controller.checkData.value == null) return Container();
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

                if (value.data?.length == 0) {
                  return const SizedBox(
                    height: 400,
                    child: Center(
                      child: Text('Không có kết quả'),
                    ),
                  );
                } else {
                  return Expanded(
                      //    height: 400,
                      child: ListView.builder(
                          itemCount: value.data?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(PLAY_MUSIC_SCREEN,
                                    arguments: value.data?[index]);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    height: 50,
                                    child: ListTile(
                                      leading: MyIcon(icon: Icons.search),
                                      subtitle: Text(
                                          value.data?[index].artist?.name ??
                                              ''),
                                      title: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  value.data?[index].title ??
                                                      '')),
                                          MyIcon(
                                              icon:
                                                  Icons.navigate_next_outlined)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
