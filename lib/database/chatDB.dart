import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shedmedd/database/firebaseMessagingAPI.dart';
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
   * delete group chats (after deleting an item)
   */
  Future<void> deleteChatGroups(String itemId) async {
    try {
      // query the chatgroups with itemId
      QuerySnapshot chatGroupsSnapshot = await chatgroup
        .where('item_id', isEqualTo: itemId)
        .get();
      for (DocumentSnapshot document in chatGroupsSnapshot.docs) {
        await document.reference.delete();
      }
    } catch (e) {
      print('error deleting item');
    }
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

    FirebaseMessagingApi().sendMessageNotification(sender_id, message, gc_id);
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
   * for realtime messagres fetching
   */

  Stream<List<dynamic>> listenToGroupChatMessages(String gc_id, int length) {
    return FirebaseFirestore.instance
        .collection('chatgroup')
        .doc(gc_id)
        .snapshots()
        .map((snapshot) {
      List<dynamic> messages = snapshot.data()?['messages'];
      int startIndex = messages.length > length ? messages.length - length : 0;
      return messages.sublist(startIndex);
    });
  }

  /**
   * get all chat groups for the logged in user
   */

  Stream<List<InboxGroupChat>> listenToChatInbox() {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('chatgroup')
        .where(
          Filter.or(Filter('seller_id', isEqualTo: currentUserId),
              Filter('buyer_id', isEqualTo: currentUserId)),
        )
        .where('messages', isNotEqualTo: [])
        .snapshots()
        .asyncMap((snapshot) => Future.wait(snapshot.docs
            .map((doc) => _createInboxGroupChatFromDoc(doc))
            .toList()))
        .map((inboxChats) => inboxChats
          ..sort((a, b) => b.lastTimeSent.compareTo(a.lastTimeSent)));
  }

  Future<InboxGroupChat> _createInboxGroupChatFromDoc(
      DocumentSnapshot doc) async {
    String item_id = doc['item_id'];
    String sellerId = doc['seller_id'];
    String buyerId = doc['buyer_id'];
    List<dynamic> messages = doc['messages'];

    // get the id of the other user
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    String otherPartyId = sellerId == currentUserId ? buyerId : sellerId;

    // Query the `items` collection for the document with the matching `item_id`.
    DocumentSnapshot itemSnapshot = await ItemsDatabase().getOneItem(item_id);

    // Query the `users` collection for the document with the matching `seller_id`.
    DocumentSnapshot otherPartySnapshot =
        await UsersDatabase().getOneUser(otherPartyId);

    Timestamp lastMessageTimestamp = messages.isNotEmpty
        ? messages[messages.length - 1]['created_at']
        : Timestamp.now();
    ;

    InboxGroupChat inboxItem = InboxGroupChat(
        doc.id,
        otherPartySnapshot['name'],
        itemSnapshot['title'],
        itemSnapshot['condition'],
        itemSnapshot['price'],
        itemSnapshot['images'][0],
        lastMessageTimestamp);

    return inboxItem;
  }
}
