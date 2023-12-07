import 'package:do_an/refactoring/text.dart';
import 'package:flutter/material.dart';

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
      // ignore: sort_child_properties_last
      child: Column(children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(boderRadius ?? 16),
                    topRight: Radius.circular(boderRadius ?? 16)),
                image: DecorationImage(
                    image: NetworkImage(urlImage), fit: BoxFit.cover)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            // ignore: sort_child_properties_last
            child: Center(
              child: mytext,
            ),

            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 225, 225),
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
