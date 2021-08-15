import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flower_user_ui/data/models/product.dart';

// ignore: avoid_classes_with_only_static_members
class ProductApiService{

   static Dio dio = Dio();

  //#region Server
  static const String _androidEmulatorLoopback = "185.246.67.169";
  static const String _port = "5004";
  static const String _baseUrl = "http://$_androidEmulatorLoopback:$_port";


  static const String _productUrl = "$_baseUrl/products/";


  static const Duration longDuration = Duration(days: 7);
  static const Duration shortDuration = Duration(days: 1);

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };


  static Future fetchProducts() async {
    return Dio().get<String>(
      _productUrl,
      options: buildCacheOptions(shortDuration),
    );
  }

  static Future postProduct(Product product) async {
    final reverseProduct = product.toJson();
    final productJson = json.encode(reverseProduct);
    final response = await dio.post(_productUrl,
        options: Options(headers: header), data: productJson);
    return response.statusCode;
  }
  static Future putProduct(Product product) async {
    final reverseProduct = product.toJsonUpdate();
    final productJson = json.encode(reverseProduct);
    final response = await dio.put(_productUrl + product.id.toString(),
        queryParameters: header, data: productJson);
    return response.statusCode;
  }

  static Future deleteProduct(int id) async {
    final response = await dio.delete(_productUrl + id.toString());
    return response.statusCode;
  }

}