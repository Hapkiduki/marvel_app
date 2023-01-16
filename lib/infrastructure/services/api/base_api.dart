import 'dart:convert';

import 'package:http/http.dart' as http;

mixin BaseApi {
  String? get baseUrl;
  http.Client get client;
  Map<String, String> getHeaders(Map<String, String> headers);
  Map<String, String> getParams(Map<String, String> params);

  Duration get timeOut => const Duration(seconds: 30);

  Future<T> callApi<T>(
      Future<http.Response> caller, T Function(dynamic value) mapperFunction,
      {Function? callBack}) async {
    try {
      var response = await caller;

      if (callBack != null) {
        await callBack(response.statusCode);
      }

      return await manageResponse(response, mapperFunction);
    } catch (e) {
      rethrow;
    }
  }

  Future<T> getApi<T>(
    String url,
    T Function(dynamic value) mapperFunction, {
    Map<String, String>? headers,
    Map<String, String>? params,
    String basicAuth = '',
  }) async {
    params = getParams(params ?? {});
    final stringParams = Uri(queryParameters: params).query;

    headers = getHeaders(headers ?? {});
    if (basicAuth.isNotEmpty) headers.addAll({'authorization': basicAuth});

    final caller = client
        .get(
          Uri.parse(
              '$baseUrl$url${stringParams.isNotEmpty ? '?$stringParams' : ''}'),
          headers: headers,
        )
        .timeout(timeOut);

    return callApi(caller, mapperFunction);
  }

  dynamic getBody(dynamic body) {
    late final String bodyString;
    if (body is String) {
      bodyString = body;
    } else {
      bodyString = utf8.decode(body);
    }
    try {
      return json.decode(bodyString);
    } catch (_) {
      return bodyString;
    }
  }

  Future<T> manageResponse<T>(
      http.Response response, T Function(dynamic value) mapperFunction) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return mapperFunction(getBody(response.bodyBytes));
    } else {
      throw Exception('Pailas papi');
    }
  }
}
