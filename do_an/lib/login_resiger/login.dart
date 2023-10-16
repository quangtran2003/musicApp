import 'package:do_an/const.dart';
import 'package:do_an/refactoring/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final userNameError = RxnString();
  final passWordError = RxnString();
  final checkSuccess1 = false.obs;
  final checkSuccess2 = false.obs;
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
  }
}

class Login extends GetView {
  Login({super.key});
  final _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: x,
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
                  margin: const EdgeInsets.only(top: 80, bottom: 40),
                  height: x * 2 / 5,
                  //    width: y * 4 / 5,
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
                    'Login',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(
                  () => MyTextField(
                    errorText: _loginController.userNameError.value,
                    textHint: 'User Name',
                    textColor: Colors.purple,
                    onChange: (value) {
                      _loginController.validateUserName(value);
                    },
                  ),
                ),
                Obx(
                  () => MyTextField(
                    errorText: _loginController.passWordError.value,
                    onChange: (value) {
                      _loginController.validatePassWord(value);
                    },
                    textHint: 'PassWord',
                    hasPass: true,
                    textColor: Colors.purple,
                  ),
                ),
                Obx(
                  () => Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 15),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: _loginController.checkSuccess1.value == true
                            ? _loginController.checkSuccess2.value == true
                                ? Colors.purple
                                : null
                            : null,
                        border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 104, 104, 104)),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Color.fromARGB(252, 244, 239, 239),
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RESEGER_SCREEN);
                  },
                  child: const Center(
                    child: Text.rich(TextSpan(
                        text: 'Do not have account ? ',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                        children: [
                          TextSpan(
                              text: 'Resiger',
                              style: TextStyle(
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.purple,
                                  color: Colors.purple))
                        ])),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
