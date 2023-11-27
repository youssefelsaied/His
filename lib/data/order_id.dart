// To parse this JSON data, do
//
//     final orderId = orderIdFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderId orderIdFromJson(String str) => OrderId.fromJson(json.decode(str));

class OrderId {
  OrderId({
    required this.id,
    required this.createdAt,
    required this.deliveryNeeded,
    required this.merchant,
    required this.amountCents,
  });

  int id;
  DateTime? createdAt;
  bool? deliveryNeeded;
  Merchant? merchant;
  int? amountCents;

  factory OrderId.fromJson(Map<String, dynamic> json) => OrderId(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        deliveryNeeded:
            json["delivery_needed"] == null ? null : json["delivery_needed"],
        merchant: json["merchant"] == null
            ? null
            : Merchant.fromJson(json["merchant"]),
        amountCents: json["amount_cents"] == null ? null : json["amount_cents"],
      );
}

class Merchant {
  Merchant({
    required this.id,
  });

  int id;

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        id: json["id"] == null ? null : json["id"],
      );
}
