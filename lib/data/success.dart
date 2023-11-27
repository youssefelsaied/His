// To parse this JSON data, do
//
//     final success = successFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Success successFromJson(String str) => Success.fromJson(json.decode(str));

String successToJson(Success data) => json.encode(data.toJson());

class Success {
  String status;

  Success({
    required this.status,
  });

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
      };
}
