import 'dart:convert';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';
import 'package:flower_user_ui/models/order.dart';
import 'package:flower_user_ui/models/shop.dart';
import 'package:flower_user_ui/models/store.product.dart';

class WebApiServices {

  WebApiServices() {
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "https://10.0.2.2")).interceptor);
  }

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Dio dio = Dio();

  static String _storeUrl = "https://10.0.2.2:5001/stores/";
  static String _shopUrl = "https://10.0.2.2:5001/shops/";
  static String _categoryUrl = "https://10.0.2.2:5001/categories/";
  static String _storeProductUrl = "https://10.0.2.2:5001/storeproducts/";
  static String _shopProductUrl = "https://10.0.2.2:5001/shopproducts/";
  static String _orderUrl = "https://10.0.2.2:5001/orders/";
  static String _bouquetUrl = "https://10.0.2.2:5001/bouquets/";
  static String _orderStatusUrl = "https://10.0.2.2:5001/orderstatuses/";
  static String _accountUrl = "https://10.0.2.2:5001/accounts/";

  static Future fetchStore() async {
    return await Dio().get(
      _storeUrl,
      options: buildCacheOptions(Duration(minutes: 2)),
    );
  }

  static Future<Response<String>> fetchShop() async {
    return await Dio().get<String>(
      _shopUrl,
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

  static Future<Response<String>> fetchBouquets() async {
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
    return await dio.get(_storeProductUrl);
  }

  static Future fetchShopProduct() async {
    return await dio.get(_shopProductUrl);
  }

  // static Future postShop(Shop shop) async {
  //   var reverseShop = shop.toJson();
  //   var shopJson = json.encode(reverseShop);
  //   var response = await dio.post(_shopUrl, options: Options(headers: header), data: shopJson);
  //   return response.statusCode;
  // }

  static Future postStoreProduct(StoreProduct storeProduct) async {
    var reverseStoreProduct = storeProduct.toMap();
    var storeProductJson = json.encode(reverseStoreProduct);
    var response = await dio.post(_storeProductUrl, options: Options(headers: header), data: storeProductJson);
    print("0000000000000000000000000000000000000000000000000");
    print(response.statusCode);
    return response.statusCode;
  }

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
