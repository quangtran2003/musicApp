import 'package:do_an/components/text.dart';
import 'package:do_an/components/text_field.dart';
import 'package:do_an/const.dart';
import 'package:do_an/language/language_constant.dart';
import 'package:do_an/module/login_resiger/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    final x = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: x,
          color: Get.isDarkMode
              ? Theme.of(context).scaffoldBackgroundColor
              : const Color.fromARGB(255, 245, 229, 246),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              _buildImageBackground(x),
              Container(
                  alignment: Alignment.bottomLeft,
                  child: MyText(
                    text: translation().login,
                    color: Colors.purple,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
              Obx(
                () => MyTextField(
                  errorText: controller.userNameError.value,
                  textHint:translation().enterEmail,
                  textColor: Colors.purple,
                  onChange: (value) {
                    controller.validateUserName(value);
                    controller.login();
                  },
                ),
              ),
              Obx(
                () => MyTextField(
                  errorText: controller.passWordError.value,
                  onChange: (value) {
                    controller.validatePassWord(value);
                    controller.login();
                  },
                  textHint: translation().password,
                  hasPass: true,
                  textColor: Colors.purple,
                ),
              ),
              _buildBottomLogin(context),
              Obx(() {
                if (controller.showErrorSignIn.value != null) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: controller.showErrorSignIn.value ?? '',
                      color: Colors.red,
                    ),
                  );
                } else {
                  return Container();
                }
              }),
              _buildRichText(),
              SizedBox(
                height: x > 500 ? 80 : 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildRichText() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RESEGER_SCREEN);
      },
      child: Container(
        alignment: Alignment.centerRight,
        child: Text.rich(TextSpan(
            text: translation().doNotHaveAccount,
            style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 104, 104, 104)),
            children: [
              TextSpan(
                  text: translation().resiger,
                  style: TextStyle(
                      fontSize: 17,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.purple,
                      color: Colors.purple))
            ])),
      ),
    );
  }

  Expanded _buildImageBackground(double x) {
    return Expanded(
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 80, bottom: 40),
          height: x / 3,
          width: x / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                  image: AssetImage(
                    'assets/home_login.png',
                  ),
                  opacity: 0.9,
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }

  GestureDetector _buildBottomLogin(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        if (controller.checkLogin.value) {
          controller.signInAcc(controller.userName.value ?? '', controller.passWord.value ?? '');
          if (controller.checkAccount.value == CHECK_ACCOUNT.Success) {
            Navigator.pushReplacementNamed(context, MAIN_SCREEN);
          }
        }
      },
      child: Obx(
        () => Container(
            margin: const EdgeInsets.only(top: 30, bottom: 15),
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
                color: controller.checkLogin.value ? Colors.purple : null,
                border: Border.all(width: 1, color: const Color.fromARGB(255, 104, 104, 104)),
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: MyText(
                  text: translation().login,
                  color: controller.checkLogin.value ? Colors.white : Colors.grey,
                  fontSize: 20),
            )),
      ),
    );
  }
}
