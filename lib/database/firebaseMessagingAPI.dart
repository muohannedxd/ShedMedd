import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shedmedd/controller/auth/auth_controller.dart';
import 'package:shedmedd/database/usersDB.dart';

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
    }
  }

  /**
   * to send a notification to the receiver of a message
   */
  Future<void> sendMessageNotification(
      String sender_id, String messageContent, String gc_id) async {
    try {
      // getting the name of the sender
      String senderName = await UsersDatabase().getNameOfUser(sender_id);

      List<String> nameParts = senderName.split(' ');
      String senderFirstName = nameParts[0];

      // getting the current user id
      String? user_id = await authController.getCurrentUserId();
      String token = await UsersDatabase().getUserToken(user_id!);

      // preparing the notificaton
      var notification = {
        'title': senderName,
        'body': '$senderFirstName: $messageContent',
        'sound': 'default',
        'badge': '1',
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'payload': {'gc_id': gc_id}
      };

      var message = {
        'to': token,
        'notification': notification,
        'priority': 'high',
      };

      var response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['API_KEY']}',
        },
        body: jsonEncode(message),
      );

      print('FCM Response: ${response.body}');
    } catch (e) {
      print("error: $e");
    }
  }
}
