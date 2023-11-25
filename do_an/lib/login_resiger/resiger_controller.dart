import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class ResigerController extends GetxController {
  late final FirebaseApp app;
  late final FirebaseAuth auth;
  final userNameError = RxnString();
  final passWordError = RxnString();
  final confrimPassWord = RxnString();
  final checkSuccessUserName = false.obs;
  final checkConfrimSuccessPass = false.obs;
  final checkSuccessPassW = false.obs;
  final checkResiger = false.obs;
  final confrimPassWordError = RxnString();
  final dataUser = Rxn<User>();

  void createAcc() {
    auth.createUserWithEmailAndPassword(
        email: 'toannt1234@gmail.com', password: '12345678@');
  }

// void validateUserName(value) {
//   const pattern = r'^[a-zA-Z0-9]{0,15}$';
//   const emailPattern = r'@gmail\.com$'; // Đuôi email cần kiểm tra

//   final regex = RegExp(pattern);
//   final emailRegex = RegExp(emailPattern);

//   if (regex.hasMatch(value)) {
//     userNameError.value = null;
//     checkSuccessUserName.value = true;

//     // Kiểm tra xem giá trị có chứa đuôi @gmail.com hay không
//     if (emailRegex.hasMatch(value)) {
//       print('Email is valid');
//     } else {
//       print('Email is not valid');
//     }
//   } else {
//     checkSuccessUserName.value = false;
//     userNameError.value = 'Include only letters or numbers!';
//   }
// }

  void validateUserName(value) {
    const emailPattern = r'@gmail\.com$'; // Đuôi email cần kiểm tra
    final emailRegex = RegExp(emailPattern);

    // const pattern = r'^[a-zA-Z0-9]{0,15}$';
    // final regex = RegExp(pattern);

    if (emailRegex.hasMatch(value)) {
      userNameError.value = null;
      checkSuccessUserName.value = true;
    } else {
      checkSuccessUserName.value = false;
      userNameError.value = 'Username must contain @gmail.com!';
    }
  }

  void validatePassWord(String value) {
    if (value.isEmpty) {
      passWordError.value = null;
      checkSuccessPassW.value = false;
    } else if (value.length >= 6) {
      passWordError.value = null;
      checkSuccessPassW.value = true;
    } else {
      passWordError.value = 'Minimum length 6 characters!';
      checkSuccessPassW.value = false;
    }
    confrimPassWord.value = value.toString();
  }

  void validateConfrimPassWord(value) {
    if (value.toString() == confrimPassWord.value) {
      confrimPassWordError.value = null;
      checkConfrimSuccessPass.value = true;
    } else {
      confrimPassWordError.value = 'Password was wrong!';
      checkConfrimSuccessPass.value = false;
    }
  }

  void resiger() {
    if (checkConfrimSuccessPass.value &&
        checkSuccessPassW.value &&
        checkSuccessUserName.value) {
      checkResiger.value = true;
    } else {
      checkResiger.value = false;
    }
  }
}
