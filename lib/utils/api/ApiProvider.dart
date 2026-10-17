import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cattle/utils/PinConfig.dart';
import 'package:cattle/utils/api/CustomException.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static const String API_URL = "${PinConfig.IP}:${PinConfig.PORT}";

  /// Fail fast when [PinConfig] host is unreachable so splash can route to login.
  static const Duration requestTimeout = Duration(seconds: 5);

  static final ApiProvider _instance = ApiProvider._internal();
  String token = "";

  factory ApiProvider() {
    return _instance;
  }

  ApiProvider._internal();

  Future<void> init() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    String? t = await storage.read(key: "token");
    token = "Bearer $t";
  }

  Future<void> setToken(String t) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: "token", value: t);
    token = "Bearer $t";
  }

  emptyToken() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: "token", value: "");
    token = "";
  }

  Map<String, String> get _headers => <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token
      };

  Future<T> _guarded<T>(Future<T> Function() run) async {
    try {
      return await run().timeout(requestTimeout);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> get(dynamic url, [params]) async {
    Uri uri;
    if (params != null) {
      uri = Uri(
        scheme: 'http',
        host: PinConfig.IP,
        port: PinConfig.PORT,
        path: url,
        queryParameters: params,
      );
    } else {
      uri = Uri.http(API_URL, url);
    }

    final response = await _guarded(
      () => http.get(uri, headers: _headers),
    );
    return _response(response);
  }

  Future<dynamic> post(String url, body) async {
    var uri = Uri.http(API_URL, url);
    print(uri);
    final response = await _guarded(
      () => http.post(uri, body: body, headers: _headers),
    );
    return _response(response);
  }

  Future<dynamic> put(String url, body) async {
    var uri = Uri.http(API_URL, url);
    final response = await _guarded(
      () => http.put(uri, body: body, headers: _headers),
    );
    return _response(response);
  }

  Future<dynamic> delete(String url) async {
    var uri = Uri.http(API_URL, url);
    final response = await _guarded(
      () => http.delete(uri, headers: _headers),
    );
    return _response(response);
  }



  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
      
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        return json.decode(response.body.toString());
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}