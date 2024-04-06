import 'package:do_an/net_working/models/tracklist_artist.dart';
import 'package:do_an/net_working/responstory/all_responstory.dart';
import 'package:get/get.dart';

import '../../net_working/models/track.dart';

class HomeController extends GetxController {
  final indexScreen = 0.obs;
  final _listTrackRespon = Responstory();
  final tracklistArtist = Rxn<TracklistArtistModel>();
  final RxList<TracklistArtistModel> artists = RxList.empty();
  final RxList<TrackModel> tracks = RxList.empty();
  final indexSong = Rxn<int>();
  final List<String> randomIdArtist = [];
  final List<int> randomIdSong = [];

  List<int> listIdSong = [
    501565992,
    2237003397,
    501566382,
    1182617812,
    1036374992,
    433114272,
    426339732,
    2139789377,
    1819422817,
    2215762967,
  ];
  List<int> listIdArtist = [
    5400939,
    8979084,
    98020382,
    11332426,
    5291810,
    229564515,
    2409731,
    14659489,
    259,
    384236,
  ];

  // void randomArtist() {
  //   listIdArtist.clear();
  //   var random = Random();
  //   List<int> listRandom = [];
  //   while (listRandom.length < 5) {
  //     int index = random.nextInt(listIdArtist.length);
  //     int url = listIdArtist[index];
  //     if (!listRandom.contains(url)) {
  //       listRandom.add(url);
  //       listIdArtist.add(url);
  //     }
  //   }
  // }

  // Future<void> getArtist() async {
  //   List<TracklistArtistModel> result = [];
  //   for (int i = 0; i < 5; i++) {
  //     final trackItem =
  //         await _listTrackRespon.getTracklistArtist(listIdArtist[i]);
  //     if (trackItem != null) {
  //       result.add(trackItem);
  //     }
  //   }
  //   artists.value = result;
  // }
  void randomId() {
    listIdArtist.shuffle();
    listIdSong.shuffle();
  }

  Future<void> getArtist() async {
    List<TracklistArtistModel?> results = await Future.wait(
      List.generate(
          5,
          (index) => _listTrackRespon
              .getTracklistArtist(listIdArtist[index].toString())),
    );
    List<TracklistArtistModel> filteredResults = results
        .where((item) => item != null)
        .cast<TracklistArtistModel>()
        .toList();
    artists.value = filteredResults;
  }

  Future<void> getSong() async {
    List<TrackModel?> results = await Future.wait(
      List.generate(listIdSong.length,
          (index) => _listTrackRespon.getTrack(listIdSong[index].toString())),
    );
    List<TrackModel> filteredResults =
        results.where((item) => item != null).cast<TrackModel>().toList();

    tracks.value = filteredResults;
  }
}
