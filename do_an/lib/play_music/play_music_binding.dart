import 'package:do_an/play_music/play_music_controller.dart';
import 'package:get/get.dart';

class PlayMusicBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PlayMusicController());
  }
}
