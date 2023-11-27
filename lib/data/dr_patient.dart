// To parse this JSON data, do
//
//     final doctorPatient = doctorPatientFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DoctorPatient> doctorPatientFromJson(String str) =>
    List<DoctorPatient>.from(
        json.decode(str).map((x) => DoctorPatient.fromJson(x)));

String doctorPatientToJson(List<DoctorPatient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorPatient {
  int patientId;
  String patientName;
  DateTime dateOfBirth;
  String gender;
  String phone;
  String email;

  DoctorPatient({
    required this.patientId,
    required this.patientName,
    required this.dateOfBirth,
    required this.gender,
    required this.phone,
    required this.email,
  });

  factory DoctorPatient.fromJson(Map<String, dynamic> json) => DoctorPatient(
        patientId: json["PatientId"],
        patientName: json["PatientName"],
        dateOfBirth: DateTime.parse(json["DateOfBirth"]),
        gender: json["Gender"],
        phone: json["Phone"],
        email: json["Email"],
      );

  Map<String, dynamic> toJson() => {
        "PatientId": patientId,
        "PatientName": patientName,
        "DateOfBirth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "Gender": gender,
        "Phone": phone,
        "Email": email,
      };
}
