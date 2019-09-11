import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './constants.dart' show Gender;

class UserOptions {

  UserOptions._();

  static bool login = false;
  static FirebaseAuth auth;
  static BuildContext index_context;
  static FirebaseUser user;
  static String name;
  static String username;
  static Gender gender;
  static DateTime dateOfBirth;
  static num height;
  static num weight;
  static String province;
  static String categories;
  
}
