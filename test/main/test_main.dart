import 'package:long_life_burning/modules/stepcount/db/main.dart' as app;
import 'package:long_life_burning/modules/stepcount/db/main.dart';

Future main() async {
  // ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package
  // debugAutoStartRouteName = testExceptionRoute;
  // debugAutoStartRouteName = testOpenRoute;
  debugAutoStartRouteName = testManualRoute;
  // debugAutoStartRouteName = testRawRoute;
  // debugAutoStartRouteName = testTypeRoute;
  // debugAutoStartRouteName = testExpRoute;

  await app.main();
}
