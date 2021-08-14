
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class OrderStatusUrl{

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

  static const String _orderStatusUrl = "$_baseUrl/orderstatuses/";
  
  static Future fetchOrderStatuses() async {
    return Dio().get<String>(
      _orderStatusUrl,
      options: buildCacheOptions(shortDuration),
    );
  }
}