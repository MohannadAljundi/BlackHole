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

import 'package:logging/logging.dart';

bool compareVersion(String currentVersion, String latestVersion) {
  List<int> parse(String v) {
    final cleaned = v.trim().replaceAll(RegExp(r'[^0-9.]'), '');
    final parts = cleaned.split('.').where((e) => e.isNotEmpty).toList();

    while (parts.length < 3) {
      parts.add('0');
    }

    return parts.take(3).map((e) => int.tryParse(e) ?? 0).toList();
  }

  final c = parse(currentVersion);
  final l = parse(latestVersion);

  for (int i = 0; i < 3; i++) {
    if (l[i] > c[i]) return true;
    if (l[i] < c[i]) return false;
  }
  return false;
}
