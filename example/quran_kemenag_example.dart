// Copyright 2022. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:quran_kemenag/quran_kemenag.dart';

Future<void> main(List<String> arguments) async {
  final Map<String, dynamic> suras = await Api.getSurah(0, 1);
  print(suras);
  final Map<String, dynamic> ayahs = await Api.getAyah(1, 0, 0, 7);
  print(ayahs);
  final Map<String, dynamic> tafsirs = await Api.getTafsir(1);
  print(tafsirs);
}
