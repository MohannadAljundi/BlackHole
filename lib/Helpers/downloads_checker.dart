/*
 *  This file is part of BlackHole (https://github.com/Sangwan5688/BlackHole).
 * 
 * BlackHole is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * BlackHole is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with BlackHole.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2021-2023, Ankit Sangwan
 */

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> downloadChecker() async {
  if (kIsWeb) return;

  final box = Hive.box('downloads');

  final List<Map<String, String>> songs = box.values
      .whereType<Map>()
      .map((dynamic e) => <String, String>{
            'id': (e['id'] ?? '').toString(),
            'path': (e['path'] ?? '').toString(),
          })
      .toList(growable: false);

  if (songs.isEmpty) return;

  final List<String> keysToDelete = await compute(_checkPathsSync, songs);

  if (keysToDelete.isNotEmpty) {
    await box.deleteAll(keysToDelete);
  }
}

List<String> _checkPathsSync(List<Map<String, String>> songs) {
  final List<String> res = [];
  for (final song in songs) {
    final String id = song['id'] ?? '';
    final String path = song['path'] ?? '';
    if (id.isEmpty || path.isEmpty) {
      if (id.isNotEmpty) res.add(id);
      continue;
    }
    try {
      final exists = File(path).existsSync();
      if (!exists) res.add(id);
    } catch (_) {
      res.add(id);
    }
  }
  return res;
}
