// // ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

// import 'package:do_an/firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// //import 'package:flutter_06/utils/routes.dart';
// import 'package:get/get.dart' hide Response;

// import '../main.dart';


// late final FirebaseApp app;
// late final FirebaseAuth auth;
// class Home extends StatelessWidget {
//   const Home({super.key});
//   final a = 5;

//   ButtonStyle getButtonStyle(Color color) {
//     return ButtonStyle(
//       backgroundColor: MaterialStateProperty.resolveWith(
//         (states) {
//           return color;
//         },
//       ),
//       foregroundColor: MaterialStateProperty.resolveWith((states) {
//         return Colors.white;
//       }),
//       textStyle: MaterialStateProperty.resolveWith((states) {
//         return TextStyle(fontSize: 16, color: Colors.white);
//       }),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               child: StreamBuilder<User?>(
//                 stream: auth.authStateChanges(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return TextButton(
//                         onPressed: () {
//                           auth.createUserWithEmailAndPassword(
//                               email: 'toannt1234@gmail.com',
//                               password: '12345678@');
//                         },
//                         child: Text('Register'));
//                   }
//                   return Column(
//                     children: [
//                       Text('Da co user: ${snapshot.data?.email}'),
//                       TextButton(
//                           onPressed: () async {
//                             final credental =
//                                 await auth.signInWithEmailAndPassword(
//                                     email: 'toannt1234@gmail.com',
//                                     password: '12er345678@');
//                             print(credental);
//                           },
//                           child: Text('Login'))
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<dynamic> showCustomDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (dialogContext) {
//           return GestureDetector(
//             onTap: () {
//               Get.back();
//             },
//             child: Material(
//                 color: Colors.transparent,
//                 child: Center(
//                     child: Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text('Thong bao ban can nang cap may'),
//                     ],
//                   ),
//                 ))),
//           );
//         });
//   }
// }