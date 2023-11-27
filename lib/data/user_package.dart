// To parse this JSON data, do
//
//     final userPackage = userPackageFromJson(jsonString);

import 'package:m3ak_user/data/subscription.dart';
import 'dart:convert';

UserPackage userPackageFromJson(String str) =>
    UserPackage.fromJson(json.decode(str));

class UserPackage {
  UserPackage({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory UserPackage.fromJson(Map<String, dynamic> json) => UserPackage(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.userPackages,
  });

  List<UserPackageElement> userPackages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userPackages: json["userPackages"] == null
            ? []
            : List<UserPackageElement>.from(json["userPackages"]
                .map((x) => UserPackageElement.fromJson(x))),
      );
}

class UserPackageElement {
  UserPackageElement({
    required this.id,
    required this.price,
    required this.title,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.packageValid,
    required this.transaction,
    required this.package,
  });

  int? id;
  String? price;
  String? title;
  int? status;
  DateTime? startDate;
  DateTime? endDate;
  bool? packageValid;
  bool? transaction;
  Package? package;

  factory UserPackageElement.fromJson(Map<String, dynamic> json) =>
      UserPackageElement(
        id: json["id"] == null ? null : json["id"],
        price: json["price"] == null ? null : json["price"],
        title: json["title"] == null ? null : json["title"],
        status: json["status"] == null ? null : json["status"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        packageValid:
            json["package_valid"] == null ? null : json["package_valid"],
        transaction: json["transaction"] == null ? null : json["transaction"],
        package:
            json["package"] == null ? null : Package.fromJson(json["package"]),
      );
}
