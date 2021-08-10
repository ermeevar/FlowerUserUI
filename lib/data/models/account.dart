import 'dart:convert';

import 'package:flower_user_ui/data/utils/json.dart';

List<Account> accountFromJson(String str) =>
    Json.jsonListFromString(str).map((e) => Account.fromJson(e)).toList();

String accountToJson(List<Account> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  Account({
    this.id,
    this.login,
    this.passwordHash,
    this.salt,
    this.role,
  });

  int? id;
  String? login;
  String? passwordHash;
  dynamic salt;
  String? role;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"] as int?,
        login: json["login"] as String?,
        passwordHash: json["passwordHash"] as String?,
        salt: json["salt"],
        role: json["role"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "passwordHash": passwordHash,
        "salt": salt,
        "role": role,
      };

  Map<String, dynamic> toJsonUpdate() => {
        "id": id,
        "login": login,
        "passwordHash": passwordHash,
        "salt": salt,
        "role": role,
      };
}
