import 'package:do_an/module/play_music/play_music_controller.dart';
import 'package:get/get.dart';

class PlayMusicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayMusicController(),);
  }
}
