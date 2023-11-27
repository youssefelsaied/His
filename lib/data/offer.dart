import 'dart:convert';

import 'brands_by_category.dart';

Offer offerFromJson(String str) => Offer.fromJson(json.decode(str));

class Offer {
  Offer({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.offers,
  });

  List<OfferElement> offers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        offers: json["offers"] == null
            ? []
            : List<OfferElement>.from(
                json["offers"].map((x) => OfferElement.fromJson(x))),
      );
}

class OfferElement {
  OfferElement({
    required this.id,
    required this.image,
    required this.brand,
  });

  int? id;
  String? image;
  Brand? brand;

  factory OfferElement.fromJson(Map<String, dynamic> json) => OfferElement(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
      );
}
