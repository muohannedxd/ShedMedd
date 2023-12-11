import 'package:cloud_firestore/cloud_firestore.dart';

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
}
