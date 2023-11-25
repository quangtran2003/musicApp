import 'package:do_an/const.dart';
import 'package:do_an/login_resiger/resiger_controller.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 40, bottom: 20),
                    height: x / 5,
                    width: x * 1 / 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            image: AssetImage(
                              'assets/home_login.png',
                            ),
                            fit: BoxFit.cover)),
                  ),
                ),
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
                  errorText: controller.userNameError.value,
                  onChange: (value) {
                    controller.validateUserName(value);
                    controller.resiger();
                  },
                ),
              ),
              const MyTextField(
                textHint: 'Enter your email',
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
              Obx(
                () => GestureDetector(
                  onTap: () {
                    if (controller.checkResiger.value) {
                      Get.toNamed(HOME_SCREEN);
                      controller.createAcc();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 50),
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: controller.checkResiger.value
                            ? Colors.purple
                            : null,
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 104, 104, 104)),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        'Resiger',
                        style: TextStyle(
                            color: Color.fromARGB(255, 104, 104, 104),
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
