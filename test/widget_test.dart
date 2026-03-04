import 'package:blackhole/Helpers/update.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('update check tests', () {
    test('compareVersion should return true if update is available', () {
      const String currentVersion = '1.1.2';
      const String latestVersion = '1.1.3';

      final result = compareVersion(currentVersion, latestVersion);

      expect(result, equals(true));
    });

    test('compareVersion should return false if update is not available', () {
      const String currentVersion = '1.1.2';
      const String latestVersion = '1.1.2';

      final result = compareVersion(currentVersion, latestVersion);

      expect(result, equals(false));
    });
  });
}
