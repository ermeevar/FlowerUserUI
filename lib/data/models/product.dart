import 'dart:convert';

import 'dart:typed_data';

import 'package:flower_user_ui/internal/utils/byte_list.dart';
import 'package:flower_user_ui/internal/utils/json.dart';

List<Product> productFromJson(String str) =>
    Json.jsonListFromString(str).map((e) => Product.fromJson(e)).toList();

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.name,
    this.picture,
    this.cost,
    this.productCategoryId,
    this.storeId,
  });

  int? id;
  String? name;
  Uint8List? picture;
  double? cost;
  int? productCategoryId;
  int? storeId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] as int?,
        name: json["name"].toString(),
        picture: ByteList.from(json["picture"]),
        cost: json["cost"] as double?,
        productCategoryId: json["productCategoryId"] as int?,
        storeId: json["storeId"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "picture": picture != null ? base64.encode(picture!) : null,
        "cost": cost,
        "productCategoryId": productCategoryId,
        "storeId": storeId,
      };

  Map<String, dynamic> toJsonUpdate() => {
        "id": id,
        "name": name,
        "picture": picture != null ? base64.encode(picture!) : null,
        "cost": cost,
        "productCategoryId": productCategoryId,
        "storeId": storeId,
      };
}
