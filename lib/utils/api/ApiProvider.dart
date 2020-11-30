import 'dart:io';

import 'package:cattle/utils/PinConfig.dart';
import 'package:cattle/utils/api/CustomException.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiProvider{
  static const String API_URL = "${PinConfig.IP}:${PinConfig.PORT}";

  static final ApiProvider _instance=ApiProvider._internal();
  String token;

  factory ApiProvider(){
    return _instance;
  }

  ApiProvider._internal();

  Future<void> init()async{
    FlutterSecureStorage storage = FlutterSecureStorage();
    String t=await storage.read(key: "token");
    if(t!=null){
      token="Bearer "+t;
    }else{
      token="";
    }
    
  }

  Future<void> setToken(String t)async{
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: "token",value: t);
    token="Bearer "+t;
  }

  emptyToken() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: "token",value: "");
    token="";
  }


  Future<dynamic> get(dynamic url,[params]) async {
    var uri;
    if(params!=null){
        uri = Uri(
          scheme: 'http',
          host: PinConfig.IP,
          port: PinConfig.PORT,
          path: url,
          queryParameters: params,
        );
    }else{
      uri=Uri.http(API_URL,url);
    }


    var responseJson;
    try {
      final response = await http.get(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization":token
        },
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  

  Future<dynamic> post(String url,body) async {
    var responseJson;
    var uri=Uri.http(API_URL,url);
    print(uri);
    try {
      final response = await http.post(uri,
        body:body,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization":token
        },
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url,body) async {
    var responseJson;
    var uri=Uri.http(API_URL,url);
    try {
      final response = await http.put(uri,
        body:body,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization":token
        },
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var responseJson;
    var uri=Uri.http(API_URL,url);
    try {
      final response = await http.delete(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization":token
        },
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
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