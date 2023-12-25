import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shedmedd/components/Shop/ItemNamePrice.dart';
import 'package:shedmedd/components/customCircularProg.dart';
import 'package:shedmedd/components/errorWidget.dart';
import 'package:shedmedd/components/floating_button.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/constants/textSizes.dart';
import 'package:shedmedd/database/chatDB.dart';
import 'package:shedmedd/utilities/returnAction.dart';

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

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    gc_id = arguments['gc_id'];
    title = arguments['title'] as String;
    condition = arguments['condition'] as String;
    price = arguments['price'] as int;
    receiverName = arguments['receiverName'] as String;

    final Future<List<dynamic>> messages =
        ChatDatabase().getGroupChatMessages(gc_id);

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
                child: FutureBuilder(
                    future: messages,
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
                                    message: messageInstance['message'],
                                    sender_id: messageInstance['sender_id'],
                                    timeSent: messageInstance['created_at'],
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
                border: Border.all(color: Colors.grey.shade200, width: 1.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight:
                            160.0, // Set a maximum height for the container
                      ),
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: (value) {
                          setState(() {
                            message = value;
                            if (message.length != 0)
                              isShownSendingButton = true;
                            else {
                              isShownSendingButton = false;
                            }
                          });
                        },
                        keyboardType: TextInputType.multiline,
                        // Enable multiline input
                        maxLines: null,
                        // Allow an unlimited number of lines
                        minLines: 1,
                        // Ensure there's always at least one line
                        decoration: InputDecoration(
                          hintText: 'Write your message here',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 8.0,
                            // Adjust the top padding for multiline input
                            bottom: 8.0,
                            // Adjust the bottom padding for multiline input
                          ),
                        ),
                        style: const TextStyle(fontSize: TextSizes.regular),
                      ),
                    ),
                  ),
                  isShownSendingButton
                      ? IconButton(
                          onPressed: () {
                            setState(() {});
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
  final String message;
  final String sender_id;
  final Timestamp timeSent;
  const OneMessage(
      {super.key,
      required this.message,
      required this.sender_id,
      required this.timeSent});

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
    bool messageOfLoggedInUser = loggedInId == widget.sender_id ? true : false;

    // formatting date and time
    DateTime dateTime = widget.timeSent.toDate();
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
              onLongPress: toggleDateTime,
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
                          : CustomColors.textGrey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.65),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(widget.message,
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
                  color: CustomColors.textPrimary,
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
}
