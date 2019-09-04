import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:long_life_burning/screen/login/login_screen.dart';
  

class BaseAuth extends SignInPage {
  String _email;
  String _password;

  //  void validateAndSubmit() async{
  //   if (validateAndSave()){
  //      FirebaseAuth user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
  //      print('igned in: ${user.uid}');
  //   }
  //   catch (e){
  //     print('Error:$e');
  //   }
  // }
}