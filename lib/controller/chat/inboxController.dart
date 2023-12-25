import 'package:get/get.dart';

import '../../database/chatDB.dart';
import '../../utilities/inboxGroupChat.dart';

class InboxController extends GetxController {
  final inboxGroupChats = Rx<Future<List<InboxGroupChat>>?>(null);

  void updateInbox() {
    inboxGroupChats.value = ChatDatabase().getInboxGroupChats();
  }
}
