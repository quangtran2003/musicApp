import 'dart:math';
import 'package:get/get.dart';

import 'package:do_an/net_working/models/tracklist_artist.dart';
import 'package:do_an/responstory/all_responstory.dart';

class TracklistArtistController extends GetxController {
  final _listTrackRespon = Responstory();
  final tracklistArtist = Rxn<TracklistArtistModel>();
  final listTrack = Rxn<List<TracklistArtistModel>>();
  final id = RxnString();
  late List<String> list; // Khai báo biến listRandom

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
      }
    }
    list = listRandom;
    return listRandom;
  }

  Future<void> getRandom(int index) async {
    print(list);
    final value = await _listTrackRespon.getTracklistArtist(list[index]);
    tracklistArtist.value = value;
  }

  Future getTracklistArtist(String? id) async {
    final value = await _listTrackRespon.getTracklistArtist(id ?? '');
    tracklistArtist.value = value;
    print(tracklistArtist.value);
  }
}
