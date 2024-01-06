import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shedmedd/controller/auth/auth_controller.dart';

class FirebaseMessagingApi {
  // initialize an instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // funcion to initialize notifications
  Future<void> initNotifications() async {
    // request for permission
    await _firebaseMessaging.requestPermission();
    // get the device token
    final fCMToken = await _firebaseMessaging.getToken();
    if (fCMToken != null) {
      // get the current user id
      AuthController authController = AuthController();
      String? user_id = await authController.getCurrentUserId();
      // store in table users where the document id == user_id the fcmtoken
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(user_id).update({
        'fcmToken': fCMToken,
      });
    }
  }
}
