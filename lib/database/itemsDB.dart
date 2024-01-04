import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ItemsDatabase {
  // get collection of items
  final CollectionReference items =
      FirebaseFirestore.instance.collection('items');

  // get all items
  Future<List<DocumentSnapshot>> getAllItems() async {
    //await Future.delayed(Duration(seconds: 1));
    QuerySnapshot snapshot = await items
        .orderBy('created_at', descending: true)
        .limit(6)
        .get(); // limit intentional for homepage slider
    return snapshot.docs;
  }

  // get one item
  Future<DocumentSnapshot> getOneItem(String id) async {
    //await Future.delayed(Duration(milliseconds: 500));
    DocumentSnapshot snapshot = await items.doc(id).get();
    return snapshot;
  }

  // get all items of a certain category
  Future<List<DocumentSnapshot>> getCategoryItems(String category) async {
    QuerySnapshot snapshot = await items
        .where('category', isEqualTo: category)
        .orderBy('created_at', descending: true)
        .limit(6)
        .get(); // limit intentional for homepage slider
    return snapshot.docs;
  }

  // get filtered items
  Future<List<DocumentSnapshot>> getFilteredItems(
      Map<String, dynamic> appliedFilters, int itemsLength) async {
    Map<String, dynamic> filters = appliedFilters;
    Query filteredQuery = items;

    if (filters['category'] != 'All') {
      filteredQuery =
          filteredQuery.where('category', isEqualTo: filters['category']);
    }
    if (filters['subcategory'] != 'All') {
      filteredQuery =
          filteredQuery.where('subcategory', isEqualTo: filters['subcategory']);
    }
    if (filters['condition'] != 'All') {
      filteredQuery =
          filteredQuery.where('condition', isEqualTo: filters['condition']);
    }
    filteredQuery = filteredQuery.where('price',
        isGreaterThanOrEqualTo: filters['minPrice'],
        isLessThanOrEqualTo: filters['maxPrice']);

    QuerySnapshot snapshot = await filteredQuery.limit(itemsLength).get();
    return snapshot.docs;
  }

  Future<List<DocumentSnapshot>> getSpecificItems(
    Map<String, dynamic> appliedFilters,
    int itemsLength
  ) async {
    Map<String, dynamic> filters = appliedFilters;
    Query filteredQuery = items;

    // Combine all filter criteria into a single compound condition
    if (filters['category'] != 'All') {
      filteredQuery =
          filteredQuery.where('category', isEqualTo: filters['category']);
    }
    if (filters['subcategory'] != 'All') {
      filteredQuery =
          filteredQuery.where('subcategory', isEqualTo: filters['subcategory']);
    }
    if (filters['condition'] != 'All') {
      filteredQuery =
          filteredQuery.where('condition', isEqualTo: filters['condition']);
    }
    filteredQuery = filteredQuery.where('price',
        isGreaterThanOrEqualTo: filters['minPrice'],
        isLessThanOrEqualTo: filters['maxPrice']);

    // Fetch all documents
    QuerySnapshot snapshot = await filteredQuery.limit(itemsLength).get();

    // Search by name or description
    String searchKey = filters['title'];
    if (searchKey.isNotEmpty) {
      String lowerCaseSearchKey = searchKey.toLowerCase();
      List<DocumentSnapshot> filteredDocs = snapshot.docs.where((doc) {
        String itemName = doc['title'].toString().toLowerCase();
        String itemDescription = doc['description'].toString().toLowerCase();
        return itemName.contains(lowerCaseSearchKey) ||
            itemDescription.contains(lowerCaseSearchKey);
      }).toList();

      return filteredDocs;
    }

    return snapshot.docs;
  }

  // get items of a user
  Future<List<DocumentSnapshot>> getUserItems(String user_id, int itemsLength) async {
    //await Future.delayed(Duration(seconds: 1));
    QuerySnapshot snapshot = await items
        .where('user_id', isEqualTo: user_id)
        .orderBy('created_at', descending: true)
        .limit(itemsLength)
        .get();
    return snapshot.docs;
  }

  // adding a new item
  Future<void> addAnItemData(
      Map<String, dynamic> itemData, List<String> imagePaths) async {
    CollectionReference itemsCollection =
        FirebaseFirestore.instance.collection('items');

    WriteBatch batch = FirebaseFirestore.instance.batch();
    DocumentReference itemDocRef = itemsCollection.doc();
    batch.set(itemDocRef, itemData);

    List<Future<void>> uploadTasks = [];

    for (int i = 0; i < imagePaths.length; i++) {
      String imagePath = imagePaths[i];
      String uuid = Uuid().v4();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/items/$uuid');
      UploadTask uploadTask = storageReference.putFile(File(imagePath));

      Future<void> uploadFuture = uploadTask.then((_) async {
        String imageUrl = await storageReference.getDownloadURL();
        batch.update(itemDocRef, {
          'images': FieldValue.arrayUnion([imageUrl])
        });
      });

      uploadTasks.add(uploadFuture);
    }

    try {
      await Future.wait(uploadTasks);
      await batch.commit();
      print('Item added successfully with ID: ${itemDocRef.id}');
    } catch (error) {
      print('Failed to add item data: $error');
    }
  }

  // removing an item
  Future<bool> deleteItem(String itemId, List<dynamic> imageUrls) async {
    try {
      // Delete item document from Firestore collection
      await items.doc(itemId).delete();

      // Delete images from Firebase Storage
      for (String imageUrl in imageUrls) {
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
      }

      return true;
    } catch (error) {
      return false;
    }
  }

  /**
   * marking an item as sold
   */
  Future<bool> markItemAsSold(String itemId) async {
    try {
      await items.doc(itemId).update({'isSold': true});
      return true;
    } catch (error) {
      return false;
    }
  }
}
