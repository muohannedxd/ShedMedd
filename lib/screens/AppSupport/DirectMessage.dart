import 'package:flutter/material.dart';
import 'package:shedmedd/components/Shop/ItemNamePrice.dart';
import 'package:shedmedd/components/floating_button.dart';
import 'package:shedmedd/constants/customColors.dart';
import 'package:shedmedd/utilities/returnAction.dart';


class DirectMessage extends StatefulWidget {
  const DirectMessage({super.key});

  @override
  State<DirectMessage> createState() => _DirectMessage();
}

class _DirectMessage extends State<DirectMessage> {
  String title = '';
  String condition = '';
  int price = 0;
  bool isSold = false;
  String receiverName = '';
  bool isShownSendingButton = false;
  String message = '';
  // dummy messages
  List<String> messages = ['first message', 'second message'];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    title = arguments['title'] as String;
    condition = arguments['condition'] as String;
    price = arguments['price'] as int;
    receiverName = arguments['receiverName'] as String;

    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: Scaffold(
        body: Stack(
          children: [
            ListView(children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20),
                child: FloatingButton(action: returnToPreviousPage, title: '$receiverName'),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ItemNamePrice(
                    title: title, condition: condition, price: price, isSold: isSold),
              ),
              Divider(),
            ]),

            // sending message field
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.height * 0.02,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: Messages(messages: messages),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16.0),
                      border:
                          Border.all(color: Colors.grey.shade200, width: 1.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
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
                            decoration: InputDecoration(
                              hintText: 'Write your message here',
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 4.0,
                                bottom: 4.0,
                              ),
                            ),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        isShownSendingButton
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (message.length != 0) {
                                      messages.add(message);
                                      message = '';
                                      isShownSendingButton = false;
                                      _textEditingController.clear();
                                    }
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Messages extends StatelessWidget {
  const Messages({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<String> messages;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.68,
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: messages
              .map((message) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                    child: OneMessage(message: message),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class OneMessage extends StatelessWidget {
  final String message;
  const OneMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.textPrimary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          message,
          style: TextStyle(color: CustomColors.white),
        ),
      ),
    );
  }
}
