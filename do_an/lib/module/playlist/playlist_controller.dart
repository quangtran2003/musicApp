import 'package:do_an/net_working/models/playlist.dart';
import 'package:do_an/net_working/responstory/all_responstory.dart';
import 'package:get/get.dart';

import '../../net_working/models/track.dart';

class PlayListController extends GetxController {
  final _respon = Responstory();
  final playlistData = Rxn<PlaylistModel>();
  List<int?> listIdSong = [];
  final RxList<TrackModel> tracks = RxList.empty();

  Future<void> getPlaylistData(int id) async {
    final value = await _respon.getPlaylist(id.toString());
    playlistData.value = value;
    //get list track
    tracks.clear();
    final size = playlistData.value?.tracks?.data?.length;
    if (size != null) {
      for (int i = 0; i < (size > 15 ? 15 : size); i++) {
        listIdSong.add(playlistData.value?.tracks?.data![i].id);
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
}
