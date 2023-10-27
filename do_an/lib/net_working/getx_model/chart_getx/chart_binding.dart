import 'package:do_an/net_working/getx_model/chart_getx/chart_getx.dart';
import 'package:get/get.dart';

class ChartBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ChartController());
  }
}
