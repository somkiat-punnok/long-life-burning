import 'dart:io' show Platform;

bool get isMaterial => Platform.isWindows || Platform.isAndroid || Platform.isFuchsia || Platform.isLinux;
bool get isCupertino => Platform.isIOS || Platform.isMacOS;
