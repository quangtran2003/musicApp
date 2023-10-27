import 'package:do_an/net_working/models/search.dart';
import 'package:do_an/responstory/all_responstory.dart';
import 'package:get/get.dart';

class ControllerSearch extends GetxController {
  final _searchRespon = SearchResponstory();
  final searchData = Rxn<SearchModel>();
  var checkData = RxnBool();
  var indexTitle = 0.obs;
  Set<int> uniqueAlbumIds = {};
  List<AlbumSearch?> uniqueAlbums = [];
  List<int> uniqueArtistIds = [];
  List<ArtistSearch?> uniqueArtists = [];
  void clickTiTle(int index) {
    final value = index;
    indexTitle.value = value;
  }

  Future getSearch(String id) async {
    if (id == '') {
      checkData.value = false;
    } else {
      checkData.value = true;
    }
    final value = await _searchRespon.getSearch(id);
    searchData.value = value;
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
}
