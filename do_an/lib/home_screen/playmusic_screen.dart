import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayMusicScreen extends GetView {
  PlayMusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;

    return PageView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))
                //   image: DecorationImage(
                //       image: AssetImage("assets/screen.jpg"), fit: BoxFit.cover),
                // color: Colors.white,
                ),
            child: Container(
              // margin: EdgeInsets.only(left: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAppBar(x),
                  Container(
                    //margin: EdgeInsets.symmetric(horizontal: y * 0.15),
                    height: y * 4 / 5,
                    width: y * 4 / 5,
                    decoration: const BoxDecoration(
                      //  border: Border(bottom: BorderSide(color: Colors.blue)),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/sleep.jpg",
                          ),
                          fit: BoxFit.cover),
                      // color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                          )),
                      const Text(
                        'Sơn Tùng MTP',
                        style: TextStyle(),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite,
                          ))
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: y * 0.1),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          color: Colors.grey,
                          height: 3,
                        ),
                        Row(
                          children: [
                            const Text(
                              '0:00',
                              style: TextStyle(),
                            ),
                            Expanded(child: Container()),
                            const Text(
                              '3:00',
                              style: TextStyle(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.blue,
                    margin: const EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.shuffle,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.skip_previous,
                            )),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              height: 70,
                              width: 70,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("assets/skip.png"),
                                    fit: BoxFit.cover),
                              )),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.skip_next,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.repeat,
                            )),
                      ],
                    ),
                  ),
                  _buildBottomNavigatorBar(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container _buildBottomNavigatorBar() {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildButtonIconNavigartorBar(
              Icons.playlist_add_check, "Tạo playlist"),
          _buildButtonIconNavigartorBar(Icons.timer, "Hẹn giờ"),
          _buildButtonIconNavigartorBar(
              Icons.download_for_offline, "Tải xuống"),
        ],
      ),
    );
  }

  Column _buildButtonIconNavigartorBar(IconData icons, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              icons,
              size: 30,
            )),
        const Text(
          'Hẹn giờ',
          style: TextStyle(),
        )
      ],
    );
  }

  AppBar _buildAppBar(double x) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: x * 0.1,
      leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.chevron_left,
            size: 35,
          )),
      title: const Center(
        child: Text(
          'Chúng ta không thuộc về nhau',
          style: TextStyle(color: Colors.black),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              const SnackBarThemeData();
            },
            icon: const Icon(
              Icons.more_horiz,
              size: 35,
              color: Colors.black,
            ))
      ],
    );
  }
}
