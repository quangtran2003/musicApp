import 'package:do_an/module/search/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ControllerSearch());
  }
}
