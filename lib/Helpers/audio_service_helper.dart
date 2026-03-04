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

import 'package:audio_service/audio_service.dart';
import 'package:blackhole/CustomWidgets/gradient_containers.dart';
import 'package:blackhole/CustomWidgets/popup.dart';
import 'package:blackhole/Helpers/mediaitem_converter.dart';
import 'package:flutter/material.dart';

void showSongInfo(MediaItem mediaItem, BuildContext context) {
  final Map<String, dynamic> details =
      Map<String, dynamic>.from(MediaItemConverter.mediaItemToMap(mediaItem));
  final int durationSeconds =
      int.tryParse(details['duration']?.toString() ?? '') ?? 0;
  final int mins = durationSeconds ~/ 60;
  final int secs = durationSeconds % 60;
  details['duration'] =
      '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  // style: Theme.of(context).textTheme.caption,
  final extras = mediaItem.extras;

  if (extras != null) {
    final int sizeBytes = int.tryParse(extras['size']?.toString() ?? '') ?? 0;
    if (sizeBytes > 0) {
      details['size'] = '${(sizeBytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }

    final int modifiedSeconds =
        int.tryParse(extras['date_modified']?.toString() ?? '') ?? 0;
    if (modifiedSeconds > 0) {
      details['date_modified'] = DateTime.fromMillisecondsSinceEpoch(
        modifiedSeconds * 1000,
      ).toString().split('.').first;
    }
  }
  PopupDialog().showPopup(
    context: context,
    child: GradientCard(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: details.keys.map((e) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: SelectableText.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          '${e[0].toUpperCase()}${e.substring(1)}\n'.replaceAll(
                        '_',
                        ' ',
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Theme.of(
                          context,
                        ).textTheme.bodySmall!.color,
                      ),
                    ),
                    TextSpan(
                      text: details[e].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                showCursor: true,
                cursorColor: Theme.of(context).colorScheme.onSurface,
                cursorRadius: const Radius.circular(
                  5,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ),
  );
}
