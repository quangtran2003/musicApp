import 'dart:math';

import 'package:do_an/net_working/models/album.dart';
import 'package:get/get.dart';

import 'package:do_an/responstory/all_responstory.dart';

class AlbumController extends GetxController {
  final _albumRespon = Responstory();
  final album = Rxn<AlbumModel>();
  final id = RxnString();
  String getRandom() {
    List<String> albumRandom = ['Chuỗi 1', 'Chuỗi 2', 'Chuỗi 3'];
    int randomIndex = Random().nextInt(4);
    String randomString = albumRandom[randomIndex];
    return randomString;
  }

  Future getAlbum() async {
    album.value = await _albumRespon.getAlbum(id.value ?? '');
  }
}
