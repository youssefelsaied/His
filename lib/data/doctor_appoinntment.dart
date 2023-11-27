// To parse this JSON data, do
//
//     final doctorAppointment = doctorAppointmentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<DoctorAppointment> doctorAppointmentFromJson(String str) =>
    List<DoctorAppointment>.from(
        json.decode(str).map((x) => DoctorAppointment.fromJson(x)));

String doctorAppointmentToJson(List<DoctorAppointment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorAppointment {
  int appointmentId;
  int patientId;
  int appointmentSlotId;
  DateTime appointmentStartTime;
  DateTime appointmentEndTime;
  String notes;

  DoctorAppointment({
    required this.appointmentId,
    required this.patientId,
    required this.appointmentSlotId,
    required this.appointmentStartTime,
    required this.appointmentEndTime,
    required this.notes,
  });

  factory DoctorAppointment.fromJson(Map<String, dynamic> json) =>
      DoctorAppointment(
        appointmentId: json["AppointmentId"],
        patientId: json["PatientId"],
        appointmentSlotId: json["AppointmentSlotId"],
        appointmentStartTime: DateTime.parse(json["AppointmentStartTime"]),
        appointmentEndTime: DateTime.parse(json["AppointmentEndTime"]),
        notes: json["Notes"],
      );

  Map<String, dynamic> toJson() => {
        "AppointmentId": appointmentId,
        "PatientId": patientId,
        "AppointmentSlotId": appointmentSlotId,
        "AppointmentStartTime": appointmentStartTime.toIso8601String(),
        "AppointmentEndTime": appointmentEndTime.toIso8601String(),
        "Notes": notes,
      };
}
