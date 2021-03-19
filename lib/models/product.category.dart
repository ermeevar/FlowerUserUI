import 'dart:convert';

List<ProductCategories> productCategoriesFromJson(String str) => List<ProductCategories>.from(json.decode(str).map((x) => ProductCategories.fromJson(x)));

String productCategoriesToJson(List<ProductCategories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductCategories {
  ProductCategories({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ProductCategories.fromJson(Map<String, dynamic> json) => ProductCategories(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
