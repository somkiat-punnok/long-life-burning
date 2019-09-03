import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:long_life_burning/screen/app.dart';

void main() {
  testWidgets('Widget test at index app', (WidgetTester tester) async {
    await tester.pumpWidget(App());
    expect(find.text('Step Counts'), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.near_me), findsOneWidget);
    expect(find.byIcon(Icons.event), findsOneWidget);
    expect(find.byIcon(Icons.group), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });
}
