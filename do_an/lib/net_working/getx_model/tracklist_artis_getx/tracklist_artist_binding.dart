import 'package:do_an/net_working/getx_model/tracklist_artis_getx/tracklist_artist_getx.dart';
import 'package:get/get.dart';

class TracklistArtistBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => TracklistArtistController());
  }
}
