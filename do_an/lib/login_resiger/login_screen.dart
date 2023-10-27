import 'package:do_an/const.dart';
import 'package:do_an/login_resiger/login_controller.dart';
import 'package:do_an/refactoring/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});
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
                Expanded(
                  child: Container(
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
                    errorText: controller.userNameError.value,
                    textHint: 'User Name',
                    textColor: Colors.purple,
                    onChange: (value) {
                      controller.validateUserName(value);
                    },
                  ),
                ),
                Obx(
                  () => MyTextField(
                    errorText: controller.passWordError.value,
                    onChange: (value) {
                      controller.validatePassWord(value);
                    },
                    textHint: 'PassWord',
                    hasPass: true,
                    textColor: Colors.purple,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(HOME_SCREEN);
                  },
                  child: Obx(
                    () => Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 15),
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: controller.checkSuccess1.value == true
                              ? controller.checkSuccess2.value == true
                                  ? Colors.purple
                                  : null
                              : null,
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 104, 104, 104)),
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
