import 'package:do_an/playlist/playlist_controller.dart';
import 'package:get/get.dart';

class PlaylistBinDing extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayListController());
  }
}
