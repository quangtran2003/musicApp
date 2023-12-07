import 'package:do_an/const.dart';
import 'package:do_an/refactoring/appBar.dart';
import 'package:do_an/refactoring/icon.dart';
import 'package:do_an/refactoring/text.dart';
import 'package:do_an/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: constColor,
      child: Column(children: [
        MyAppBarHomePage(
          title: Container(
              margin: const EdgeInsets.only(top: 20),
              child: MyText(
                text: 'Me',
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          height: 0.8,
          color: Colors.black54,
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        ),
        Container(
          height: 200,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            children: [
              _buildMyContainer(Icons.download_for_offline, 'Downloaded'),
              _buildMyContainer(Icons.favorite, 'Favourite')
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: MyText(text: 'Heard recently'),
        ),
      ]),
    ));
  }

  Container _buildMyContainer(IconData icon, String text) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400, // Màu của đổ bóng
              offset: const Offset(
                  3, 1), // Độ lệch của đổ bóng theo chiều ngang và chiều dọc
              blurRadius: 3, // Bán kính mờ của đổ bóng
              spreadRadius: 5, // Bán kính lan rộng của đổ bóng
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.all(8.0),
            child: MyIcon(
              icon: icon,
              color: Colors.purple,
              size: 40,
            ),
          ),
          Expanded(child: Container()),
          Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.only(left: 20, bottom: 20),
            child: MyText(
              text: text,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.only(left: 20, bottom: 20),
            child: const Text('0'),
          ),
        ],
      ),
    );
  }
}
