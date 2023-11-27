// To parse this JSON data, do
//
//     final brandsByCategory = brandsByCategoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BrandsByCategory brandsByCategoryFromJson(String str) =>
    BrandsByCategory.fromJson(json.decode(str));

class BrandsByCategory {
  BrandsByCategory({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory BrandsByCategory.fromJson(Map<String, dynamic> json) =>
      BrandsByCategory(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.brands,
    required this.lastPage,
  });

  List<Brand> brands;
  int? lastPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        brands: json["brands"] == null
            ? []
            : List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
        lastPage: json["last_page"] == null ? null : json["last_page"],
      );
}

class Brand {
  Brand({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.phoneNumber,
    required this.status,
    required this.isFavourite,
  });

  String? id;
  String? name;
  String? description;
  String? image;
  String? phoneNumber;
  bool? status;
  bool? isFavourite;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? null : json["image"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        status: json["status"] == null ? null : json["status"],
        isFavourite: json["is_favourite"] == null ? null : json["is_favourite"],
      );
}
