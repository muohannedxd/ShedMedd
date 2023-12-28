import 'package:get/get.dart';
import '../../database/chatDB.dart';

class GroupChatController extends GetxController {
  final groupChatMessages = Rx<Future<List<dynamic>>?>(null);

  void updateGroupChatMessages(String gc_id) {
    groupChatMessages.value = ChatDatabase().getGroupChatMessages(gc_id);
  }
}
