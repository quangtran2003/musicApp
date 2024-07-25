import 'package:do_an/components/image.dart';
import 'package:do_an/components/text.dart';
import 'package:do_an/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyContainerAlbum extends StatelessWidget {
  final MyText mytext;
  final double? boderRadius;
  final String urlImage;
  final String? tittle;
  final double? height;
  final double? width;
  final double? left;
  final double? top;
  final double right;
  final double? buttom;

  const MyContainerAlbum({
    Key? key,
    required this.urlImage,
    this.tittle,
    required this.mytext,
    this.boderRadius,
    this.height,
    this.width,
    this.left,
    this.top,
    this.right = 20,
    this.buttom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: right),

      height: height,
      width: width,
      child: Column(children: [
        Expanded(
          flex: 3,
          child: imageNetwork(urlImage,
              height: double.infinity,
              width: double.infinity,
              radiusBL: 0,
              radiusBR: 0,
              radiusTL: 16,
              radiusTR: 16),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: mytext,
            ),

            decoration: BoxDecoration(
                color: Get.isDarkMode ? bottomDarkModeColor : pinkColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(boderRadius ?? 16),
                    bottomRight: Radius.circular(boderRadius ?? 16))),
          ),
        )
      ]),
      // decoration:
      //     BoxDecoration(borderRadius: BorderRadius.circular(30)),
    );
  }
}
