import 'dart:math';
import 'package:get/get.dart';

import 'package:do_an/net_working/models/tracklist_artist.dart';
import 'package:do_an/responstory/all_responstory.dart';

class HomeController extends GetxController {
  final _respon = Responstory();
  final tracklistArtist = Rxn<TracklistArtistModel>();
  final List<Rxn<TracklistArtistModel>> listTrack = [];
  final id = RxnString();
  final List<String> listId = [];
  final valuee = true.obs;
  final Rx<TracklistArtistModel?> track = Rx<TracklistArtistModel?>(null);

  List<String> ranDomurl() {
    List<String> urlList = [
      '5400939',
      '8979084',
      '98020382',
      '11332426',
      '5291810',
      '229564515',
      '2409731',
      '14659489',
      '259',
      '384236',
    ];
    var random = Random();
    List<String> listRandom = [];
    while (listRandom.length < 5) {
      int index = random.nextInt(urlList.length);
      String url = urlList[index];
      if (!listRandom.contains(url)) {
        listRandom.add(url);
        listId.add(url);
      }
    }
    return listRandom;
  }

  Future<void> getRandom() async {
    listTrack.clear(); // Xóa dữ liệu cũ
    for (int i = 0; i < listId.length; i++) {
      final value = await _respon.getTracklistArtist(listId[i]);
      if (value != null) {
        listTrack.add(value as Rxn<TracklistArtistModel>);
      }
    }
  }

  Future getTracklistArtist(String? id) async {
    final value = await _respon.getTracklistArtist(id ?? '');
    tracklistArtist.value = value;
  }
}
