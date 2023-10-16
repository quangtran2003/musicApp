import 'package:do_an/const.dart';
import 'package:do_an/refactoring/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResigerController extends GetxController {
  final userNameError = RxnString();
  final passWordError = RxnString();
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
    confrimPassWord.value = value;
  }

  void validateConfrimPassWord(value) {
    if (value.toString() == checkConfrimPassWord.value)
      checkConfrimPassWord.value = null;
    else {
      checkConfrimPassWord.value = 'Password was wrong!';
    }
  }
}

class Resiger extends GetView {
  final _resigerController = Get.put(ResigerController());
  Resiger({super.key});

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: x,
            width: y,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/background.png',
                    ),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 20),
                  height: x * 1 / 5,
                  width: x * 1 / 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage(
                            'assets/home_login.png',
                          ),
                          fit: BoxFit.cover)),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    'Resiger',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(
                  () => MyTextField(
                    textHint: 'User name',
                    errorText: _resigerController.userNameError.value,
                    onChange: (value) {
                      _resigerController.validateUserName(value);
                    },
                  ),
                ),
                MyTextField(
                  textHint: 'Email or phone number',
                ),
                Obx(
                  () => MyTextField(
                    textHint: 'Pass word',
                    hasPass: true,
                    errorText: _resigerController.passWordError.value,
                    onChange: (value) {
                      _resigerController.validatePassWord(value);
                    },
                  ),
                ),
                Obx(
                  () => MyTextField(
                    textHint: 'Confrim pass word',
                    hasPass: true,
                    errorText: _resigerController.checkConfrimPassWord.value,
                    onChange: (value) {
                      _resigerController.validateConfrimPassWord(value);
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(PLAY_MUSIC_SCREEN);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 15),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 104, 104, 104)),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        'Resiger',
                        style: TextStyle(
                            color: Color.fromARGB(252, 244, 239, 239),
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
