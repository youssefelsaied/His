// To parse this JSON data, do
//
//     final codePackage = codePackageFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'subscription.dart';

CodePackage codePackageFromJson(String str) =>
    CodePackage.fromJson(json.decode(str));

class CodePackage {
  CodePackage({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory CodePackage.fromJson(Map<String, dynamic> json) => CodePackage(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.code,
  });

  Code? code;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"] == null ? null : Code.fromJson(json["code"]),
      );
}

class Code {
  Code({
    required this.id,
    required this.code,
    required this.discount,
    required this.status,
    required this.package,
  });

  int? id;
  String? code;
  String? discount;
  bool? status;
  Package? package;

  factory Code.fromJson(Map<String, dynamic> json) => Code(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        discount: json["discount"] == null ? null : json["discount"],
        status: json["status"] == null ? null : json["status"],
        package:
            json["package"] == null ? null : Package.fromJson(json["package"]),
      );
}
