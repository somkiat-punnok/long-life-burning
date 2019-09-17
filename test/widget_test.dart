import 'package:flutter_test/flutter_test.dart';
import 'package:long_life_burning/screen/app.dart';
import 'package:long_life_burning/utils/helper/icons.dart';
import 'package:long_life_burning/utils/widgets/platform.dart' show isMaterial;

void main() {
  testWidgets('Widget test at index app', (WidgetTester tester) async {
    await tester.pumpWidget(App());
    expect(find.text('Step Counts'), findsOneWidget);
    expect(find.text(DateTime.now().day.toString()), findsOneWidget);
    expect(find.text(DateTime.now().year.toString()), findsOneWidget);
    expect(find.byIcon(isMaterial ? IconAndroid.home : IconiOS.home), findsOneWidget);
    expect(find.byIcon(isMaterial ? IconAndroid.near_me : IconiOS.near_me), findsOneWidget);
    expect(find.byIcon(isMaterial ? IconAndroid.marathon : IconiOS.marathon), findsOneWidget);
    expect(find.byIcon(isMaterial ? IconAndroid.group : IconiOS.group), findsOneWidget);
    expect(find.byIcon(isMaterial ? IconAndroid.menu : IconiOS.menu), findsOneWidget);
  });
}
