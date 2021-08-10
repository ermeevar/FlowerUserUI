import 'dart:convert';

import 'package:flower_user_ui/data/utils/json.dart';

List<Order> orderFromJson(String str) =>
    Json.jsonListFromString(str).map((e) => Order.fromJson(e)).toList();
String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    this.id,
    this.start,
    this.finish,
    this.isRandom,
    this.orderStatusId,
    this.userId,
    this.cost,
    this.card,
    this.bouquetId,
    this.templateId,
    this.shopId,
  });

  int? id;
  DateTime? start;
  DateTime? finish;
  bool? isRandom;
  int? orderStatusId;
  int? userId;
  double? cost;
  String? card;
  int? bouquetId;
  int? templateId;
  int? shopId;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] as int?,
        start: DateTime.parse(json["start"] as String),
        finish: DateTime.parse(json["finish"] as String),
        isRandom: json["isRandom"] as bool?,
        orderStatusId: json["orderStatusId"] as int?,
        userId: json["userId"] as int?,
        bouquetId: json["bouquetId"] as int?,
        templateId: json["templateId"] as int?,
        shopId: json["shopId"] as int?,
        card: json["card"] as String?,
        cost: json["cost"] as double?,
      );

  Map<String, dynamic> toJson() => {
        "start": start!.toIso8601String(),
        "finish": finish!.toIso8601String(),
        "isRandom": isRandom,
        "orderStatusId": orderStatusId,
        "userId": userId,
        "bouquetId": bouquetId,
        "templateId": templateId,
        "shopId": shopId,
        "card": card,
        "cost": cost,
      };

  Map<String, dynamic> toJsonUpdate() => {
        "id": id,
        "start": start!.toIso8601String(),
        "finish": finish!.toIso8601String(),
        "isRandom": isRandom,
        "orderStatusId": orderStatusId,
        "userId": userId,
        "bouquetId": bouquetId,
        "templateId": templateId,
        "shopId": shopId,
        "card": card,
        "cost": cost,
      };
}
