import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  FontStyle? fontStyle;
  Color? color;
  int? maxLine;
  TextAlign? textAlign;
  MyText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.color,
      this.fontStyle,
      this.maxLine,
      this.textAlign = TextAlign.center,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          fontStyle: fontStyle),
    );
  }
}
