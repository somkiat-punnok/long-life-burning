part of constant;

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

  static void setUser({
    String n,
    String g,
    dynamic d,
    num h,
    num w,
  }) {
    UserOptions.name = n;
    UserOptions.gender = g != null ? g.toLowerCase() != 'female' ? Gender.MALE : Gender.FEMALE : null;
    UserOptions.dateOfBirth = d != null ? DateTime.fromMicrosecondsSinceEpoch(d.microsecondsSinceEpoch) : null;
    UserOptions.height = h;
    UserOptions.weight = w;
  }

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
  static String id;
  static String name;
  static num height;
  static num weight;
  static Gender gender;
  static DateTime dateOfBirth;

  static String toValue() {
    return 'UserOptions: {name: $name, weight: $weight, height: $height, date of birth: $dateOfBirth, gender: $gender}';
  }
  
}
