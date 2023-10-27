import 'package:do_an/const.dart';
import 'package:do_an/home_screen/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final List<BottomNavigationBarItem> navItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart_rounded),
      label: 'Chart',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Me',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    controller.ranDomurl();
    print(controller.listId);
    controller.getRandom();
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false, // Tắt nút quay lại

        backgroundColor: const Color.fromARGB(255, 236, 225, 225),
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.only(top: 20),
          child: const Text(
            'Listen now',
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(SEARCH_SCREEN);
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 20, right: 20),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    Text(
                      'Search...',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 20),
        color: const Color.fromARGB(255, 236, 225, 225),
        child: Column(
          children: [
            Container(
              height: 0.8,
              color: Colors.black54,
              margin: const EdgeInsets.symmetric(horizontal: 20),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                'Playlists',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: x / 2.8,
              margin: const EdgeInsets.only(bottom: 30),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: PageView.builder(
                onPageChanged: (index) {},
                controller: PageController(
                  viewportFraction:
                      0.75, // Điều chỉnh giá trị này để kiểm soát phần trăm hiển thị// Giữ trang sau khi vuốt
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  final value = controller.listTrack[index].value;

                  // if (value == null) {
                  //   return SkeletonItem(
                  //       child: Expanded(
                  //           child: Container(
                  //               margin: const EdgeInsets.only(right: 20),
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(30),
                  //               ))));
                  // }
                  return Container(
                    margin: const EdgeInsets.only(right: 40),
                    child: Column(children: [
                      Expanded(
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                                //color: Colors.red,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '${value?.data?[index].contributors?[index].pictureMedium}'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      Obx(
                        () => Container(
                          // ignore: sort_child_properties_last
                          child: Center(
                            child: Text(
                              value?.data?[index].contributors?[index].name ??
                                  '',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          height: 90,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                        ),
                      )
                    ]),
                    // decoration:
                    //     BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                'New Songs',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    height: 70,
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))),
                        ),
                        Expanded(
                            child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                        ))
                      ],
                    ),
                  );
                },
              ),
            ))
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          items: navItems,
          currentIndex: 0, // Index của tab hiện tại
          onTap: (int index) {},
        ),
      ),
    );
  }
}
