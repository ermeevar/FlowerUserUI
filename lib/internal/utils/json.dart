import 'dart:convert';

class Json {
  static Map<String, dynamic> jsonFromString(String data) {
    return jsonDecode(data) as Map<String, dynamic>;
  }

  static List<Map<String, dynamic>> jsonListFromString(String data) {
    return (jsonDecode(data) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
}
