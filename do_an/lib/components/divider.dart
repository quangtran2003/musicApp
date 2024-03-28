import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
    this.left = 20,
    this.right = 20,
    this.top = 0,
    this.bottom = 0,
  }) : super(key: key);
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left!, top!, right!, bottom!),
      child: Divider(
        color: Get.isDarkMode ? Colors.grey : Color(0xffD9D9D9),
      ),
    );
  }
}
