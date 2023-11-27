// To parse this JSON data, do
//
//     final avilableSlots = avilableSlotsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AvilableSlots> avilableSlotsFromJson(String str) =>
    List<AvilableSlots>.from(
        json.decode(str).map((x) => AvilableSlots.fromJson(x)));

String avilableSlotsToJson(List<AvilableSlots> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AvilableSlots {
  DateTime appointmentStartTime;
  DateTime appointmentEndTime;
  int appointmentSlotId;

  AvilableSlots({
    required this.appointmentStartTime,
    required this.appointmentEndTime,
    required this.appointmentSlotId,
  });

  factory AvilableSlots.fromJson(Map<String, dynamic> json) => AvilableSlots(
        appointmentStartTime: DateTime.parse(json["AppointmentStartTime"]),
        appointmentEndTime: DateTime.parse(json["AppointmentEndTime"]),
        appointmentSlotId: json["AppointmentSlotId"],
      );

  Map<String, dynamic> toJson() => {
        "AppointmentStartTime": appointmentStartTime.toIso8601String(),
        "AppointmentEndTime": appointmentEndTime.toIso8601String(),
        "AppointmentSlotId": appointmentSlotId,
      };
}
