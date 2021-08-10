import 'dart:convert';

import 'package:flower_user_ui/internal/utils/json.dart';

List<User> userFromJson(String str) =>
    List<User>.from(Json.jsonListFromString(str).map((e) => User.fromJson(e)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.id,
    this.surname,
    this.name,
    this.phone,
    this.picture,
    this.accountId,
  });

  int? id;
  String? surname;
  String? name;
  String? phone;
  dynamic picture;
  int? accountId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] as int?,
        surname: json["surname"] as String?,
        name: json["name"] as String?,
        phone: json["phone"] as String?,
        picture: json["picture"] != null
            ? base64.decode(json["picture"] as String)
            : json["picture"],
        accountId: json["accountId"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "surname": surname,
        "name": name,
        "phone": phone,
        "picture": picture,
        "accountId": accountId,
      };

  Map<String, dynamic> toJsonUpdate() => {
        "id": id,
        "surname": surname,
        "name": name,
        "phone": phone,
        "picture": picture != null ? base64.encode(picture as List<int>) : null,
        "accountId": accountId,
      };
}
