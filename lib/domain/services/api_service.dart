import 'dart:convert';
import 'dart:io';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio/dio.dart';
import 'package:flower_user_ui/data/models/api_modes.dart';

// TODO: Тут весь класс нужно разбить на мелкие контроллеры с общим кодом, сделать нормальную поддержку тестовых сред и смены ip, таймаут
class ApiService {
  static Dio dio = Dio();

  //#region Server
  static const String _androidEmulatorLoopback = "185.246.67.169";
  static const String _port = "5004";
  static const String _baseUrl = "http://$_androidEmulatorLoopback:$_port";
  //#endregion

  //#region URL's
  static const String _storeUrl = "$_baseUrl/stores/";
  static const String _shopUrl = "$_baseUrl/shops/";
  static const String _productUrl = "$_baseUrl/products/";
  static const String _orderUrl = "$_baseUrl/orders/";
  static const String _bouquetUrl = "$_baseUrl/bouquets/";
  static const String _bouquetProductUrl = "$_baseUrl/bouquetproducts/";
  static const String _orderStatusUrl = "$_baseUrl/orderstatuses/";
  static const String _accountUrl = "$_baseUrl/accounts/";
  static const String _templateUrl = "$_baseUrl/templates/";
  static const String _templateCategoryUrl = "$_baseUrl/templatecategories/";
  static const String _productCategoryUrl = "$_baseUrl/productcategories/";
  static const String _userUrl = "$_baseUrl/users/";
  //#endregion

  static const Duration longDuration = Duration(days: 7);
  static const Duration shortDuration = Duration(days: 1);

  ApiService() {
    dio.interceptors.add(
        DioCacheManager(CacheConfig(baseUrl: _androidEmulatorLoopback))
            .interceptor as Interceptor);
  }

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  //#region GET response strings
  static Future fetchShops() async {
    return Dio().get<String>(
      _shopUrl,
      options: buildCacheOptions(longDuration),
    );
  }

  static Future fetchStores() async {
    return Dio().get<String>(
      _storeUrl,
      options: buildCacheOptions(longDuration),
    );
  }

  static Future fetchProductCategories() async {
    return Dio().get<String>(
      _productCategoryUrl,
      options: buildCacheOptions(longDuration),
    );
  }

  static Future fetchAccounts() async {
    return Dio().get<String>(
      _accountUrl,
      options: buildCacheOptions(longDuration),
    );
  }

  static Future fetchOrders() async {
    return Dio().get<String>(
      _orderUrl,
      options: buildCacheOptions(shortDuration),
    );
  }

  static Future fetchBouquets() async {
    return Dio().get<String>(
      _bouquetUrl,
      options: buildCacheOptions(shortDuration),
    );
  }

  static Future fetchOrderStatuses() async {
    return Dio().get<String>(
      _orderStatusUrl,
      options: buildCacheOptions(shortDuration),
    );
  }

  static Future fetchProducts() async {
    return Dio().get<String>(
      _productUrl,
      options: buildCacheOptions(shortDuration),
    );
  }

  static Future fetchBouquetProducts() async {
    return Dio().get<String>(
      _bouquetProductUrl,
      options: buildCacheOptions(shortDuration),
    );
  }

  static Future fetchTemplates() async {
    return Dio().get<String>(
      _templateUrl,
      options: buildCacheOptions(shortDuration),
    );
  }

  static Future fetchTemplateCategories() async {
    return Dio().get<String>(
      _templateCategoryUrl,
      options: buildCacheOptions(shortDuration),
    );
  }

  static Future fetchUsers() async {
    return Dio().get<String>(
      _userUrl,
      options: buildCacheOptions(shortDuration),
    );
  }
  //#endregion

  //#region POST
  static Future postShop(Shop shop) async {
    final reverseShop = shop.toJson();
    final shopJson = json.encode(reverseShop);
    final response = await dio.post(_shopUrl,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: shopJson);
    return response.statusCode;
  }

  static Future postStore(Store store) async {
    final reverseStore = store.toJson();
    final storeJson = json.encode(reverseStore);
    final response = await dio.post(_storeUrl,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: storeJson);
    return response.statusCode;
  }

  static Future postAccount(Account account) async {
    final reverseAccount = account.toJson();
    final accountJson = json.encode(reverseAccount);
    final response = await dio.post(_accountUrl,
        options: Options(headers: header), data: accountJson);
    return response.statusCode;
  }

  static Future postOrder(Order order) async {
    final reverseOrder = order.toJson();
    final orderJson = json.encode(reverseOrder);
    final response = await dio.post(_orderUrl,
        options: Options(headers: header), data: orderJson);
    return response.statusCode;
  }

  static Future postBouquet(Bouquet bouquet) async {
    final reverseBouquet = bouquet.toJson();
    final bouquetJson = json.encode(reverseBouquet);
    final response = await dio.post(_bouquetUrl,
        options: Options(headers: header), data: bouquetJson);
    return response.statusCode;
  }

  static Future postProduct(Product product) async {
    final reverseProduct = product.toJson();
    final productJson = json.encode(reverseProduct);
    final response = await dio.post(_productUrl,
        options: Options(headers: header), data: productJson);
    return response.statusCode;
  }

  static Future postBouquetProduct(BouquetProduct bouquetProduct) async {
    final reverseBouquetProduct = bouquetProduct.toJson();
    final bouquetProductJson = json.encode(reverseBouquetProduct);
    final response = await dio.post(_bouquetProductUrl,
        options: Options(headers: header), data: bouquetProductJson);
    return response.statusCode;
  }

  static Future postUser(User user) async {
    final reverseUser = user.toJson();
    final userJson = json.encode(reverseUser);
    final response = await dio.post(_userUrl,
        options: Options(headers: header), data: userJson);
    return response.statusCode;
  }
  //#endregion

  //#region PUT
  static Future putShop(Shop shop) async {
    final reverseShop = shop.toJsonUpdate();
    final shopJson = json.encode(reverseShop);
    final response = await dio.put(_shopUrl + shop.id.toString(),
        queryParameters: header, data: shopJson);
    return response.statusCode;
  }

  static Future putStore(Store store) async {
    final reverseStore = store.toJsonUpdate();
    final storeJson = json.encode(reverseStore);
    final response = await dio.put(_storeUrl + store.id.toString(),
        queryParameters: header, data: storeJson);
    return response.statusCode;
  }

  static Future putAccount(Account account) async {
    final reverseAccount = account.toJsonUpdate();
    final accountJson = json.encode(reverseAccount);
    final response = await dio.put(_accountUrl + account.id.toString(),
        queryParameters: header, data: accountJson);
    return response.statusCode;
  }

  static Future putOrder(Order order) async {
    final reverseOrder = order.toJsonUpdate();
    final orderJson = json.encode(reverseOrder);
    final response = await dio.put(_orderUrl + order.id.toString(),
        queryParameters: header, data: orderJson);
    return response.statusCode;
  }

  static Future putBouquet(Bouquet bouquet) async {
    final reverseBouquet = bouquet.toJsonUpdate();
    final bouquetJson = json.encode(reverseBouquet);
    final response = await dio.put(_bouquetUrl + bouquet.id.toString(),
        queryParameters: header, data: bouquetJson);
    return response.statusCode;
  }

  static Future putProduct(Product product) async {
    final reverseProduct = product.toJsonUpdate();
    final productJson = json.encode(reverseProduct);
    final response = await dio.put(_productUrl + product.id.toString(),
        queryParameters: header, data: productJson);
    return response.statusCode;
  }

  static Future putBouquetProduct(BouquetProduct bouquetProduct) async {
    final reverseBouquetProduct = bouquetProduct.toJsonUpdate();
    final bouquetProductJson = json.encode(reverseBouquetProduct);
    final response = await dio.put(
        _bouquetProductUrl + bouquetProduct.id.toString(),
        queryParameters: header,
        data: bouquetProductJson);
    return response.statusCode;
  }

  static Future putUser(User user) async {
    final reverseUser = user.toJsonUpdate();
    final userJson = json.encode(reverseUser);
    final response = await dio.put(_userUrl + user.id.toString(),
        queryParameters: header, data: userJson);
    return response.statusCode;
  }
  //#endregion

  //#region DELETE
  static Future deleteShop(int id) async {
    final response = await dio.delete(_shopUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteStore(int id) async {
    final response = await dio.delete(_storeUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteAccount(int? id) async {
    final response = await dio.delete(_accountUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteOrder(int id) async {
    final response = await dio.delete(_orderUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteBouquet(int? id) async {
    final response = await dio.delete(_bouquetUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteProduct(int id) async {
    final response = await dio.delete(_productUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteBouquetProduct(int id) async {
    final response = await dio.delete(_bouquetProductUrl + id.toString());
    return response.statusCode;
  }

  static Future deleteUser(int id) async {
    final response = await dio.delete(_userUrl + id.toString());
    return response.statusCode;
  }
  //#endregion
}
