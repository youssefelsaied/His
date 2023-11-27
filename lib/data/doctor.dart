// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Doctor> doctorFromJson(String str) =>
    List<Doctor>.from(json.decode(str).map((x) => Doctor.fromJson(x)));

String doctorToJson(List<Doctor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Doctor {
  int doctorId;
  String doctorName;
  String specialization;
  String description;
  String phone;
  String email;

  Doctor({
    required this.doctorId,
    required this.doctorName,
    required this.specialization,
    required this.description,
    required this.phone,
    required this.email,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        doctorId: json["DoctorId"],
        doctorName: json["DoctorName"],
        specialization: json["Specialization"],
        description: json["Description"],
        phone: json["Phone"],
        email: json["Email"],
      );

  Map<String, dynamic> toJson() => {
        "DoctorId": doctorId,
        "DoctorName": doctorName,
        "Specialization": specialization,
        "Description": description,
        "Phone": phone,
        "Email": email,
      };
}
