import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shedmedd/database/itemsDB.dart';
import 'package:shedmedd/database/usersDB.dart';
import 'package:shedmedd/utilities/inboxGroupChat.dart';

class ChatDatabase {
  // get collection of chatgroups
  final CollectionReference chatgroup =
      FirebaseFirestore.instance.collection('chatgroup');

  /**
   * create one group chat
   */
  Future<String> createGroupChat(
      String buyer_id, String seller_id, String item_id) async {
    DocumentReference groupChatRef = chatgroup.doc();
    await groupChatRef.set({
      'buyer_id': buyer_id,
      'item_id': item_id,
      'seller_id': seller_id,
      'messages': []
    });

    return groupChatRef.id;
  }

  /**
   * add a message to group chat
   */
  Future<void> addMessageToGroupChat(
      String gc_id, String sender_id, String message) async {
    DocumentReference groupChatRef = chatgroup.doc(gc_id);
    Map<String, dynamic> messageObject = {
      'message': message,
      'sender_id': sender_id,
      'created_at': Timestamp.now()
    };

    await groupChatRef.update({
      'messages': FieldValue.arrayUnion([messageObject])
    });
  }

  /**
   * delete one message from groupchat
   */
  Future<bool> deleteMessage(String gc_id, Map<String, dynamic> message) async {
    try {
      chatgroup.doc(gc_id).update({
        'messages': FieldValue.arrayRemove([message])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  /**
   * get the group chat id based on seller, buyer and the item
   */
  Future<String> getGroupChatId(
      String seller_id, String buyer_id, String item_id) async {
    QuerySnapshot groupChatSnapshot = await chatgroup
        .where(Filter.and(
            Filter('buyer_id', isEqualTo: buyer_id),
            Filter('seller_id', isEqualTo: seller_id),
            Filter('item_id', isEqualTo: item_id)))
        .limit(1)
        .get();

    if (groupChatSnapshot.docs.isNotEmpty) {
      return groupChatSnapshot.docs.first.id;
    }

    return 'null'; // Chat group not found
  }

  /**
   * get one group chat messages
   */
  Future<List<dynamic>> getGroupChatMessages(String gc_id) async {
    DocumentSnapshot groupChatSnapshot = await chatgroup.doc(gc_id).get();
    List<dynamic> messages = groupChatSnapshot['messages'];
    return messages;
  }

  /**
   * get all chat groups for the logged in user
   */
  Future<List<InboxGroupChat>> getInboxGroupChats() async {
    // Get the current user's ID.
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // Create a list to store the InboxGroupChat objects.
    List<InboxGroupChat> inboxGroupChats = [];

    // Query the chatgroup collection for all documents where the buyer_id or seller_id field is equal to the current user's ID.
    QuerySnapshot groupChatsSnapshot = await chatgroup
        .where(Filter.or(Filter('seller_id', isEqualTo: currentUserId),
            Filter('buyer_id', isEqualTo: currentUserId)))
        .get();

    // For each document returned by the query, get the item_id field and the timestamp of the most recent message.
    for (DocumentSnapshot groupchatSnapshot in groupChatsSnapshot.docs) {
      // Getting the item, seller and buyer
      String itemId = groupchatSnapshot['item_id'];
      String seller_id = groupchatSnapshot['seller_id'];
      String buyer_id = groupchatSnapshot['buyer_id'];
      List<dynamic> messages = groupchatSnapshot['messages'];

      String otherPartyId = seller_id == currentUserId ? buyer_id : seller_id;

      // Query the `items` collection for the document with the matching `item_id`.
      DocumentSnapshot itemSnapshot = await ItemsDatabase().getOneItem(itemId);

      // Query the `users` collection for the document with the matching `seller_id`.
      DocumentSnapshot otherPartySnapshot =
          await UsersDatabase().getOneUser(otherPartyId);

      // Sort the messages array based on the "created_at" timestamp in descending order
      messages.sort((a, b) => b['created_at'].compareTo(a['created_at']));

      if (messages.length != 0) {
        // Get the timestamp of the most recent message
        Timestamp lastMessageTimestamp =
            messages.isNotEmpty ? messages[0]['created_at'] : Timestamp.now();

        InboxGroupChat inboxItem = InboxGroupChat(
            groupchatSnapshot.id,
            otherPartySnapshot['name'],
            itemSnapshot['title'],
            itemSnapshot['condition'],
            itemSnapshot['price'],
            otherPartySnapshot['profile_pic'],
            lastMessageTimestamp);

        // Add the `InboxGroupChat` object to the list.
        inboxGroupChats.add(inboxItem);
      } else {
        continue;
      }
    }

    inboxGroupChats.sort((a, b) => b.lastTimeSent.compareTo(a.lastTimeSent));

    return inboxGroupChats;
  }
}
