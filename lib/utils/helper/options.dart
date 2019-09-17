import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;
import 'package:cloud_firestore/cloud_firestore.dart' show Firestore;
import 'package:firebase_auth/firebase_auth.dart'
  show
    FirebaseAuth,
    FirebaseUser;
import './constants.dart' show Gender;

class Configs {

  Configs._();

  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final Firestore store = Firestore.instance;
  static SharedPreferences pref;
  static BuildContext index_context;
  static bool fitkit_permissions;
  static String province;
  static String categories;
  static bool login = false;

}

class UserOptions {

  UserOptions._();

  static const String collection = 'users';

  // Field
  static const String uid_field = 'uid';
  static const String name_field = 'name';
  static const String gender_field = 'gender';
  static const String dateOfBirth_field = 'dateOfBirth';
  static const String height_field = 'height';
  static const String weight_field = 'weight';

  static FirebaseUser user;
  static String name;
  static String username;
  static Gender gender;
  static DateTime dateOfBirth;
  static num height;
  static num weight;
  
}
