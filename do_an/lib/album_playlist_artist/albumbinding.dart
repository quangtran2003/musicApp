import 'package:do_an/net_working/getx_model/album_getx/album_getx.dart';
import 'package:get/get.dart';

class AlbumBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AlbumController());
  }
}
