import 'dart:convert';
import 'dart:typed_data';

import 'package:blackhole/Helpers/format.dart';
import 'package:dart_des/dart_des.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FormatResponse.decode', () {
    test('should decrypt and convert http to https', () {
      const key = '38346591';
      final des = DES(key: key.codeUnits);

      const plain = 'http://example.com/audio.mp3';

      final bytes = Uint8List.fromList(utf8.encode(plain));
      final padded = _pkcs7Pad(bytes, 8);

      final encrypted = des.encrypt(padded);
      final input = base64.encode(encrypted);

      final decoded = FormatResponse.decode(input);

      expect(decoded, 'https://example.com/audio.mp3');
    });

    test('should trim extra characters after extensions (.mp3/.m4a/.mp4)', () {
      const key = '38346591';
      final des = DES(key: key.codeUnits);

      const plain = 'http://x.com/file.mp3&something=12345';

      final bytes = Uint8List.fromList(utf8.encode(plain));
      final padded = _pkcs7Pad(bytes, 8);

      final encrypted = des.encrypt(padded);
      final input = base64.encode(encrypted);

      final decoded = FormatResponse.decode(input);

      expect(decoded, 'https://x.com/file.mp3');
    });
  });
}

Uint8List _pkcs7Pad(Uint8List data, int blockSize) {
  final padLen = blockSize - (data.length % blockSize);
  final padded = Uint8List(data.length + padLen)..setAll(0, data);
  for (int i = data.length; i < padded.length; i++) {
    padded[i] = padLen;
  }
  return padded;
}
