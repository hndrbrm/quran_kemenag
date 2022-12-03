// Copyright 2022. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'package:quran_transliteration/quran_transliteration.dart';

class Ayah {
  const Ayah._(
    this.location,
    this.transliterate,
    this.translate,
  );

  factory Ayah.parse(String source) {
    assert(source.isNotEmpty);
    assert(source[0] != '#');

    final List<String> parts = source.split('\t').map((e) => e.trim()).toList();
    assert(parts.length == 3);

    return Ayah._(
      Location.parse(parts[0]),
      parts[1],
      parts[2],
    );
  }

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah._(
      Location.fromJson(json),
      json['teks_ayat'].trim(),
      json['teks_terjemah'].trim(),
    );
  }

  final Location location;
  final String transliterate;
  final String translate;

  @override
  String toString() => '$location\t$transliterate\t$translate';
}

class Location {
  const Location._(this.surah, this.ayah)
    : assert(1 <= surah && surah <= 114),
      assert(ayah > 0);

  factory Location.parse(String source) {
    final int start = source.indexOf('(');
    final int end = source.indexOf(')', start);

    assert(start >= 0 && end > start);

    final String location = source.substring(start + 1, end);
    final List<int> parts = location.split(':').map((e) => int.parse(e)).toList();
    return Location._(parts[0], parts[1]);
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location._(
      json['no_surah'],
      json['no_ayat'],
    );
  }

  final int surah;
  final int ayah;

  @override
  String toString() => '($surah:$ayah)';
}
