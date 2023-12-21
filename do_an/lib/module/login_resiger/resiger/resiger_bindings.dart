import 'package:do_an/module/login_resiger/resiger/resiger_controller.dart';
import 'package:get/get.dart';

class ResigerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResigerController());
  }
}
