// ignore_for_file: constant_pattern_never_matches_value_type, unrelated_type_equality_checks, unused_field

import 'package:do_an/module/chart/chart_controller.dart';
import 'package:do_an/module/chart/chart_screen.dart';
import 'package:do_an/module/home_screen/home_screen.dart';
import 'package:do_an/module/home_screen/homecontroller.dart';
import 'package:do_an/module/main/main_controller.dart';
import 'package:do_an/module/user/user_controller.dart';
import 'package:do_an/module/user/user_screen.dart';
import 'package:do_an/components/songBottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class MainScreen extends GetView<MainController> {
  final _controllerHome = Get.put(HomeController());
  final _controller1Chart = Get.put(ChartController());
  final _controllerUser = Get.put(UserController());


  MainScreen({super.key});
  final _pageController = PageController(initialPage: 0);
  final List<Widget> pages = [
    HomeScreen(),
    ChartScreen(),
    UserScreen(),
  ];
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
    FlutterNativeSplash.remove();
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          controller.checkIndexScreen(value);
        },
        children: pages,
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SongBottom(),
          Obx(
            () => Container(
              child: BottomNavigationBar(
                selectedItemColor: Colors.purple,
                showSelectedLabels: true,
                elevation: 0,
                items: navItems,
                currentIndex: controller.selectIndex.value,
                onTap: (int index) {
                  controller.checkIndexScreen(index);
                  _pageController.jumpToPage(controller.selectIndex.value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
