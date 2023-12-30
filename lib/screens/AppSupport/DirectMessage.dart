import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shedmedd/components/Shop/ItemNamePrice.dart';
import 'package:shedmedd/components/customCircularProg.dart';
import 'package:shedmedd/components/errorWidget.dart';
import 'package:shedmedd/components/floating_button.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';
import 'package:shedmedd/database/chatDB.dart';
import 'package:shedmedd/utilities/returnAction.dart';
import '../../utilities/successfulSnackBar.dart';

class DirectMessage extends StatefulWidget {
  const DirectMessage({super.key});

  @override
  State<DirectMessage> createState() => _DirectMessage();
}

class _DirectMessage extends State<DirectMessage> {
  String gc_id = '';
  String title = '';
  String condition = '';
  int price = 0;
  bool isSold = false;
  String receiverName = '';
  bool isShownSendingButton = false;
  String message = '';

  final TextEditingController _textEditingController = TextEditingController();
  String loggedInId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    gc_id = arguments['gc_id'];
    title = arguments['title'] as String;
    condition = arguments['condition'] as String;
    price = arguments['price'] as int;
    receiverName = arguments['receiverName'] as String;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 30),
            child: FloatingButton(
              action: returnToPreviousPage,
              title: '$receiverName',
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 10,
              bottom: 10,
            ),
            child: ItemNamePrice(
              title: title,
              condition: condition,
              price: price,
              isSold: isSold,
            ),
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
                reverse: true,
                child: StreamBuilder(
                    stream: ChatDatabase().listenToGroupChatMessages(gc_id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return CustomErrorWidget(
                            errorText: 'An error occured!');
                      } else if (snapshot.hasData) {
                        List<dynamic>? messages = snapshot.data;
                        if (messages!.isEmpty) {
                          return CustomErrorWidget(
                              errorText:
                                  'Send a message to start a conversation with $receiverName');
                        }
                        return Column(
                          children: messages
                              .map((messageInstance) => OneMessage(
                                    gc_id: gc_id,
                                    messageObject: messageInstance,
                                  ))
                              .toList(),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CustomCircularProgress(),
                        );
                      }
                    })),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                    color: CustomColors.grey.withOpacity(0.2), width: 1.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight:
                            120.0, // Set a maximum height for the container
                      ),
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: (value) {
                          setState(() {
                            /**
                             * disallow text that is only spaces or new lines
                             */
                            if (_textEditingController.text.trim().isNotEmpty)
                              isShownSendingButton = true;
                            else {
                              isShownSendingButton = false;
                            }
                          });
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 1,
                        maxLength: 2000,
                        decoration: InputDecoration(
                          hintText: 'Write your message here',
                          border: InputBorder.none,
                          counterText: '',
                          contentPadding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 8.0,
                            bottom: 8.0,
                          ),
                        ),
                        style: const TextStyle(fontSize: TextSizes.regular),
                      ),
                    ),
                  ),
                  isShownSendingButton
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              ChatDatabase().addMessageToGroupChat(
                                  gc_id,
                                  loggedInId,
                                  _textEditingController.text.trim());
                              // clear the field after the message is sent
                              _textEditingController.clear();
                              isShownSendingButton = false;
                            });
                          },
                          icon: Icon(
                            Icons.send,
                            color: CustomColors.textPrimary,
                          ),
                        )
                      : Text(''),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OneMessage extends StatefulWidget {
  final Map<String, dynamic> messageObject;
  final String gc_id;
  OneMessage({super.key, required this.messageObject, required this.gc_id});

  @override
  State<OneMessage> createState() => _OneMessageState();

}

class _OneMessageState extends State<OneMessage> {
  bool isShownDateTime = false;
  // on hold (long press)
  void toggleDateTime() {
    setState(() {
      isShownDateTime = !isShownDateTime;
    });
  }

  // on one tap
  void hideDateTime() {
    setState(() {
      isShownDateTime = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String loggedInId = FirebaseAuth.instance.currentUser!.uid;
    bool messageOfLoggedInUser =
        loggedInId == widget.messageObject['sender_id'] ? true : false;

    // formatting date and time
    DateTime dateTime = widget.messageObject['created_at'].toDate();
    String formattedDate = DateFormat.yMMMd().format(dateTime);
    String formattedTime = DateFormat.jm().format(dateTime);

    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        child: Column(
          crossAxisAlignment: messageOfLoggedInUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onLongPress: () {
                toggleDateTime();
                showPopupMenu(context, messageOfLoggedInUser);
              },
              onTap: hideDateTime,
              child: Row(
                mainAxisAlignment: messageOfLoggedInUser
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: messageOfLoggedInUser
                          ? CustomColors.textPrimary.withOpacity(0.8)
                          : CustomColors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.65),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(widget.messageObject['message'],
                          style: TextStyle(
                              color: messageOfLoggedInUser
                                  ? CustomColors.white
                                  : CustomColors.black,
                              fontSize: TextSizes.regular),
                          textAlign: TextAlign.start),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
                visible: isShownDateTime,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    '$formattedDate $formattedTime',
                    style: TextStyle(
                      color: CustomColors.textPrimary.withOpacity(0.6),
                      fontSize: TextSizes.small,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  // pop up menu after long press on a message
  void showPopupMenu(BuildContext context, bool messageOfLoggedInUser) async {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    double y = position.dy - 100;

    await showMenu(
      surfaceTintColor: CustomColors.textGrey,
      context: context,
      elevation: 16.0,
      position: RelativeRect.fromLTRB(200, y, 250, 250),
      items: [
        PopupMenuItem(
          value: 'copy',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              leading: Image.asset(
                'assets/icons/copy.png',
                color: CustomColors.textPrimary,
                width: 20,
              ),
              title: Text('Copy',
                  style: TextStyle(color: CustomColors.textPrimary)),
            ),
          ),
        ),
        PopupMenuItem(
          enabled: messageOfLoggedInUser,
          value: 'delete',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              leading: Image.asset(
                'assets/icons/delete.png',
                color: messageOfLoggedInUser
                    ? CustomColors.textPrimary
                    : CustomColors.textGrey,
                width: 20,
              ),
              title: Text('Delete',
                  style: TextStyle(
                      color: messageOfLoggedInUser
                          ? CustomColors.textPrimary
                          : CustomColors.textGrey)),
            ),
          ),
        ),
      ],
    ).then((value) async {
      if (value == 'copy') {
        // copy the message
        Clipboard.setData(ClipboardData(text: widget.messageObject['message']));
        showSnackBar(context, 'Message Copied', CustomColors.successGreen);
      } else if (value == 'delete') {
        // delete the message
        if (await ChatDatabase()
            .deleteMessage(widget.gc_id, widget.messageObject)) {
          hideDateTime();
          showSnackBar(context, 'Message deleted successfully!',
              CustomColors.successGreen);
        } else {
          showSnackBar(
              context, 'Message could not be deleted!', CustomColors.redAlert);
        }
      }
    });
  }
}
