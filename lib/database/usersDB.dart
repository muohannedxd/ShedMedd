import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
        addUserData(credential.user!.uid, userData);

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

      // Log in user with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // Retrieve the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        print('Login successful for user with ID: ${user.uid}');
        return 'Login successful!';
      } else {
        print('User is not authenticated');
        return 'User is not authenticated';
      }
    } on FirebaseAuthException catch (e) {
      // User name not found or incorrect password error message too vague
      if (e.code == 'invalid-credential') {
        print('No user found for that email');
        return 'Wrong email or password provided';
      } else {
        print('FirebaseAuthException: ${e.code}');
        return 'Error during login';
      }
    } catch (e) {
      print('Error during login: $e');
      return 'Error during login';
    }
  }

  Future<void> logoutUser() async {
    try {
      // Sign out of Firebase
      await FirebaseAuth.instance.signOut();

      // Sign out of Google
      await GoogleSignIn().signOut();

      print('Logout successful');
    } catch (e) {
      print('Error during logout: $e');
    }
  }

// Add user data to the database
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

// Send verification email
  Future<void> sendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();

      // You can show a message to the user to check their email for verification.
      print('Verification email sent to ${user.email}');
    } else {
      // Handle the case where the user is not signed in or their email is already verified.
      print('User is not signed in or email is already verified.');
    }
  }

  Future<bool> isUserVerified() async {
    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    // Check if the user is not null and if their email is verified
    if (user != null) {
      await user.reload();
      user = FirebaseAuth.instance.currentUser;
      return user!.emailVerified;
    }

    // If the user is null or their email is not verified, return false
    return false;
  }

  Future<String> signUpAndSendVerificationEmail({
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) async {
    try {
      // Call signUpUser function
      String signUpResult = await signUpUser(
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
      );

      // If signUpUser was successful, call sendEmailVerification
      if (signUpResult == 'Sign up successful!') {
        await sendEmailVerification();
      }

      // Return the result of signUpUser
      return signUpResult;
    } catch (e) {
      // Handle any exceptions that may occur
      print('Error during sign up and email verification: $e');
      return 'Error during sign up and email verification';
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null; // No error, operation successful
    } catch (e) {
      // Handle specific error cases
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            print("The provided email address is either invalid or not found");
            return "The provided email address is either invalid or not found";
          default:
            print("Error sending password reset email: ${e.message}");
            return "Error sending password reset email";
        }
      } else {
        // Handle other non-Firebase errors
        print("Error sending password reset email: $e");
        return "Error sending password reset email";
      }
    }
  }

  Future<String?> signUpWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User cancelled the sign-in process
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Retrieve user information
      final User user = userCredential.user!;
      final String userId = user.uid;
      final String name = user.displayName ?? '';
      final String emailAddress = user.email ?? '';

      // Update the userData map with the obtained information
      Map<String, dynamic> userData = {
        'name': name,
        'email': emailAddress,
        'password': '', // Google sign-in doesn't provide a password
        'isSeller': false,
        'location': '',
        'phone': '',
        'profile_pic': '',
        'rate': ''
      };

      // Add user data to the database and wait for completion
      addUserData(userId, userData);
      return "Successful signing up with Google";
    } catch (error) {
      // Handle errors
      print("Error signing in with Google: $error");
      // You can show a relevant error message to the user or perform other actions
      return "Error signing in with Google";
    }
  }

  Future<String?> logInWithGoogle() async {
    try {
      // begin interactive log in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // check if the user canceled the log-in process
      if (gUser == null) {
        return null; // Return null or a custom value to indicate cancellation
      }

      // obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // create a new credential for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // log in
      await FirebaseAuth.instance.signInWithCredential(credential);

      return "Successfull log in with Google";
    } catch (error) {
      // handle the error and return a custom error message or string
      return 'Error logging in with Google: $error';
    }
  }
}
