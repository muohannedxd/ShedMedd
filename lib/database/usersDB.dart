import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controller/auth/auth_controller.dart';


class UsersDatabase {
  // get collection of users
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  // get all users
  Future<List<DocumentSnapshot>> getAllUsers() async {
    //await Future.delayed(Duration(seconds: 1));
    QuerySnapshot snapshot = await users.get();
    return snapshot.docs;
  }

  /**
   * get one user
   * this is used for getting the seller of the item
   */
  Future<DocumentSnapshot> getOneUser(String id) async {
    //await Future.delayed(Duration(milliseconds: 1000));
    DocumentSnapshot snapshot = await users.doc(id).get();
    return snapshot;
  }

  Future<DocumentSnapshot> getLoggedInUser() async {
    final AuthController authController = AuthController();
    String? user_id = await authController.getCurrentUserId();
    DocumentSnapshot logged_in_user = await users.doc(user_id).get();
    return logged_in_user;
  }

  void addUserData(String userId, Map<String, dynamic> userData) {
    // Reference to the Firebase Firestore collection with the specific user ID
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Reference to the specific document within the collection
    DocumentReference userDocument = usersCollection.doc(userId);

    // Set data for the specific user ID
    userDocument.set(userData).then((value) {
      print('Data added successfully for user with ID: $userId');
    }).catchError((error) {
      print('Failed to add data: $error');
    });
  }

  Future<String> signUpUser({
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) async {
    try {
      // Retrieve input values from controllers
      String name = nameController.text;
      String emailAddress = emailController.text;
      String password = passwordController.text;
      String confirmPassword = confirmPasswordController.text;

      if (password == confirmPassword) {
        // Create user with email and password
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailAddress, password: password);

        // Hash the password using BCrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Prepare user data
        Map<String, dynamic> userData = {
          'name': name,
          'email': emailAddress,
          'password': hashedPassword,
          'isSeller': false,
          'location': '',
          'phone': '',
          'profile_pic': '',
          'rate': ''
        };

        // Add user data to the database
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user != null) {
            addUserData(user.uid, userData);
          } else {
            // Handle case where user is not authenticated
            print('User is not authenticated');
          }
        });

        // Return true to indicate successful signup
        return 'Sign up successful!';
      } else {
        // Passwords do not match, show an error message or handle it accordingly
        print('Passwords do not match');
        return 'Passwords do not match';
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth exceptions
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'An account already exists for that email';
      } else {
        print('FirebaseAuthException: ${e.message}');
        return 'Error during signup';
      }

      // Return false to indicate signup failure
    } catch (e) {
      // Handle other exceptions
      print('Error during signup: $e');

      // Return false to indicate signup failure
      return 'Error during signup';
    }
  }

  Future<String> loginUser({
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      // Retrieve input values from controllers
      String emailAddress = emailController.text;
      String password = passwordController.text;

      // Sign in user with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // Retrieve the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // User is authenticated, you can handle the login success
        print('Login successful for user with ID: ${user.uid}');
        return 'Login successful!';
      } else {
        // Handle case where user is not authenticated
        print('User is not authenticated');
        return 'User is not authenticated';
      }
    } on FirebaseAuthException catch (e) {
      // User name not found or incorrect password error message too vague
      // it's all about giving an attacker as little information as possible.
      if (e.code == 'invalid-credential') {
        print('No user found for that email');
        return 'Wrong email or password provided';
      } else {
        print('FirebaseAuthException: ${e.code}');
        return 'Error during login';
      }
    } catch (e) {
      // Handle other exceptions
      print('Error during login: $e');
      return 'Error during login';
    }
  }
}
