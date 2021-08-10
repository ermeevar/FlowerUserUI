import 'dart:convert';

import 'package:flower_user_ui/internal/utils/json.dart';

List<Shop> shopFromJson(String str) =>
    Json.jsonListFromString(str).map((e) => Shop.fromJson(e)).toList();

String shopToJson(List<Shop> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Shop {
  Shop({
    this.id,
    this.address,
    this.storeId,
    this.accountId,
  });

  int? id;
  String? address;
  int? storeId;
  int? accountId;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"] as int?,
        address: json["address"] as String?,
        storeId: json["storeId"] as int?,
        accountId: json["accountId"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "storeId": storeId,
        "accountId": accountId,
      };

  Map<String, dynamic> toJsonUpdate() => {
        "id": id,
        "address": address,
        "storeId": storeId,
        "accountId": accountId,
      };
}
