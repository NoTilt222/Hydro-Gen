import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'globals.dart';
import 'package:intl/intl.dart';

String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
void triggerWelcomeNotification() {
  Map<String, dynamic> notificationDetails = {
    "id": 1,
    "type": "welcome",
    "channelKey": "basic_channel",
    "title": "Welcome",
    "body": "We are happy to have you back Tim" + Emojis.activites_party_popper,
    "backgroundColor": 0xffFF0000,
    "timestamp": formattedDateTime,
  };
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: notificationDetails["id"],
      channelKey: notificationDetails["channelKey"],
      title: notificationDetails["title"],
      body: notificationDetails["body"],
      backgroundColor: Color(notificationDetails["backgroundColor"]),
    ),
  );
  notificationMap["welcome_" + notificationDetails["id"].toString()] = notificationDetails;
}

void triggerWaterOnNotification() {
  Map<String, dynamic> notificationDetails = {
    "id": 2,
    "type": "activity",
    "channelKey": "basic_channel",
    "title": "Activity Waterpump",
    "body": "Waterpump turned on" + Emojis.wheater_droplet,
    "backgroundColor": 0xffFF0000,
    "timestamp": formattedDateTime,
  };
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: notificationDetails["id"],
      channelKey: notificationDetails["channelKey"],
      title: notificationDetails["title"],
      body: notificationDetails["body"],
      backgroundColor: Color(notificationDetails["backgroundColor"]),
    ),
  );
  notificationMap["welcome_" + notificationDetails["id"].toString()] = notificationDetails;
}
void triggerWaterOffNotification() {
  Map<String, dynamic> notificationDetails = {
    "id": 3,
    "type": "activity",
    "channelKey": "basic_channel",
    "title": "Activity Waterpump",
    "body": "Waterpump turned off \u{1F4A4}",
    "backgroundColor": 0xffFF0000,
    "timestamp": formattedDateTime,
  };
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: notificationDetails["id"],
      channelKey: notificationDetails["channelKey"],
      title: notificationDetails["title"],
      body: notificationDetails["body"],
      backgroundColor: Color(notificationDetails["backgroundColor"]),
    ),
  );
  notificationMap["welcome_" + notificationDetails["id"].toString()] = notificationDetails;
}

void sysInitializedOn() {
  Map<String, dynamic> notificationDetails = {
    "id": 4,
    "type": "activity",
    "channelKey": "basic_channel",
    "title": "System Initialized",
    "body": "System has been Initialized \u{2699}",
    "backgroundColor": 0xffFF0000,
    "timestamp": formattedDateTime,
  };
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: notificationDetails["id"],
      channelKey: notificationDetails["channelKey"],
      title: notificationDetails["title"],
      body: notificationDetails["body"],
      backgroundColor: Color(notificationDetails["backgroundColor"]),
    ),
  );
  notificationMap["welcome_" + notificationDetails["id"].toString()] = notificationDetails;
}


void sysInitializedOff() {
  Map<String, dynamic> notificationDetails = {
    "id": 5,
    "type": "activity",
    "channelKey": "basic_channel",
    "title": "System Shut Down",
    "body": "System has been shut down \u{2699}",
    "backgroundColor": 0xffFF0000,
    "timestamp": formattedDateTime,
  };
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: notificationDetails["id"],
      channelKey: notificationDetails["channelKey"],
      title: notificationDetails["title"],
      body: notificationDetails["body"],
      backgroundColor: Color(notificationDetails["backgroundColor"]),
    ),
  );
  notificationMap["welcome_" + notificationDetails["id"].toString()] = notificationDetails;
}