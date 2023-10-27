import 'package:get/get.dart';

import 'album_getx.dart';

class AlbumBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AlbumController());
  }
}
