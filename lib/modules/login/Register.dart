// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:long_life_burning/screen/login/login_screen.dart';
// import 'dart:async';

// String _email;
// String _password;
// String _displayName;
// PersistentBottomSheetController _sheetController;
//  bool _loading = false;
//   bool _autoValidate = false;
//   String errorMsg = "";

// Future<void> _validateRegisterInput({
//   BuildContext context,
//   GlobalKey<FormState> formKey,
// }) async {
//       final FormState form = formKey.currentState;
//       if (formKey.currentState.validate()) {
//         form.save();
//         _sheetController.setState(() {
//           _loading = true;
//         });
//         try {
//           AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
//           UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
//           userUpdateInfo.displayName = _displayName;
//           // user.updateProfile(userUpdateInfo).then((onValue) {
//           //   Navigator.of(context).pushReplacementNamed('/home');
//           //   Firestore.instance.collection('users').document().setData(
//           //       {'email': _email, 'displayName': _displayName}).then((onValue) {
//           //       _sheetController.setState(() {
//           //       _loading = false;
//           //     });
//           //   });
//           // });
//         } catch (error) {
//           switch (error.code) {
//             case "ERROR_EMAIL_ALREADY_IN_USE":
//               {
//                 _sheetController.setState(() {
//                   errorMsg = "This email is already in use.";
//                   _loading = false;
//                 });
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         content: Container(
//                           child: Text(errorMsg),
//                         ),
//                       );
//                     });
//               }
//               break;
//             case "ERROR_WEAK_PASSWORD":
//               {
//                 _sheetController.setState(() {
//                   errorMsg = "The password must be 6 characters long or more.";
//                   _loading = false;
//                 });
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         content: Container(
//                           child: Text(errorMsg),
//                         ),
//                       );
//                     });
//               }
//               break;
//             default:
//               {
//                 _sheetController.setState(() {
//                   errorMsg = "";
//                 });
//               }
//           }
//         }
//       }
// }