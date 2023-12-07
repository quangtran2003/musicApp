import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late final FirebaseApp app;
  late final FirebaseAuth auth;
  final checkAccount = Rxn<CHECK_ACCOUNT>();
  final userNameError = RxnString();
  final passWordError = RxnString();
  final checkSuccessUserName = false.obs;
  final checkSuccessPass = false.obs;
  final checkLogin = false.obs;
  final showErrorSignIn = RxnString();

  void signInAcc() {
    auth
        .signInWithEmailAndPassword(
      email: 'toannt1234@gmail.com',
      password: '12345678@',
    )
        .then((UserCredential userCredential) {
      checkAccount.value = CHECK_ACCOUNT.Success;
      print('Đăng nhập thành công: ${userCredential.user?.email}');
    }).catchError((error) {
      if (error.code == 'user-not-found') {
        checkAccount.value = CHECK_ACCOUNT.NotFound;
        showErrorSignIn.value = 'Tài khoản không tồn tại!';
        print('Tài khoản không tồn tại');
      } else {
        checkAccount.value = CHECK_ACCOUNT.AthorError;
        showErrorSignIn.value = 'Đăng nhập thất bại!';
        print('Đăng nhập thất bại: ${error.message}');
      }
    });
  }

  // void signInAcc() {
  //   auth.signInWithEmailAndPassword(
  //       email: 'toannt1234@gmail.com', password: '12345678@');
  // }

  void validateUserName(value) {
    const emailPattern = r'@gmail\.com$';
    final emailRegex = RegExp(emailPattern);
    if (emailRegex.hasMatch(value)) {
      userNameError.value = null;
      checkSuccessUserName.value = true;
    } else {
      checkSuccessUserName.value = false;
      userNameError.value = 'Username must contain @gmail.com!';
    }
  }

  void validatePassWord(value) {
    if (value.toString().length >= 6) {
      passWordError.value = null;
      checkSuccessPass.value = true;
    } else {
      passWordError.value = 'Minimum length 6 characters!';
      checkSuccessPass.value = false;
    }
  }

  void login() {
    checkLogin.value = checkSuccessPass.value && checkSuccessUserName.value;
  }
}

enum CHECK_ACCOUNT { AthorError, AlreadyExist, Success, NotFound }
