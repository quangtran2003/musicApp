import 'package:do_an/net_working/models/artist.dart';
import 'package:do_an/net_working/models/tracklist_artist.dart';
import 'package:do_an/net_working/responstory/all_responstory.dart';
import 'package:get/get.dart';

import '../../net_working/models/track.dart';

class ArtistController extends GetxController {
  final _respon = Responstory();
  final artistData = Rxn<ArtistModel>();
  final trackListArtist = Rxn<TracklistArtistModel>();
  List<int?> listIdSong = [];
  final RxList<TrackModel> tracks = RxList.empty();
  final indexSong = Rxn<int>();

  Future<void> getArtist(int id) async {
    final value = await _respon.getArtist(id.toString());
    artistData.value = value;
  }

  Future<void> getTrackListArtist(int id) async {
    final value = await _respon.getTracklistArtist(id.toString());
    trackListArtist.value = value;

    tracks.clear();
    final size = trackListArtist.value?.data?.length;
    if (size != null) {
      for (int i = 0; i < (size > 15 ? 15 : size); i++) {
        listIdSong.add(trackListArtist.value?.data![i].id);
      }
    }
    List<TrackModel?> results = await Future.wait(
      List.generate(listIdSong.length,
          (index) => _respon.getTrack(listIdSong[index].toString())),
    );
    List<TrackModel> filteredResults =
        results.where((item) => item != null).cast<TrackModel>().toList();
    tracks.value = filteredResults;
  }

  // Future<void> getListTrack() async {
  //   tracks.clear();
  //   final value = trackListArtist.value?.data?.length;
  //   if (value != null) {
  //     for (int i = 0; i < (value > 15 ? 15 : value); i++) {
  //       listIdSong.add(trackListArtist.value?.data![i].id);
  //     }
  //   }
  //   List<TrackModel?> results = await Future.wait(
  //     List.generate(listIdSong.length,
  //         (index) => _respon.getTrack(listIdSong[index].toString())),
  //   );
  //   List<TrackModel> filteredResults =
  //       results.where((item) => item != null).cast<TrackModel>().toList();
  //   tracks.value = filteredResults;
  // }
}
