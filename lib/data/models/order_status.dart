import 'dart:convert';

import 'package:flower_user_ui/data/utils/json.dart';

List<OrderStatus> orderStatusFromJson(String str) =>
    Json.jsonListFromString(str).map((e) => OrderStatus.fromJson(e)).toList();

String orderStatusToJson(List<OrderStatus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderStatus {
  OrderStatus({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        id: json["id"] as int?,
        name: json["name"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
