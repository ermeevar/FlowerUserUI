
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flower_user_ui/data/models/bouquet_product.dart';

class BouquetProductUrlService{
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

  static const String _bouquetProductUrl = "$_baseUrl/bouquetproducts/";

  static Future fetchBouquetProducts() async {
    return Dio().get<String>(
      _bouquetProductUrl,
      options: buildCacheOptions(shortDuration),
    );
  }

  static Future postBouquetProduct(BouquetProduct bouquetProduct) async {
    final reverseBouquetProduct = bouquetProduct.toJson();
    final bouquetProductJson = json.encode(reverseBouquetProduct);
    final response = await dio.post(_bouquetProductUrl,
        options: Options(headers: header), data: bouquetProductJson);
    return response.statusCode;
  }

  static Future putBouquetProduct(BouquetProduct bouquetProduct) async {
    final reverseBouquetProduct = bouquetProduct.toJsonUpdate();
    final bouquetProductJson = json.encode(reverseBouquetProduct);
    final response = await dio.put(
        _bouquetProductUrl + bouquetProduct.id.toString(),
        queryParameters: header,
        data: bouquetProductJson);
    return response.statusCode;
  }

  static Future deleteBouquetProduct(int id) async {
    final response = await dio.delete(_bouquetProductUrl + id.toString());
    return response.statusCode;
  }

}