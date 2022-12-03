// Copyright 2022. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:quran_kemenag/quran_kemenag.dart';

Future<void> main() async {
  final StringBuffer contents = StringBuffer();
  contents.write('# ${DateTime.now()}\n');
  contents.write('LOCATION\tTRANSLITERATE\tTRANSLATE\n');

  final Map<String, dynamic> surahs = await Api.getSurah(0, 114);
  for (int i = 0; i < 114; i++) {
    print('Surah ${i + 1}');
    final Surah surah = Surah.parse({
      'surah': i + 1,
      ...surahs['data'][i],
    });

    final Map<String, dynamic> ayahs = await Api.getAyah(
      surah.surah, 0, 0, surah.ayahs,
    );

    for (int j = 0; j < surah.ayahs; j++) {
      final Ayah ayah = Ayah.fromJson(ayahs['data'][j]);
      contents.write('$ayah\n');
    }
    await Future.delayed(Duration(seconds: 3));
  }

  final File file = File('ayahs.tsv');
  file.writeAsStringSync(contents.toString(), flush: true);
}
