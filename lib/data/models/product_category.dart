import 'dart:convert';

import 'package:flower_user_ui/internal/utils/json.dart';

List<ProductCategory> productCategoryFromJson(String str) =>
    Json.jsonListFromString(str)
        .map((e) => ProductCategory.fromJson(e))
        .toList();

String productCategoryToJson(List<ProductCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductCategory {
  ProductCategory({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["id"] as int?,
        name: json["name"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
