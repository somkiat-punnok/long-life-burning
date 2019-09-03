import 'package:flutter_test/flutter_test.dart';
import 'package:long_life_burning/modules/stepcount/db/model/test.dart';

void main() {
  group("model", () {
    test("test_sync", () async {
      bool ran = false;
      Test test = Test("test", () {
        ran = true;
      });
      await test.fn();
      expect(ran, isTrue);
    });

    test("test_async", () async {
      bool ran = false;
      Test test = Test("test", () async {
        ran = true;
      });
      await test.fn();
      expect(ran, isTrue);
    });
  });
}
