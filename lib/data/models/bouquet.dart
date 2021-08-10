import 'dart:convert';

import 'package:flower_user_ui/internal/utils/json.dart';

List<Bouquet> bouquetFromJson(String str) =>
    Json.jsonListFromString(str).map((e) => Bouquet.fromJson(e)).toList();

String bouquetToJson(List<Bouquet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bouquet {
  Bouquet({
    this.id,
    this.name,
    this.cost,
    this.storeId,
    this.userId,
  });

  int? id;
  String? name;
  double? cost;
  int? storeId;
  int? userId;

  factory Bouquet.fromJson(Map<String, dynamic> json) => Bouquet(
        id: json["id"] as int?,
        name: json["name"] as String?,
        cost: json["cost"].toDouble() as double?,
        storeId: json["storeId"] as int?,
        userId: json["userId"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "cost": cost!.toDouble(),
        "storeId": storeId,
        "userId": userId,
      };

  Map<String, dynamic> toJsonUpdate() => {
        "id": id,
        "name": name,
        "cost": cost!.toDouble(),
        "storeId": storeId,
        "userId": userId,
      };
}
