

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flower_user_ui/data/models/shop.dart';

class ShopApiService {

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

  static const String _shopUrl = "$_baseUrl/shops/";

  static Future fetchShops() async {
    return Dio().get<String>(
      _shopUrl,
      options: buildCacheOptions(longDuration),
    );
  }

  static Future postShop(Shop shop) async {
    final reverseShop = shop.toJson();
    final shopJson = json.encode(reverseShop);
    final response = await dio.post(_shopUrl,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: shopJson);
    return response.statusCode;
  }

  static Future putShop(Shop shop) async {
    final reverseShop = shop.toJsonUpdate();
    final shopJson = json.encode(reverseShop);
    final response = await dio.put(_shopUrl + shop.id.toString(),
        queryParameters: header, data: shopJson);
    return response.statusCode;
  }

  static Future deleteShop(int id) async {
    final response = await dio.delete(_shopUrl + id.toString());
    return response.statusCode;
  }
}