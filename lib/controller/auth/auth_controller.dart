import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to get the current user ID
  Future<String?> getCurrentUserId() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userId = user.uid;
        return userId;
      }
      return null; // User is not signed in
    } catch (e) {
      print("Error getting user ID: $e");
      return null;
    }
  }

  bool isLoggedIn() {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return true;
      }
      return false; // User is not signed in
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
