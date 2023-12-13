import 'package:cloud_firestore/cloud_firestore.dart';

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
}
