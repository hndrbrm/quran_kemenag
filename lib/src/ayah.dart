// Copyright 2022. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

class Ayah {
  const Ayah._(
    this.location,
    this.transliterate,
    this.translate,
    this.annotation,
    this.tafsirWajiz,
    this.tafsirTahlili,
  );

  factory Ayah.parse(String source) {
    assert(source.isNotEmpty);
    assert(source[0] != '#');

    final List<String> parts = source.split('\t').map((e) => e.trim()).toList();
    assert(parts.length == 6);

    return Ayah._(
      Location.parse(parts[0]),
      parts[1],
      parts[2],
      Annotation.parse(parts[3]),
      utf8.decode(base64.decode(parts[4])),
      utf8.decode(base64.decode(parts[5])),
    );
  }

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah._(
      Location.fromJson(json),
      json['teks_ayat'].trim(),
      json['teks_terjemah'].trim(),
      Annotation.fromJson(json),
      '',
      '',
    );
  }

  final Location location;
  final String transliterate;
  final String translate;
  final Annotation annotation;
  final String tafsirWajiz;
  final String tafsirTahlili;

  Ayah copyWith({
    Location? location,
    String? transliterate,
    String? translate,
    Annotation? annotation,
    String? tafsirWajiz,
    String? tafsirTahlili,
  }) {
    return Ayah._(
      location ?? this.location,
      transliterate ?? this.transliterate,
      translate ?? this.translate,
      annotation ?? this.annotation,
      tafsirWajiz ?? this.tafsirWajiz,
      tafsirTahlili ?? this.tafsirTahlili,
    );
  }

  @override
  String toString() => '$location\t$transliterate\t$translate\t$annotation\t$tafsirWajiz\t$tafsirTahlili';
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

class Annotation {
  const Annotation._(this.contents);

  factory Annotation.parse(String source) {
    return Annotation._(
      source.split('|'),
    );
  }

  factory Annotation.fromJson(Map<String, dynamic> json) {
    return Annotation._(
      json['teks_fn'].trim().split('</br>'),
    );
  }

  final List<String> contents;

  @override
  String toString() => contents.join('|');
}
