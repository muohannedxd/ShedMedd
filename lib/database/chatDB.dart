import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shedmedd/utilities/inboxGroupChat.dart';

class ChatDatabase {
  /**
   * get all chat groups for the logged in user
   */
  Future<List<InboxGroupChat>> getInboxGroupChats() async {
    // Get the current user's ID.
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // Create a list to store the InboxGroupChat objects.
    List<InboxGroupChat> inboxGroupChats = [];

    // Query the chatgroup collection for all documents where the buyer_id or seller_id field is equal to the current user's ID.
    QuerySnapshot groupChatsSnapshot = await FirebaseFirestore.instance
        .collection('chatgroup')
        .where(Filter.or(Filter('seller_id', isEqualTo: currentUserId),
            Filter('buyer_id', isEqualTo: currentUserId)))
        .get();

    // For each document returned by the query, get the item_id field.
    for (DocumentSnapshot groupchatSnapshot in groupChatsSnapshot.docs) {
      String itemId = groupchatSnapshot['item_id'];

      String seller_id = groupchatSnapshot['seller_id'];
      String buyer_id = groupchatSnapshot['buyer_id'];

      String otherPartyId = seller_id == currentUserId ? buyer_id : seller_id;

      // Query the `items` collection for the document with the matching `item_id`.
      DocumentSnapshot itemSnapshot = await FirebaseFirestore.instance
          .collection('items')
          .doc(itemId)
          .get();

      // Query the `users` collection for the document with the matching `seller_id`.
      DocumentSnapshot otherPartySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(otherPartyId)
          .get();

      InboxGroupChat inboxItem = InboxGroupChat(
          groupchatSnapshot.id,
          otherPartySnapshot['name'],
          itemSnapshot['title'],
          itemSnapshot['condition'],
          itemSnapshot['price'],
          otherPartySnapshot['profile_pic']
        );

      // Add the `InboxGroupChat` object to the list.
      inboxGroupChats.add(inboxItem);
    }

    return inboxGroupChats;
  }
}
