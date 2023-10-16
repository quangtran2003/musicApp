import 'dart:convert';

import 'package:get/get.dart';
import 'package:do_an/net_working/models/track.dart';
import 'package:do_an/responstory/all_responstory.dart';

class TrackControllner extends GetxController {
  final _trackRespon = TrackResponstory(id: '');

  TrackModel? tracks;
  void getTrack() async {
    Map<String,dynamic> data = (await _trackRespon.getTrack()) as Map<String, dynamic>;
       final track = RxnString(jsonEncode(data));
  }
}
