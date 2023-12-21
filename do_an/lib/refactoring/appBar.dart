import 'package:do_an/module/search/search_controller.dart';
import 'package:do_an/refactoring/icon.dart';
import 'package:do_an/refactoring/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const.dart';

class MyAppBarHomePage extends StatelessWidget {
  final controllerSearch = Get.put(ControllerSearch());
  MyAppBarHomePage({
    Key? key,
    this.title,
    this.leading,
    this.width,
  }) : super(key: key);
  final Widget? title;
  final Widget? leading;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      automaticallyImplyLeading: false, // Tắt nút quay lại
      backgroundColor: constColor,
      elevation: 0,
      leading: leading,
      leadingWidth: leading == null ? null : width,
      title: title,
      actions: [
        GestureDetector(
          onTap: () {
            controllerSearch.restartData();
            Get.toNamed(SEARCH_SCREEN);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: Center(
              child: Row(
                children: [
                  const MyIcon(icon: Icons.search, color: Colors.black),
                  MyText(
                    text: 'Search...',
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
