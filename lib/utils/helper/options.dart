part of constant;

class Configs {

  Configs._();

  static BuildContext index_context;
  static FlutterLocalNotificationsPlugin notifyPlugin;
  static bool fitkit_permissions;
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
