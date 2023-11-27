// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Appointment> appointmentFromJson(String str) => List<Appointment>.from(
    json.decode(str).map((x) => Appointment.fromJson(x)));

String appointmentToJson(List<Appointment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Appointment {
  int appointmentId;
  int patientId;
  int doctorId;
  String doctorName;
  int appointmentSlotId;
  DateTime appointmentStartTime;
  DateTime appointmentEndTime;
  String notes;

  Appointment({
    required this.appointmentId,
    required this.patientId,
    required this.doctorId,
    required this.doctorName,
    required this.appointmentSlotId,
    required this.appointmentStartTime,
    required this.appointmentEndTime,
    required this.notes,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        appointmentId: json["AppointmentId"],
        patientId: json["PatientId"],
        doctorId: json["DoctorId"],
        doctorName: json["DoctorName"],
        appointmentSlotId: json["AppointmentSlotId"],
        appointmentStartTime: DateTime.parse(json["AppointmentStartTime"]),
        appointmentEndTime: DateTime.parse(json["AppointmentEndTime"]),
        notes: json["Notes"],
      );

  Map<String, dynamic> toJson() => {
        "AppointmentId": appointmentId,
        "PatientId": patientId,
        "DoctorId": doctorId,
        "DoctorName": doctorName,
        "AppointmentSlotId": appointmentSlotId,
        "AppointmentStartTime": appointmentStartTime.toIso8601String(),
        "AppointmentEndTime": appointmentEndTime.toIso8601String(),
        "Notes": notes,
      };
}
