import 'package:do_an/login_resiger/resiger_controller.dart';
import 'package:get/get.dart';

class ResigerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResigerController());
  }
}
