import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsDatabase {
  // get collection of items
  final CollectionReference items =
      FirebaseFirestore.instance.collection('items');

  // get all items
  Future<List<DocumentSnapshot>> getAllItems() async {
    await Future.delayed(Duration(seconds: 1));
    QuerySnapshot snapshot = await items.get();
    return snapshot.docs;
  }

  // get one item
  Future<DocumentSnapshot> getOneItem(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    DocumentSnapshot snapshot = await items.doc(id).get();
    return snapshot;
  }
}
