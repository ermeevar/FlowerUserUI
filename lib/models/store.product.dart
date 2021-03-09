import 'dart:convert';

List<StoreProduct> storeProductFromJson(String str) => List<StoreProduct>.from(json.decode(str).map((x) => StoreProduct.fromJson(x)));

String storeProductToJson(List<StoreProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreProduct {
  StoreProduct({
    this.id,
    this.name,
    this.picture,
    this.cost,
    this.categoryId,
    this.storeId,
  });

  int id;
  String name;
  List<int> picture;
  double cost;
  int categoryId;
  int storeId;

  factory StoreProduct.fromJson(Map<String, dynamic> json) => StoreProduct(
    id: json["id"],
    name: json["name"],
    picture: json["picture"],
    cost: json["cost"].toDouble(),
    categoryId: json["categoryId"],
    storeId: json["storeId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picture": picture,
    "cost": cost,
    "categoryId": categoryId,
    "storeId": storeId,
  };
}
