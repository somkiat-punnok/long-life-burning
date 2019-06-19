import 'dart:io' show Platform;

class Platforms {

  Platforms._();

  static final String os = Platform.operatingSystem;

  static final bool isAndroid = Platform.isWindows || Platform.isAndroid || Platform.isFuchsia || Platform.isLinux;
  static final bool isIOS = Platform.isIOS || Platform.isMacOS;
  
}