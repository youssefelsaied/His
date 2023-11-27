// To parse this JSON data, do
//
//     final record = recordFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Record> recordFromJson(String str) =>
    List<Record>.from(json.decode(str).map((x) => Record.fromJson(x)));

String recordToJson(List<Record> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Record {
  int recordId;
  int patientId;
  int doctorId;
  String doctorName;
  DateTime date;
  String diagnosis;
  String prescription;

  Record({
    required this.recordId,
    required this.patientId,
    required this.doctorId,
    required this.doctorName,
    required this.date,
    required this.diagnosis,
    required this.prescription,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        recordId: json["RecordId"],
        patientId: json["PatientId"],
        doctorId: json["DoctorId"],
        doctorName: json["DoctorName"],
        date: DateTime.parse(json["Date"]),
        diagnosis: json["Diagnosis"],
        prescription: json["Prescription"],
      );

  Map<String, dynamic> toJson() => {
        "RecordId": recordId,
        "PatientId": patientId,
        "DoctorId": doctorId,
        "DoctorName": doctorName,
        "Date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "Diagnosis": diagnosis,
        "Prescription": prescription,
      };
}
