import 'dart:convert';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';
import 'package:flower_user_ui/data/models/api_modes.dart';

class BouquetApiService {

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
  //Этот код выше наверное лучше вынести или держать в ApiService

  static const String _bouquetUrl = "$_baseUrl/bouquets/";

  static Future fetchBouquets() async {
    return Dio().get<String>(
      _bouquetUrl,
      options: buildCacheOptions(shortDuration),
    );
  }

  static Future postBouquet(Bouquet bouquet) async {
    final reverseBouquet = bouquet.toJson();
    final bouquetJson = json.encode(reverseBouquet);
    final response = await dio.post(_bouquetUrl,
        options: Options(headers: header), data: bouquetJson);
    return response.statusCode;
  }

  static Future putBouquet(Bouquet bouquet) async {
    final reverseBouquet = bouquet.toJsonUpdate();
    final bouquetJson = json.encode(reverseBouquet);
    final response = await dio.put(_bouquetUrl + bouquet.id.toString(),
        queryParameters: header, data: bouquetJson);
    return response.statusCode;
  }

  static Future deleteBouquet(int? id) async {
    final response = await dio.delete(_bouquetUrl + id.toString());
    return response.statusCode;
  }
}