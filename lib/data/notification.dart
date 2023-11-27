// To parse this JSON data, do
//
//     final userNotification = userNotificationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserNotification userNotificationFromJson(String str) =>
    UserNotification.fromJson(json.decode(str));

class UserNotification {
  UserNotification({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  UserNotificationData? data;
  String message;

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      UserNotification(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : UserNotificationData.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class UserNotificationData {
  UserNotificationData({
    required this.notifications,
    required this.lastPage,
  });

  List<UserNotificationModel> notifications;
  int lastPage;

  factory UserNotificationData.fromJson(Map<String, dynamic> json) =>
      UserNotificationData(
        notifications: json["notifications"] == null
            ? []
            : List<UserNotificationModel>.from(json["notifications"]
                .map((x) => UserNotificationModel.fromJson(x))),
        lastPage: json["last_page"] == null ? null : json["last_page"],
      );
}

class UserNotificationModel {
  UserNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.data,
  });

  int id;
  String title;
  String body;
  NotificationData? data;

  factory UserNotificationModel.fromJson(Map<String, dynamic> json) =>
      UserNotificationModel(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
        data: json["data"] == null
            ? null
            : NotificationData.fromJson(json["data"]),
      );
}

class NotificationData {
  NotificationData({
    required this.dataCase,
    // required this.id,
  });

  int dataCase;
  // int id;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        dataCase: json["case"] == null ? null : json["case"],
        // id: json["id"] == null ? null : json["id"],
      );
}
