import 'package:do_an/components/icon.dart';
import 'package:do_an/components/text.dart';
import 'package:do_an/module/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const.dart';
import '../language/language_constant.dart';

class MyAppBarHomePage extends StatelessWidget {
  final controllerS = Get.put(ControllerSearch());

  final controllerSearch = Get.find<ControllerSearch>();

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
                  const MyIcon(icon: Icons.search),
                  MyText(
                    text: '${translation().search}...',
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
