// ignore_for_file: constant_pattern_never_matches_value_type, unrelated_type_equality_checks, unused_field

import 'package:do_an/module/chart/chart_screen.dart';
import 'package:do_an/module/home_screen/home_screen.dart';
import 'package:do_an/module/main/main_controller.dart';
import 'package:do_an/module/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../../components/songBottom.dart';
import '../../language/language_constant.dart';

class MainScreen extends GetView<MainController> {
  MainScreen({super.key});
  final _pageController = PageController(initialPage: 0);
  final List<Widget> pages = [
    HomeScreen(),
    ChartScreen(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          controller.changeIndexScreen(value);
        },
        children: pages,
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SongBottom(),
          Obx(
            () => Container(
              padding: EdgeInsets.only(top: 12, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  navigatorItem(translation().homePage, Icons.home, 0),
                  navigatorItem(
                      translation().chart, Icons.bar_chart_rounded, 1),
                  navigatorItem(translation().me, Icons.person, 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navigatorItem(String label, IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        controller.changeIndexScreen(index);
        _pageController.animateToPage(
          controller.selectIndex.value,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Column(
        children: [
          Icon(
            icon,
            color: controller.selectIndex.value == index ? Colors.purple : null,
          ),
          Text(
            label,
            style: TextStyle(
              color:
                  controller.selectIndex.value == index ? Colors.purple : null,
            ),
          ),
        ],
      ),
    );
  }
}
