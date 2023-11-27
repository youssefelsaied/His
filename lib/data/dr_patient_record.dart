// To parse this JSON data, do
//
//     final doctorPatientRecord = doctorPatientRecordFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DoctorPatientRecord> doctorPatientRecordFromJson(String str) =>
    List<DoctorPatientRecord>.from(
        json.decode(str).map((x) => DoctorPatientRecord.fromJson(x)));

String doctorPatientRecordToJson(List<DoctorPatientRecord> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorPatientRecord {
  int recordId;
  int patientId;
  int doctorId;
  DateTime date;
  String diagnosis;
  String prescription;

  DoctorPatientRecord({
    required this.recordId,
    required this.patientId,
    required this.doctorId,
    required this.date,
    required this.diagnosis,
    required this.prescription,
  });

  factory DoctorPatientRecord.fromJson(Map<String, dynamic> json) =>
      DoctorPatientRecord(
        recordId: json["RecordId"],
        patientId: json["PatientId"],
        doctorId: json["DoctorId"],
        date: DateTime.parse(json["Date"]),
        diagnosis: json["Diagnosis"],
        prescription: json["Prescription"],
      );

  Map<String, dynamic> toJson() => {
        "RecordId": recordId,
        "PatientId": patientId,
        "DoctorId": doctorId,
        "Date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "Diagnosis": diagnosis,
        "Prescription": prescription,
      };
}
