import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>> getOneUserProfile(String userId) async {
    try {
      DocumentSnapshot snapshot = await users.doc(userId).get();
      return snapshot.data() as Map<String, dynamic>? ?? {};
    } catch (e) {
      print("Error getting user profile: $e");
      return {};
    }
  }

  Future<String> getUserName(String userId) async {
    try {
      Map<String, dynamic> userProfile = await getOneUserProfile(userId);
      return userProfile['name'] ?? '';
    } catch (e) {
      print("Error getting user name: $e");
      return '';
    }
  }

  Future<String> getUserLocation(String userId) async {
    try {
      Map<String, dynamic> userProfile = await getOneUserProfile(userId);
      return userProfile['location'] ?? '';
    } catch (e) {
      print("Error getting user location: $e");
      return '';
    }
  }

  Future<String> getUserEmail(String userId) async {
    try {
      Map<String, dynamic> userProfile = await getOneUserProfile(userId);
      return userProfile['email'] ?? '';
    } catch (e) {
      print("Error getting user email: $e");
      return '';
    }
  }

  Future<String> getUserPhone(String userId) async {
    try {
      Map<String, dynamic> userProfile = await getOneUserProfile(userId);
      return userProfile['phone'] ?? '';
    } catch (e) {
      print("Error getting user phone: $e");
      return '';
    }
  }

  Future<String> getUserProfilePicture(String userId) async {
    try {
      Map<String, dynamic> userProfile = await getOneUserProfile(userId);
      return userProfile['profile_pic'] ?? '';
    } catch (e) {
      print("Error getting user profile picture: $e");
      return '';
    }
  }

  Future<String> getUserRate(String userId) async {
    try {
      Map<String, dynamic> userProfile = await getOneUserProfile(userId);
      return userProfile['rate'] ?? '';
    } catch (e) {
      print("Error getting user rate: $e");
      return '';
    }
  }


}
