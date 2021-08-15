
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class TemplateUrl{

  static Dio dio = Dio();

  static const String _androidEmulatorLoopback = "185.246.67.169";
  static const String _port = "5004";
  static const String _baseUrl = "http://$_androidEmulatorLoopback:$_port";



  static const Duration longDuration = Duration(days: 7);
  static const Duration shortDuration = Duration(days: 1);

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static const String _templateUrl = "$_baseUrl/templates/";
  
  static Future fetchTemplates() async {
    return Dio().get<String>(
      _templateUrl,
      options: buildCacheOptions(shortDuration),
    );
  }

}