import 'package:flutter_test/flutter_test.dart';
import 'package:blackhole/Helpers/update.dart';

void main() {
  group('compareVersion - edge cases', () {
    test('returns true when major version is higher', () {
      expect(compareVersion('1.0.0', '2.0.0'), true);
    });

    test('returns true when minor version is higher', () {
      expect(compareVersion('1.2.0', '1.3.0'), true);
    });

    test('returns true when patch version is higher', () {
      expect(compareVersion('1.2.3', '1.2.4'), true);
    });

    test('returns false when versions are equal', () {
      expect(compareVersion('1.2.3', '1.2.3'), false);
    });

    test('handles numeric ordering correctly (1.10.0 > 1.2.0)', () {
      expect(compareVersion('1.10.0', '1.2.0'), false);
      expect(compareVersion('1.2.0', '1.10.0'), true);
    });
  });
}
