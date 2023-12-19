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
    QuerySnapshot snapshot = await items.get();
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
    QuerySnapshot snapshot =
        await items.where('category', isEqualTo: category).get();
    return snapshot.docs;
  }

  // get filtered items
  Future<List<DocumentSnapshot>> getFilteredItems(
      Map<String, dynamic> appliedFilters) async {
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

    QuerySnapshot snapshot = await filteredQuery.get();
    return snapshot.docs;
  }

  Future<List<DocumentSnapshot>> getSpecificItems(
    Map<String, dynamic> appliedFilters,
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
    QuerySnapshot snapshot = await filteredQuery.get();

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
  Future<List<DocumentSnapshot>> getUserItems(String user_id) async {
    //await Future.delayed(Duration(seconds: 1));
    QuerySnapshot snapshot = await items
        .where('user_id', isEqualTo: user_id)
        .orderBy('created_at', descending: true)
        .get();
    return snapshot.docs;
  }

  // adding a new item
  Future<void> addAnItemData(
      Map<String, dynamic> itemData, List<String> imagePaths) async {
    List<String> imageUrls = [];

    for (int i = 0; i < imagePaths.length; i++) {
      String imagePath = imagePaths[i];
      // to generate a unique identifier
      String uuid = Uuid().v4();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/items/$uuid');
      UploadTask uploadTask = storageReference.putFile(File(imagePath));

      await uploadTask.whenComplete(() async {
        String imageUrl = await storageReference.getDownloadURL();
        imageUrls.add(imageUrl);
      });
    }

    // Now 'imageUrls' contains the download URLs of the uploaded images
    print('Image URLs: $imageUrls');

    // Add the image URLs to the item data
    itemData["images"] = imageUrls;

    // Reference to the Firebase Firestore collection 'items'
    CollectionReference itemsCollection =
        FirebaseFirestore.instance.collection('items');

    // Add data to the 'items' collection
    itemsCollection.add(itemData).then((DocumentReference docRef) {
      print('Item added successfully with ID: ${docRef.id}');
    }).catchError((error) {
      print('Failed to add item data: $error');
    });
  }

  // removing an item
  Future<void> deleteItem(String itemId, List<dynamic> imageUrls) async {
    try {
      // Delete images from Firebase Storage
      for (String imageUrl in imageUrls) {
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
      }

      // Delete item document from Firestore collection
      await items.doc(itemId).delete();

      print('Item deleted successfully.');
    } catch (error) {
      print('Failed to delete item: $error');
    }
  }
}
