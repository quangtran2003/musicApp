import 'package:do_an/net_working/models/search.dart';
import 'package:do_an/responstory/all_responstory.dart';
import 'package:get/get.dart';

import '../net_working/models/track.dart';

class ControllerSearch extends GetxController {
  final _searchRespon = SearchResponstory();
  final _respon = Responstory();
  var searchData = Rxn<SearchModel>();
  var checkData = RxnBool();
  final resultSearch = Rxn<String>();
  var indexTitle = 0.obs;
  final List<String> history = [];
  Set<int> uniqueAlbumIds = {};
  RxList uniqueAlbums = [].obs;
  List<int> uniqueArtistIds = [];
  RxList uniqueArtists = [].obs;
  List<int?> listIdSong = [];
  final RxList<TrackModel> tracks = RxList.empty();

  void restartData() {
    checkData.value = null;
  }

  void gethistory(String? value) {
    if (value == null) {
      return;
    }
    history.insert(0, value);
    if (history.length >= 6) history.removeRange(5, history.length);
  }

  Future getSearch(String id) async {
    resultSearch.value = id;
    if (id == '') {
      checkData.value = false;
    } else {
      checkData.value = true;
    }
    final value = await _searchRespon.getSearch(id);
    searchData.value = value;

    tracks.clear();
    final size = searchData.value?.data?.length;
    if (size != null) {
      for (int i = 0; i < (size > 15 ? 15 : size); i++) {
        listIdSong.add(searchData.value?.data![i].id);
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

  void getListAlbum(SearchModel? value) {
    if (value != null && value.data != null) {
      for (int i = 0; i < value.data!.length; i++) {
        if (value.data![i].album != null) {
          int? albumId = value.data![i].album!.id;
          if (albumId != null && !uniqueAlbumIds.contains(albumId)) {
            uniqueAlbumIds.add(albumId);
            uniqueAlbums.add(value.data![i].album);
          }
        }
      }
    }
  }

  void getListArtist(SearchModel? value) {
    if (value != null && value.data != null) {
      for (int i = 0; i < value.data!.length; i++) {
        int? artistId = value.data?[i].artist?.id;
        if (artistId != null && !uniqueArtistIds.contains(artistId)) {
          uniqueArtistIds.add(artistId);
          uniqueArtists.add(value.data?[i].artist);
        }
      }
    }
  }

  void clickTiTle(int index) {
    final value = index;
    indexTitle.value = value;
  }

  void initIndex() {
    indexTitle.value = 0;
  }
}
