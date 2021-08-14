
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flower_user_ui/data/models/api_modes.dart';

class AccountUrl{

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


  static const String _accountUrl = "$_baseUrl/accounts/";

  static Future fetchAccounts() async {
    return Dio().get<String>(
      _accountUrl,
      options: buildCacheOptions(longDuration),
    );
  }

  static Future postAccount(Account account) async {
    final reverseAccount = account.toJson();
    final accountJson = json.encode(reverseAccount);
    final response = await dio.post(_accountUrl,
        options: Options(headers: header), data: accountJson);
    return response.statusCode;
  }

  static Future putAccount(Account account) async {
    final reverseAccount = account.toJsonUpdate();
    final accountJson = json.encode(reverseAccount);
    final response = await dio.put(_accountUrl + account.id.toString(),
        queryParameters: header, data: accountJson);
    return response.statusCode;
  }

  static Future deleteAccount(int? id) async {
    final response = await dio.delete(_accountUrl + id.toString());
    return response.statusCode;
  }


}