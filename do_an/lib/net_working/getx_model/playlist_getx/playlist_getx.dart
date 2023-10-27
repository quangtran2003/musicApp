import 'dart:math';
import 'package:do_an/net_working/models/playlist.dart';
import 'package:get/get.dart';
import 'package:do_an/responstory/all_responstory.dart';

class PlaylistController extends GetxController {
  final _playlistRespon = Responstory();
  final playlist = Rxn<PlaylistModel>();
  final id = RxnString();

  Future getPlaylist() async {
    playlist.value = await _playlistRespon.getPlaylist(id.value ?? '');
  }
}
