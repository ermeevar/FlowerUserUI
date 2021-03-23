import 'dart:convert';

List<Template> templateFromJson(String str) => List<Template>.from(json.decode(str).map((x) => Template.fromJson(x)));

String templateToJson(List<Template> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Template {
  Template({
    this.id,
    this.name,
    this.templateCategoryId,
    this.storeId,
  });

  int id;
  String name;
  int templateCategoryId;
  int storeId;

  factory Template.fromJson(Map<String, dynamic> json) => Template(
    id: json["id"],
    name: json["name"],
    templateCategoryId: json["templateCategoryId"],
    storeId: json["storeId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "templateCategoryId": templateCategoryId,
    "storeId": storeId,
  };
}
