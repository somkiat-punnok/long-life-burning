part of constant;

class Configs {

  Configs._();

  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final Firestore store = Firestore.instance;
  static BuildContext index_context;
  static bool fitkit_permissions;
  static String province;
  static String categories;
  static bool login = false;

  static const String collection_user = 'users';
  static const String collection_event = 'Blog';

  // Field user
  static const String uid_field = 'uid';
  static const String name_field = 'name';
  static const String gender_field = 'gender';
  static const String dateOfBirth_field = 'dateOfBirth';
  static const String height_field = 'height';
  static const String weight_field = 'weight';

}
