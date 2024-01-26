import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:shedmedd/controller/auth/auth_controller.dart';
import 'package:shedmedd/database/usersDB.dart';
import 'package:shedmedd/main.dart';
import 'package:shedmedd/screens/Shop/Home.dart';

class FirebaseMessagingApi {
  // initialize an instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;
  AuthController authController = AuthController();

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
          'to': token,
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
      }
    } catch (e) {
      print("error: $e");
    }
  }

  /**
   * to handle the notification click
   */
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (_) => Shop(currentIndex: 3)));
  }

  /**
   * initialize background settings
   */
  Future initPushNotifications() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
