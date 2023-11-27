// To parse this JSON data, do
//
//     final billing = billingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Billing> billingFromJson(String str) =>
    List<Billing>.from(json.decode(str).map((x) => Billing.fromJson(x)));

String billingToJson(List<Billing> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Billing {
  int billingId;
  int patientId;
  String billingAmount;
  DateTime billingDate;
  int adminId;

  Billing({
    required this.billingId,
    required this.patientId,
    required this.billingAmount,
    required this.billingDate,
    required this.adminId,
  });

  factory Billing.fromJson(Map<String, dynamic> json) => Billing(
        billingId: json["BillingId"],
        patientId: json["PatientId"],
        billingAmount: json["BillingAmount"],
        billingDate: DateTime.parse(json["BillingDate"]),
        adminId: json["AdminId"],
      );

  Map<String, dynamic> toJson() => {
        "BillingId": billingId,
        "PatientId": patientId,
        "BillingAmount": billingAmount,
        "BillingDate":
            "${billingDate.year.toString().padLeft(4, '0')}-${billingDate.month.toString().padLeft(2, '0')}-${billingDate.day.toString().padLeft(2, '0')}",
        "AdminId": adminId,
      };
}
