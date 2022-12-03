// Copyright 2022. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:quran_transliteration/quran_transliteration.dart';

class Surah {
  const Surah._(
    this.surah,
    this.latin,
    this.transliterate,
    this.translate,
    this.type,
    this.ayahs,
  ) : assert(1 <= surah && surah <= 114),
      assert(ayahs > 0);

  final int surah;
  final String latin;
  final String transliterate;
  final String translate;
  final String type;
  final int ayahs;

  factory Surah.parse(Map<String, dynamic> json) {
    final Transliteration transliteration = ExtendedBuckwalterTransliteration();
    return Surah._(
      json['surah'],
      json['surat_name'].trim(),
      transliteration.backward(json['surat_text'].trim()),
      json['surat_terjemahan'].trim(),
      transliteration.backward(json['golongan_surah'].trim()),
      json['count_ayat'],
    );
  }

  @override
  String toString() {
    return '$surah\t$latin\t$transliterate\t$translate\t$type\t$ayahs';
  }
}
