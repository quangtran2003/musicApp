import 'package:do_an/const.dart';
import 'package:do_an/module/login_resiger/resiger/resiger_controller.dart';
import 'package:do_an/refactoring/text.dart';
import 'package:do_an/refactoring/text_field.dart';
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
          color: const Color.fromARGB(255, 245, 229, 246),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              _buildImageBackground(x),
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
                  textHint: 'Enter your email',
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
                  errorText: controller.confrimPassWordError.value,
                  onChange: (value) {
                    controller.validateConfrimPassWord(value);
                    controller.resiger();
                  },
                ),
              ),
              _buildBottomResiger(x),
            ],
          ),
        ),
      ),
    );
  }

  Obx _buildBottomResiger(double x) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.createAcc(
              controller.email.value ?? '', controller.passWord.value ?? '');
          if (controller.checkResiger.value) {
            Get.toNamed(MAIN_SCREEN);
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: 30, bottom: x > 500 ? 50 : 20),
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
              color: controller.checkResiger.value ? Colors.purple : null,
              border: Border.all(
                  width: 1, color: const Color.fromARGB(255, 104, 104, 104)),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
              child: MyText(
            text: "Resiger",
            color: controller.checkResiger.value ? Colors.white : Colors.grey,
            fontSize: 20,
          ),),
        ),
        // ),
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
