// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddressCityArea addressFromJson(String str) =>
    AddressCityArea.fromJson(json.decode(str));

class AddressCityArea {
  AddressCityArea({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data? data;
  String message;

  factory AddressCityArea.fromJson(Map<String, dynamic> json) =>
      AddressCityArea(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.cities,
  });

  List<City> cities;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cities: json["cities"] == null
            ? []
            : List<City>.from(json["cities"].map((x) => City.fromJson(x))),
      );
}

class City {
  City({
    required this.id,
    required this.title,
    required this.areas,
  });

  int id;
  String title;
  List<Area> areas;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        areas: json["areas"] == null
            ? []
            : List<Area>.from(json["areas"].map((x) => Area.fromJson(x))),
      );
}

class Area {
  Area({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
      };
}
