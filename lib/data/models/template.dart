import 'dart:convert';
import 'dart:typed_data';

import 'package:flower_user_ui/data/utils/byte_list.dart';
import 'package:flower_user_ui/data/utils/json.dart';

List<Template> templateFromJson(String str) =>
    Json.jsonListFromString(str).map((e) => Template.fromJson(e)).toList();

String templateToJson(List<Template> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Template {
  Template({
    this.id,
    this.name,
    this.templateCategoryId,
    this.storeId,
    this.picture,
    this.cost,
  });

  int? id;
  String? name;
  int? templateCategoryId;
  int? storeId;
  Uint8List? picture;
  double? cost;

  factory Template.fromJson(Map<String, dynamic> json) => Template(
        id: json["id"] as int?,
        name: json["name"] as String?,
        templateCategoryId: json["templateCategoryId"] as int?,
        storeId: json["storeId"] as int?,
        picture: ByteList.from(json["picture"]),
        cost: json["cost"] as double?,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "templateCategoryId": templateCategoryId,
        "storeId": storeId,
        "picture": picture != null ? base64.encode(picture!) : null,
        "cost": cost,
      };
}
