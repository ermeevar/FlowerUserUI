
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flower_user_ui/data/models/order.dart';

class OrderApiService{

  static Dio dio = Dio();

  //#region Server
  static const String _androidEmulatorLoopback = "185.246.67.169";
  static const String _port = "5004";
  static const String _baseUrl = "http://$_androidEmulatorLoopback:$_port";


  static const String _orderUrl = "$_baseUrl/orders/";


  static const Duration longDuration = Duration(days: 7);
  static const Duration shortDuration = Duration(days: 1);

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future fetchOrders() async {
    return Dio().get<String>(
      _orderUrl,
      options: buildCacheOptions(shortDuration),
    );
  }
  
  static Future postOrder(Order order) async {
    final reverseOrder = order.toJson();
    final orderJson = json.encode(reverseOrder);
    final response = await dio.post(_orderUrl,
        options: Options(headers: header), data: orderJson);
    return response.statusCode;
  }

  static Future putOrder(Order order) async {
    final reverseOrder = order.toJsonUpdate();
    final orderJson = json.encode(reverseOrder);
    final response = await dio.put(_orderUrl + order.id.toString(),
        queryParameters: header, data: orderJson);
    return response.statusCode;
  }

  static Future deleteOrder(int id) async {
    final response = await dio.delete(_orderUrl + id.toString());
    return response.statusCode;
  }
}