import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:shedmedd/controller/auth/auth_controller.dart';
import 'package:shedmedd/database/usersDB.dart';
import 'package:shedmedd/main.dart';
import 'package:shedmedd/screens/Shop/Home.dart';

class FirebaseMessagingApi {
  // initialize an instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;
  AuthController authController = AuthController();

  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is for notifications',
      importance: Importance.high);

  // funcion to initialize notifications
  Future<void> initNotifications() async {
    // request for permission
    await _firebaseMessaging.requestPermission();
    // get the device token
    final fCMToken = await _firebaseMessaging.getToken();
    if (fCMToken != null) {
      // get the current user id
      String? user_id = await authController.getCurrentUserId();
      // store in table users where the document id == user_id the fcmtoken
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(user_id).update({
        'fcmToken': fCMToken,
      });
      initPushNotifications();
      initLocalNotifications();
    }
  }

  /**
   * to send a notification to the receiver of a message
   */
  Future<void> sendMessageNotification(String sender_id, String receiver_id,
      String messageContent, String gc_id) async {
    try {
      // getting the name of the sender
      String senderName = await UsersDatabase().getNameOfUser(sender_id);
      List<String> nameParts = senderName.split(' ');
      String senderFirstName = nameParts[0];

      // token of the receiver user
      String token = await UsersDatabase().getUserToken(receiver_id);

      if (token.isNotEmpty) {
        // preparing the notification
        final body = {
          'to': '$token',
          'title': '$senderName',
          'body': '$senderFirstName: $messageContent'
        };

        // sending the notification
        var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'key=${dotenv.env['API_KEY']}'
            },
            body: jsonEncode(body));

        // ensuring the messaging of the notifications
        print('response: ${res.statusCode}');
        print('body: ${res.body}');
        print('to: $token');
      }
    } catch (e) {
      print("error: $e");
    }
  }

  /**
   * for local notifications
   */
  final _localNotifications = FlutterLocalNotificationsPlugin();

  /**
   * to handle the notification click
   */
  void handleMessage(RemoteMessage message) {
    navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (_) => Shop(currentIndex: 3)));
  }

  /**
   * init local notifications
   */
  Future initLocalNotifications() async {
    const IOS = DarwinInitializationSettings();
    const android =
        AndroidInitializationSettings('@drawable/logo_small_icon_only');
    const settings =
        InitializationSettings(android: android, iOS: IOS); // add the IOS one
    await _localNotifications.initialize(
      settings,
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  /**
   * initialize background settings
   */
  Future<void> initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        handleMessage(value);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message);
    });

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/logo_small_icon_only',
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });
  }
}
