import 'package:flutter/material.dart';

class BottomSheetUtils {
  String? ok;
  void myBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (builderContext) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Text(ok!),
        );
      },
    );
  }
}
