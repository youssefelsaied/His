// To parse this JSON data, do
//
//     final subscription = subscriptionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Subscription subscriptionFromJson(String str) =>
    Subscription.fromJson(json.decode(str));

class Subscription {
  Subscription({
    @required this.success,
    @required this.data,
    @required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    @required this.packages,
  });

  List<Package>? packages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        packages: json["packages"] == null
            ? []
            : List<Package>.from(
                json["packages"].map((x) => Package.fromJson(x))),
      );
}

class Package {
  Package({
    @required this.id,
    @required this.type,
    @required this.duration,
    @required this.price,
    @required this.title,
    @required this.pointPerson,
  });

  int? id;
  String? type;
  int? duration;
  String? price;
  String? title;
  int? pointPerson;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        duration: json["duration"] == null ? null : json["duration"],
        price: json["price"] == null ? null : json["price"],
        title: json["title"] == null ? null : json["title"],
        pointPerson: json["point_person"] == null ? null : json["point_person"],
      );
}
