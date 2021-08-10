import 'dart:convert';

import 'package:flower_user_ui/data/utils/json.dart';

List<BouquetProduct> bouquetProductFromJson(String str) =>
    Json.jsonListFromString(str)
        .map((e) => BouquetProduct.fromJson(e))
        .toList();

String bouquetProductToJson(List<BouquetProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BouquetProduct {
  BouquetProduct({
    this.id,
    this.productId,
    this.bouquetId,
  });

  int? id;
  int? productId;
  int? bouquetId;

  factory BouquetProduct.fromJson(Map<String, dynamic> json) => BouquetProduct(
        id: json["id"] as int?,
        productId: json["productId"] as int?,
        bouquetId: json["bouquetId"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "bouquetId": bouquetId,
      };

  Map<String, dynamic> toJsonUpdate() => {
        "id": id,
        "productId": productId,
        "bouquetId": bouquetId,
      };
}
