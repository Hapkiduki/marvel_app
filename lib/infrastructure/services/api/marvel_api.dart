import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_app/infrastructure/services/api/base_api.dart';

import 'package:http/http.dart' as http;

class MarvelApi with BaseApi {
  String? _baseUrl;

  MarvelApi() {
    _baseUrl = dotenv.env['BASE_URL'];
  }

  @override
  String? get baseUrl => _baseUrl;

  @override
  http.Client get client => http.Client();

  @override
  Map<String, String> getHeaders(Map<String, String> headers) {
    return {
      'Content-Type': 'application/json',
    };
  }

  @override
  Map<String, String> getParams(Map<String, String> params) {
    final apiKey = dotenv.env['API_KEY'];
    final privateKey = dotenv.env['PRIVATE_API_KEY'];
    final ts = DateTime.now().millisecondsSinceEpoch;

    final bytes = utf8.encode('$ts$privateKey$apiKey');
    final hash = md5.convert(bytes).toString();

    return {
      'apikey': apiKey!,
      'ts': ts.toString(),
      'hash': hash,
    };
  }
}
