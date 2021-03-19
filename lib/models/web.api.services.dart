import 'dart:convert';
import 'dart:io';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';
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
  static String _categoryUrl = _baseUrl + "/productcategories/";
  static String _storeProductUrl = _baseUrl + "/products/";
  static String _orderUrl = _baseUrl + "/orders/";
  static String _bouquetUrl = _baseUrl + "/bouquets/";
  static String _bouquetproductUrl = _baseUrl + "/bouquetproducts/";
  static String _orderStatusUrl = _baseUrl + "/orderstatuses/";
  static String _accountUrl = _baseUrl + "/accounts/";

  WebApiServices() {
    dio.interceptors.add(
        DioCacheManager(CacheConfig(baseUrl: "https://10.0.2.2")).interceptor);
  }

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<Response<String>> fetchShop() async {
    return await Dio().get<String>(
      _shopUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future<Response<String>> fetchStore() async {
    return await Dio().get<String>(
      _storeUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future<Response<String>> fetchAccount() async {
    return await Dio().get<String>(
      _accountUrl,
      options: buildCacheOptions(Duration(days: 7)),
    );
  }

  static Future<Response<String>> fetchOrders() async {
    return await Dio().get<String>(
      _orderUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future<Response<String>> fetchBouquet() async {
    return await Dio().get<String>(
      _bouquetUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future<Response<String>> fetchOrderStatuses() async {
    return await Dio().get<String>(
      _orderStatusUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future fetchCategory() async {
    return await dio.get(_categoryUrl);
  }

  static Future fetchStoreProduct() async {
    return await Dio().get<String>(
      _storeProductUrl,
      options: buildCacheOptions(Duration(days: 1)),
    );
  }

  static Future postBouquet(Bouquet bouquet) async {
    var reverseBouquet = bouquet.toJson();
    var bouquetJson = json.encode(reverseBouquet);
    print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
    print(bouquetJson);
    var response = await dio.post(_bouquetUrl,
        options: Options(headers: {
    HttpHeaders.contentTypeHeader: "application/json"}), data: bouquetJson);
    return response.statusCode;
  }

  static Future postBouquetProduct(BouquetProduct bouquetProduct) async {
    var reverseBouquetProduct = bouquetProduct.toJson();
    var bouquetProductJson = json.encode(reverseBouquetProduct);
    var response = await dio.post(_bouquetproductUrl,
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


  // static Future postShop(Shop shop) async {
  //   var reverseShop = shop.toJson();
  //   var shopJson = json.encode(reverseShop);
  //   var response = await dio.post(_shopUrl, options: Options(headers: header), data: shopJson);
  //   return response.statusCode;
  // }

  // static Future postStoreProduct(StoreProduct storeProduct) async {
  //   var reverseStoreProduct = storeProduct.toMap();
  //   var storeProductJson = json.encode(reverseStoreProduct);
  //   var response = await dio.post(_storeProductUrl, options: Options(headers: header), data: storeProductJson);
  //   print("0000000000000000000000000000000000000000000000000");
  //   print(response.statusCode);
  //   return response.statusCode;
  // }

  // static Future putShop(Shop shop) async {
  //   var reverseShop = shop.toJson();
  //   var shopJson = json.encode(reverseShop);
  //   var response = await dio.post(_shopUrl + shop.id.toString(),
  //       options: Options(headers: header), data: shopJson);
  //   print(response.statusCode);
  //   return response.statusCode;
  // }

  static Future deleteShop(int id) async {
    var response = await dio.delete(_shopUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteStoreProduct(int id) async {
    var response = await dio.delete(_storeProductUrl + id.toString());
    return response.statusCode;
  }
}
