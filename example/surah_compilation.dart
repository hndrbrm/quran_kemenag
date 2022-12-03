// Copyright 2022. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:quran_kemenag/quran_kemenag.dart';

Future<void> main() async {
  final StringBuffer contents = StringBuffer();
  contents.write('# ${DateTime.now()}\n');
  contents.write('SURAH\tLATIN\tTRANSLITERATE\tTRANSLATE\tTYPE\tAYAHS\n');

  final Map<String, dynamic> surahs = await Api.getSurah(0, 114);
  for (int i = 0; i < 114; i++) {
    final Surah surah = Surah.parse({
      'surah': i + 1,
      ...surahs['data'][i],
    });
    contents.write('$surah\n');
  }

  final File file = File('surahs.tsv');
  file.writeAsStringSync(contents.toString(), flush: true);
}
