import 'dart:convert';
import 'package:flower_user_ui/models/shop.dart';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));
String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Order {
  Order({
    this.id,
    this.start,
    this.finish,
    this.isRandom,
    this.orderStatusId,
    this.userId,
    this.cost,
    this.bouquetId,
    this.templateId,
    this.shopId,
  });

  int id;
  DateTime start;
  DateTime finish;
  bool isRandom;
  int orderStatusId;
  int userId;
  double cost;
  int bouquetId;
  int templateId;
  int shopId;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    start: DateTime.parse(json["start"]),
    finish: DateTime.parse(json["finish"]),
    isRandom: json["isRandom"],
    orderStatusId: json["orderStatusId"],
    userId: json["userId"],
    bouquetId: json["bouquetId"],
    templateId: json["templateId"],
    shopId: json["shopId"],
    cost: json["cost"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "start": start.toIso8601String(),
    "finish": finish.toIso8601String(),
    "isRandom": isRandom,
    "orderStatusId": orderStatusId,
    "userId": userId,
    "bouquetId": bouquetId,
    "templateId": templateId,
    "shopId": shopId,
    "cost": cost,
  };
}
