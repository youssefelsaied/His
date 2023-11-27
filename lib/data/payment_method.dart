// To parse this JSON data, do
//
//     final paymentMethod = paymentMethodFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PaymentMethod paymentMethodFromJson(String str) =>
    PaymentMethod.fromJson(json.decode(str));

class PaymentMethod {
  PaymentMethod({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.paymentMethods,
  });

  List<PaymentMethodElement> paymentMethods;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paymentMethods: json["paymentMethods"] == null
            ? []
            : List<PaymentMethodElement>.from(json["paymentMethods"]
                .map((x) => PaymentMethodElement.fromJson(x))),
      );
}

class PaymentMethodElement {
  PaymentMethodElement({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.phoneNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  int? id;
  String? title;
  String? image;
  String? description;
  String? phoneNumber;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory PaymentMethodElement.fromJson(Map<String, dynamic> json) =>
      PaymentMethodElement(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        image: json["image"] == null ? null : json["image"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        description: json["description"] == null ? null : json["description"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );
}
