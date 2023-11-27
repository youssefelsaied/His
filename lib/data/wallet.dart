// To parse this JSON data, do
//
//     final wallet = walletFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Wallet walletFromJson(String str) => Wallet.fromJson(json.decode(str));

class Wallet {
  Wallet({
    @required this.success,
    @required this.data,
    @required this.message,
  });

  bool? success;
  WalletDate? data;
  String? message;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : WalletDate.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class WalletDate {
  WalletDate({
    @required this.points,
    @required this.cacheBack,
  });

  int? points;
  int? cacheBack;

  factory WalletDate.fromJson(Map<String, dynamic> json) => WalletDate(
        points: json["points"] == null ? null : json["points"],
        cacheBack: json["cache_back"] == null ? null : json["cache_back"],
      );
}
