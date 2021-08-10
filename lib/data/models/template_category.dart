import 'dart:convert';

import 'package:flower_user_ui/internal/utils/json.dart';

List<TemplateCategory> templateCategoryFromJson(String str) =>
    Json.jsonListFromString(str)
        .map((e) => TemplateCategory.fromJson(e))
        .toList();

String templateCategoryToJson(List<TemplateCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TemplateCategory {
  TemplateCategory({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory TemplateCategory.fromJson(Map<String, dynamic> json) =>
      TemplateCategory(
        id: json["id"] as int?,
        name: json["name"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
