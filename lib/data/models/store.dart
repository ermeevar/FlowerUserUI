import 'dart:convert';
import 'dart:typed_data';

import 'package:flower_user_ui/data/utils/byte_list.dart';
import 'package:flower_user_ui/data/utils/json.dart';

List<Store> storeFromJson(String str) =>
    Json.jsonListFromString(str).map((e) => Store.fromJson(e)).toList();

String storeToJson(List<Store> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Store {
  Store({
    this.id,
    this.name,
    this.description,
    this.picture,
    this.firstPhone,
    this.secondPhone,
    this.accountId,
  });

  int? id;
  String? name;
  String? description;
  Uint8List? picture;
  String? firstPhone;
  String? secondPhone;
  int? accountId;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"] as int?,
        name: json["name"] as String?,
        description: json["description"].toString(),
        picture: ByteList.from(json["picture"]),
        firstPhone: json["firstPhone"] as String?,
        secondPhone: json["secondPhone"] as String?,
        accountId: json["accountId"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description.toString(),
        "picture": picture,
        "firstPhone": firstPhone,
        "secondPhone": secondPhone,
        "accountId": accountId,
      };

  Map<String, dynamic> toJsonUpdate() => {
        "id": id,
        "name": name,
        "description": description.toString(),
        "picture": picture != null ? base64.encode(picture!) : null,
        "firstPhone": firstPhone,
        "secondPhone": secondPhone,
        "accountId": accountId,
      };
}
