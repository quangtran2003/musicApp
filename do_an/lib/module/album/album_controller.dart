import 'package:do_an/net_working/models/album.dart';
import 'package:do_an/net_working/responstory/all_responstory.dart';
import 'package:get/get.dart';

import '../../net_working/models/track.dart';

class AlbumController extends GetxController {
  final _respon = Responstory();
  final albumData = Rxn<AlbumModel>();
  List<int?> listIdSong = [];
  final RxList<TrackModel> tracks = RxList.empty();
  final indexSong = Rxn<int>();
  int id = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    getAlbum(id);
  }

  Future<void> getAlbum(int id) async {
    final value = await _respon.getAlbum(id.toString());
    albumData.value = value;
    tracks.clear();
    final size = albumData.value?.tracks?.data?.length;
    if (size != null) {
      for (int i = 0; i < (size > 15 ? 15 : size); i++) {
        listIdSong.add(albumData.value?.tracks?.data![i].id);
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
