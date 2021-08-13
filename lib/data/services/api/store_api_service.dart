

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flower_user_ui/data/models/store.dart';

class StoreApiService{

  static Dio dio = Dio();

  //#region Server
  static const String _androidEmulatorLoopback = "185.246.67.169";
  static const String _port = "5004";
  static const String _baseUrl = "http://$_androidEmulatorLoopback:$_port";


  static const Duration longDuration = Duration(days: 7);
  static const Duration shortDuration = Duration(days: 1);

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };


  static const String _storeUrl = "$_baseUrl/stores/";

  static Future fetchStores() async {
    return Dio().get<String>(
      _storeUrl,
      options: buildCacheOptions(longDuration),
    );
  }

  static Future postStore(Store store) async {
    final reverseStore = store.toJson();
    final storeJson = json.encode(reverseStore);
    final response = await dio.post(_storeUrl,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: storeJson);
    return response.statusCode;
  }

  static Future putStore(Store store) async {
    final reverseStore = store.toJsonUpdate();
    final storeJson = json.encode(reverseStore);
    final response = await dio.put(_storeUrl + store.id.toString(),
        queryParameters: header, data: storeJson);
    return response.statusCode;
  }

  static Future deleteStore(int id) async {
    final response = await dio.delete(_storeUrl + id.toString());
    return response.statusCode;
  }
}