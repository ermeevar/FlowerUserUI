import 'dart:convert';
import 'dart:io';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';
import 'package:flower_user_ui/models/store.dart';
import 'package:flower_user_ui/models/template.dart';
import 'package:flower_user_ui/models/user.dart';
import 'account.dart';
import 'bouquet.dart';
import 'bouquet.product.dart';
import 'order.dart';

class WebApiServices {
  static Dio dio = Dio();

  static String _androidEmulatorLoopback = "10.0.2.2";
  static String _localhost = "localhost";
  static String _port = "5001";
  static String _baseUrl = "https://$_androidEmulatorLoopback:$_port";

  static String _storeUrl = _baseUrl + "/stores/";
  static String _shopUrl = _baseUrl + "/shops/";
  static String _productUrl = _baseUrl + "/products/";
  static String _orderUrl = _baseUrl + "/orders/";
  static String _bouquetUrl = _baseUrl + "/bouquets/";
  static String _bouquetProductUrl = _baseUrl + "/bouquetproducts/";
  static String _orderStatusUrl = _baseUrl + "/orderstatuses/";
  static String _accountUrl = _baseUrl + "/accounts/";
  static String _templateUrl = _baseUrl + "/templates/";
  static String _templateCategoryUrl = _baseUrl + "/templatecategories/";
  static String _userUrl = _baseUrl + "/users/";

  WebApiServices() {
    dio.interceptors.add(
        DioCacheManager(CacheConfig(baseUrl: "https://10.0.2.2")).interceptor);
  }

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future fetchShop() async {
    return await Dio().get<String>(
      _shopUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future fetchStore() async {
    return await Dio().get<String>(
      _storeUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future fetchAccount() async {
    return await Dio().get<String>(
      _accountUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future fetchOrders() async {
    return await Dio().get<String>(
      _orderUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchBouquet() async {
    return await Dio().get<String>(
      _bouquetUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchOrderStatuses() async {
    return await Dio().get<String>(
      _orderStatusUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchProduct() async {
    return await Dio().get<String>(
      _productUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchUser() async {
    return await Dio().get<String>(
      _userUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchBouquetProduct() async {
    return await Dio().get<String>(
      _bouquetProductUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchTemplate() async {
    return await Dio().get<String>(
      _templateUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchTemplateCategory() async {
    return await Dio().get<String>(
      _templateCategoryUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future postBouquet(Bouquet bouquet) async {
    var reverseBouquet = bouquet.toJson();
    var bouquetJson = json.encode(reverseBouquet);
    var response = await dio.post(_bouquetUrl,
        options: Options(headers: {
    HttpHeaders.contentTypeHeader: "application/json"}), data: bouquetJson);
    return response.statusCode;
  }

  static Future postBouquetProduct(BouquetProduct bouquetProduct) async {
    var reverseBouquetProduct = bouquetProduct.toJson();
    var bouquetProductJson = json.encode(reverseBouquetProduct);
    var response = await dio.post(_bouquetProductUrl,
        options: Options(headers: header), data: bouquetProductJson);
    return response.statusCode;
  }

  static Future postOrder(Order order) async {
    var reverseOrder = order.toJson();
    var orderJson = json.encode(reverseOrder);
    var response = await dio.post(_orderUrl,
        options: Options(headers: header), data: orderJson);
    return response.statusCode;
  }


  static Future postAccount(Account account) async {
    var reverseAccount = account.toJson();
    var accountJson = json.encode(reverseAccount);
    var response = await dio.post(_accountUrl,
        options: Options(headers: header), data: accountJson);
    return response.statusCode;
  }

  static Future postUser(User user) async {
    var reverseUser = user.toJson();
    var userJson = json.encode(reverseUser);
    var response = await dio.post(_userUrl,
        options: Options(headers: header), data: userJson);
    return response.statusCode;
  }

  static Future deleteStoreProduct(int id) async {
    var response = await dio.delete(_productUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteAccount(int id) async {
    var response = await dio.delete(_accountUrl + id.toString());
    return response.statusCode;
  }
}
