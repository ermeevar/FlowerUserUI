
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flower_user_ui/data/models/api_modes.dart';

class UserUrl{

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

  static const String _userUrl = "$_baseUrl/users/";

  static Future fetchUsers() async {
    return Dio().get<String>(
      _userUrl,
      options: buildCacheOptions(shortDuration),
    );
  }

  static Future postUser(User user) async {
    final reverseUser = user.toJson();
    final userJson = json.encode(reverseUser);
    final response = await dio.post(_userUrl,
        options: Options(headers: header), data: userJson);
    return response.statusCode;
  }

  static Future putUser(User user) async {
    final reverseUser = user.toJsonUpdate();
    final userJson = json.encode(reverseUser);
    final response = await dio.put(_userUrl + user.id.toString(),
        queryParameters: header, data: userJson);
    return response.statusCode;
  }

  static Future deleteUser(int id) async {
    final response = await dio.delete(_userUrl + id.toString());
    return response.statusCode;
  }
}