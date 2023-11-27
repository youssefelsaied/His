// // To parse this JSON data, do
// //
// //     final menu = menuFromJson(jsonString);

// import 'dart:convert';

// Menu menuFromJson(String str) => Menu.fromJson(json.decode(str));

// class Menu {
//   Menu({
//     this.success,
//     this.data,
//     this.message,
//   });

//   bool? success;
//   Data? data;
//   String? message;

//   factory Menu.fromJson(Map<String, dynamic> json) => Menu(
//         success: json["success"] == null ? null : json["success"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//         message: json["message"] == null ? null : json["message"],
//       );
// }

// class Data {
//   Data({
//     this.categories,
//   });

//   List<Category>? categories;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         categories: json["categories"] == null
//             ? []
//             : List<Category>.from(
//                 json["categories"].map((x) => Category.fromJson(x))),
//       );
// }

// class Category {
//   Category({
//     this.id,
//     this.title,
//     this.image,
//   });

//   int? id;
//   String? title;
//   String? image;

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"] == null ? null : json["id"],
//         title: json["title"] == null ? null : json["title"],
//         image: json["image"] == null ? null : json["image"],
//       );
// }

// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Menu menuFromJson(String str) => Menu.fromJson(json.decode(str));

class Menu {
  Menu({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.categories,
    required this.lastPage,
  });

  List<Category> categories;
  int lastPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        lastPage: json["last_page"] == null ? null : json["last_page"],
      );
}

class Category {
  Category({
    required this.id,
    required this.title,
    required this.image,
    required this.subCategories,
  });

  int? id;
  String? title;
  String? image;
  List<SubCategory> subCategories;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        image: json["image"] == null ? null : json["image"],
        subCategories: json["sub_categories"] == null
            ? []
            : List<SubCategory>.from(
                json["sub_categories"].map((x) => SubCategory.fromJson(x))),
      );
}

class SubCategory {
  SubCategory({
    required this.id,
    required this.title,
  });

  int? id;
  String? title;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
      );
}
