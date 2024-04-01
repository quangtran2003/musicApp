import 'package:do_an/components/text.dart';
import 'package:do_an/components/text_field.dart';
import 'package:do_an/const.dart';
import 'package:do_an/module/login_resiger/resiger/resiger_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Resiger extends GetView<ResigerController> {
  const Resiger({super.key});

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: x,
          width: y,
          color: Get.isDarkMode
              ? Theme.of(context).scaffoldBackgroundColor
              : const Color.fromARGB(255, 245, 229, 246),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              _buildImageBackground(x),
              Container(
                alignment: Alignment.bottomLeft,
                child: const Text(
                  'Resiger',
                  style: TextStyle(color: Colors.purple, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Obx(
                () => MyTextField(
                  textHint: 'Enter your email',
                  textColor: Colors.purple,
                  errorText: controller.emailError.value,
                  onChange: (value) {
                    controller.validateEmail(value);
                    controller.resiger();
                  },
                ),
              ),
              Obx(
                () => MyTextField(
                  textHint: 'Pass word',
                  textColor: Colors.purple,
                  hasPass: true,
                  errorText: controller.passWordError.value,
                  onChange: (value) {
                    controller.validatePassWord(value);
                    controller.resiger();
                  },
                ),
              ),
              Obx(
                () => MyTextField(
                  textHint: 'Confrim pass word',
                  hasPass: true,
                  textColor: Colors.purple,
                  errorText: controller.confrimPassWordError.value,
                  onChange: (value) {
                    controller.validateConfrimPassWord(value);
                    controller.resiger();
                  },
                ),
              ),
              _buildBottomResiger(x, context),
              _buildRichText(context),
              SizedBox(
                height: x > 500 ? 50 : 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Obx _buildBottomResiger(
    double x,
    BuildContext context,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.createAcc(controller.email.value ?? '', controller.passWord.value ?? '');
          if (controller.checkResiger.value) {
            Navigator.pushReplacementNamed(context, MAIN_SCREEN);
          }
        },
        child: Container(
          margin: EdgeInsets.only(
            top: 30,
          ),
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
              color: controller.checkResiger.value ? Colors.purple : null,
              border: Border.all(width: 1, color: const Color.fromARGB(255, 104, 104, 104)),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: MyText(
              text: "Resiger",
              color: controller.checkResiger.value ? Colors.white : Colors.grey,
              fontSize: 20,
            ),
          ),
        ),
        // ),
      ),
    );
  }

  GestureDetector _buildRichText(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final data = await controller.signInWithGoogle();
        final user = data.user;
        print(user);
        if (user != null) {
          Navigator.pushReplacementNamed(context, MAIN_SCREEN);
        } else {
          Get.snackbar('Notification', 'Sign fail! Try again');
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        alignment: Alignment.centerRight,
        child: Text.rich(TextSpan(
            text: 'Sign with ',
            style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 104, 104, 104)),
            children: [
              TextSpan(
                  text: 'Google',
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
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 40, bottom: 20),
          height: x * 2 / 7,
          width: x * 2 / 7,
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
}
