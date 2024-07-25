import 'package:do_an/const.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final tabBarType = TabBarType.HOME.obs;
  final selectIndex = 0.obs;
  final RxBool isSongBottom = false.obs;
  void changeIndexScreen(int value) {
    selectIndex.value = value;
  }
}
