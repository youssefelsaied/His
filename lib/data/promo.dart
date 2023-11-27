import 'dart:convert';

Promo promoFromJson(String str) => Promo.fromJson(json.decode(str));

class Promo {
  Promo({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );
}

class Data {
  Data({
    required this.promoCode,
  });

  PromoCode promoCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        promoCode: PromoCode.fromJson(json["promoCode"]),
      );
}

class PromoCode {
  PromoCode({
    required this.id,
    required this.code,
    required this.discount,
    required this.status,
    required this.title,
    required this.description,
    required this.expDate,
  });

  int id;
  String code;
  int discount;
  bool status;
  String title;
  String description;
  DateTime expDate;

  factory PromoCode.fromJson(Map<String, dynamic> json) => PromoCode(
        id: json["id"],
        code: json["code"],
        discount: json["discount"],
        status: json["status"],
        title: json["title"],
        description: json["description"],
        expDate: DateTime.parse(json["exp_date"]),
      );
}
