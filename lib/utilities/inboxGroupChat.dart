import 'package:cloud_firestore/cloud_firestore.dart';

class InboxGroupChat {
  final String gc_id;
  final String username;
  final String itemName;
  final String itemCondition;
  final int itemPrice;
  final String profileImage;
  final Timestamp lastTimeSent;

  InboxGroupChat(this.gc_id, this.username, this.itemName, this.itemCondition,
      this.itemPrice, this.profileImage, this.lastTimeSent);
}
