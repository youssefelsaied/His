// To parse this JSON data, do
//
//     final favourite = favouriteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'brands_by_category.dart';

Favourite favouriteFromJson(String str) => Favourite.fromJson(json.decode(str));

class Favourite {
  Favourite({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.brands,
  });

  List<Brand> brands;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        brands: json["brands"] == null
            ? []
            : List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
      );
}
