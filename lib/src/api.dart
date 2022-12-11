// Copyright 2022. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Api {
  const Api._();

  static const String _url = 'https://quran.kemenag.go.id/api/v1';

  /// Get surah information.
  ///
  /// Argument [sura] is the surah index.
  /// The value is between 0 to 113.
  ///
  /// Argument [paging] is the number of surah which will be retrieved.
  /// The value is between 1 to 114.
  static Future<Map<String, dynamic>> getSurah(int surah, int paging) async {
    assert(0 <= surah && surah <= 113);
    assert(1 <= paging && paging <= (114 - surah)) ;

    final String url = '$_url/surah/$surah/$paging';

    final Uri uri = Uri.parse(url);
    final http.Response response = await http.get(uri);
    final Map<String, dynamic> json = jsonDecode(response.body);

    return json;
  }

  /// Get detail information on a certain ayah.
  ///
  /// Argument [surah] is the surah index.
  /// The value is between 1 to 114.
  ///
  /// Argument [singleAyah] is the ayah index.
  /// If the value >0 the api will result only that certain ayah,
  /// argument [ayah] and [paging] will be ignored.
  ///
  /// Argument [ayah] is the starting ayah index which will be retrieved.
  /// The value start from 0.
  ///
  /// Argument [paging] is the number of ayah which will be retrieved.
  /// The value start from 1.
  static Future<Map<String, dynamic>> getAyah(
    int surah,
    int singleAyah,
    int ayah,
    int paging,
  ) async {
    assert(1 <= surah && surah <= 114);
    assert(0 <= singleAyah);
    assert(0 <= ayah);
    assert(1 <= paging);

    final String url = '$_url/ayatweb/$surah/$singleAyah/$ayah/$paging';

    final Uri uri = Uri.parse(url);
    final HttpClient client = HttpClient();
    final HttpClientRequest request = await client.getUrl(uri);
    final HttpClientResponse response = await request.close();
    final String content = await response.transform(utf8.decoder).join();
    final Map<String, dynamic> json = jsonDecode(content);

    return json;
  }

  /// Get detail information on a certain ayah.
  ///
  /// Argument [ayah] is the starting ayah index which will be retrieved.
  /// The value start from 1.
  static Future<Map<String, dynamic>> getTafsir(int ayah) async {
    assert(1 <= ayah);

    final String url = '$_url/tafsirbyayat/$ayah';

    final Uri uri = Uri.parse(url);
    final HttpClient client = HttpClient();
    final HttpClientRequest request = await client.getUrl(uri);
    final HttpClientResponse response = await request.close();
    final String content = await response.transform(utf8.decoder).join();
    final Map<String, dynamic> json = jsonDecode(content);

    return json;
  }
}
