import 'package:do_an/const.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final tabBarType = TabBarType.HOME.obs;
  final selectIndex = 0.obs;
  void checkIndexScreen(int value) {
    selectIndex.value = value;
  }
}
