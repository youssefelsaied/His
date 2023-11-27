import 'dart:convert';

import 'brands_by_category.dart';

HighlightsOffer highlightsOfferFromJson(String str) =>
    HighlightsOffer.fromJson(json.decode(str));

class HighlightsOffer {
  HighlightsOffer({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory HighlightsOffer.fromJson(Map<String, dynamic> json) =>
      HighlightsOffer(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.highlightsOffers,
  });

  List<HighlightsOfferElement> highlightsOffers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        highlightsOffers: json["highlightsOffers"] == null
            ? []
            : List<HighlightsOfferElement>.from(json["highlightsOffers"]
                .map((x) => HighlightsOfferElement.fromJson(x))),
      );
}

class HighlightsOfferElement {
  HighlightsOfferElement({
    required this.id,
    required this.image,
    required this.brand,
  });

  int? id;
  String? image;
  Brand? brand;

  factory HighlightsOfferElement.fromJson(Map<String, dynamic> json) =>
      HighlightsOfferElement(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
      );
}
