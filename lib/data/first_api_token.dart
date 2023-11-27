// To parse this JSON data, do
//
//     final firstApiToken = firstApiTokenFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FirstApiToken firstApiTokenFromJson(String str) =>
    FirstApiToken.fromJson(json.decode(str));

class FirstApiToken {
  FirstApiToken({
    required this.token,
  });

  String token;

  factory FirstApiToken.fromJson(Map<String, dynamic> json) => FirstApiToken(
        token: json["token"] == null ? null : json["token"],
      );
}
