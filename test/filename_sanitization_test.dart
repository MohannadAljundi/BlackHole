import 'package:flutter_test/flutter_test.dart';

String sanitizeFileName(String input) {
  final RegExp avoid = RegExp(r'[\.\\\*\:\"\?#/;\|]');
  return input.replaceAll(avoid, '').replaceAll('  ', ' ').trim();
}

void main() {
  group('Filename sanitization tests', () {
    test('removes invalid characters', () {
      final result = sanitizeFileName('song:name?.mp3');
      expect(result.contains(':'), false);
      expect(result.contains('?'), false);
    });

    test('removes slashes and special symbols', () {
      final result = sanitizeFileName('my/song*name|test');
      expect(result.contains('/'), false);
      expect(result.contains('*'), false);
      expect(result.contains('|'), false);
    });

    test('keeps valid characters intact', () {
      final result = sanitizeFileName('My Song Name');
      expect(result, 'My Song Name');
    });

    test('removes extra spaces', () {
      final result = sanitizeFileName('My   Song');
      expect(result.contains('   '), false);
    });
  });
}
