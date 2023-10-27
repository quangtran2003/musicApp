import 'package:get/get.dart';

class ResigerController extends GetxController {
  final userNameError = RxnString();
  final passWordError = RxnString();
  final comfrimPassWordError = RxnString();
  final confrimPassWord = RxnString();
  final checkSuccess1 = false.obs;
  final checkSuccess2 = false.obs;
  final checkConfrimPassWord = RxnString();
  void validateUserName(value) {
    const pattern = r'^[a-zA-Z0-9]{0,15}$';
    final regex = RegExp(pattern);

    if (regex.hasMatch(value)) {
      userNameError.value = null;
      checkSuccess1.value = true;
    } else {
      checkSuccess1.value = false;
      userNameError.value = 'Include only letters or numbers!';
    }
  }

  void validatePassWord(value) {
    if (value.toString().length >= 6) {
      passWordError.value = null;
      checkSuccess2.value = true;
    } else {
      passWordError.value = 'Minimum length 6 characters!';
      checkSuccess2.value = false;
    }
    confrimPassWord.value = value.toString();
  }

  void validateConfrimPassWord(String value) {
    print(checkConfrimPassWord.value);
    if (value == confrimPassWord.value) {
      checkConfrimPassWord.value = null;
    } else {
      checkConfrimPassWord.value = 'Password was wrong!';
    }
  }
}
