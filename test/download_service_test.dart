import 'package:flutter_test/flutter_test.dart';
import 'package:blackhole/Services/download.dart';

import 'dart:io';

import 'package:hive/hive.dart';

void main() {
  setUpAll(() async {
    final dir = Directory.systemTemp.createTempSync('blackhole_hive_test_');
    Hive.init(dir.path);

    await Hive.openBox('settings');
    await Hive.openBox('downloads');

    final settings = Hive.box('settings');
    settings.put('downloadQuality', '320 kbps');
    settings.put('ytDownloadQuality', 'High');
    settings.put('downloadFormat', 'm4a');
    settings.put('createDownloadFolder', false);
    settings.put('createYoutubeFolder', false);
    settings.put('downloadLyrics', false);
    settings.put('downloadPath', '');
    settings.put('downFilename', 0);
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('Download instance should be created correctly', () {
    final d = Download('1');
    expect(d.id, '1');
  });

  test('Download should return same instance for same id', () {
    final a = Download('same');
    final b = Download('same');
    expect(identical(a, b), true);
  });

  test('Download progress should initialize correctly', () {
    final d = Download('p');
    expect(d.progress, isNotNull);
  });

  test('Download should allow progress update', () {
    final d = Download('p2');
    d.progress = 0.5;
    expect(d.progress, 0.5);
  });
}
