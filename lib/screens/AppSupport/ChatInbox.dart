// ChatInbox.dart
// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shedmedd/components/emptyListWidget.dart';
import 'package:shedmedd/components/errorWidget.dart';
import 'package:shedmedd/components/profileShimmer.dart';
import 'package:shedmedd/utilities/inboxGroupChat.dart';
import '../../components/customCircularProg.dart';
import '../../constants/customColors.dart';
import '../../constants/textSizes.dart';
import '../../database/chatDB.dart';
import '../../utilities/displayTimeAgo.dart';
import '../Shop/Home.dart';

class ChatInbox extends StatefulWidget {
  @override
  State<ChatInbox> createState() => _ChatInboxState();
}

class _ChatInboxState extends State<ChatInbox> {
  TextEditingController _searchController = TextEditingController();
  String searchKey = '';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => Shop(
              currentIndex: 0,
            ),
          ),
        );
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),

              // Search Bar
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onEditingComplete: () {
                            setState(() {
                              searchKey = _searchController.text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 20, top: 10, bottom: 10, right: 20),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Image.asset(
                          'assets/icons/search_filled.png',
                          width: 22,
                          color: CustomColors.textPrimary,
                        ),
                        onPressed: () {
                          setState(() {
                            searchKey = _searchController.text;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.0), // Spacer

              // Line with light grey
              Container(
                height: 1.0,
                color: CustomColors.grey.withOpacity(0.2),
              ),
              SizedBox(height: 5),

              StreamBuilder(
                  stream: ChatDatabase().listenToChatInbox(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              CustomErrorWidget(
                                errorText: 'An error occured!',
                              ),
                              Text('${snapshot.error}')
                            ],
                          ));
                    } else if (snapshot.hasData) {
                      List<InboxGroupChat> inboxItems = snapshot.data!;

                      if (inboxItems.isEmpty) {
                        return EmptyListWidget(
                            emptyError: 'You have no previous messages yet!');
                      } else {
                        // filter based on search key
                        List<InboxGroupChat> filteredInboxItems = inboxItems
                            .where((inboxItem) =>
                                inboxItem.itemName.contains(searchKey) ||
                                inboxItem.username.contains(searchKey))
                            .toList();

                        return filteredInboxItems.isNotEmpty
                            ? Flexible(
                                child: ListView.builder(
                                  itemCount: filteredInboxItems.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        buildInboxItem(
                                            context, filteredInboxItems[index]),
                                        if (index <
                                            filteredInboxItems.length - 1)
                                          SizedBox(height: 2),
                                      ],
                                    );
                                  },
                                ),
                              )
                            : EmptyListWidget(
                                emptyError:
                                    'No matching group chats found!');
                      }
                    } else {
                      return /*CustomErrorWidget(errorText: 'An error occured!')*/
                          Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            ProfileShimmer(),
                            SizedBox(height: 20),
                            ProfileShimmer(),
                            SizedBox(height: 20),
                            ProfileShimmer(),
                            SizedBox(height: 20),
                            ProfileShimmer()
                          ],
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInboxItem(BuildContext context, InboxGroupChat groupchat) {
    String initials = groupchat.itemName.toUpperCase().substring(0, 2);
    Timestamp currentTime = Timestamp.now();
    Duration difference =
        currentTime.toDate().difference(groupchat.lastTimeSent.toDate());

    String timeAgo = displayTimeAgo(difference);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/message',
          arguments: {
            'gc_id': groupchat.gc_id,
            'title': groupchat.itemName,
            'condition': groupchat.itemCondition,
            'price': groupchat.itemPrice,
            'receiverName': groupchat.username
          },
        );
      },
      child: Container(
          /*decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: CustomColors.grey.withOpacity(0.3))),
          ),*/
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 15), // Added horizontal padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(
                      backgroundColor: CustomColors.grey,
                      child: ClipOval(
                          child: CachedNetworkImage(
                        imageUrl: groupchat.profileImage,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(child: CustomCircularProgress()),
                        errorWidget: (context, url, error) =>
                            Center(child: Text(initials)),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 160,
                        child: Text(
                          groupchat.username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: TextSizes.medium,
                              color: CustomColors.textPrimary),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 160,
                        child: Text(
                          groupchat.itemName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: TextSizes.regular,
                              color: CustomColors.textGrey),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Text(
                timeAgo,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: TextSizes.small,
                    color: CustomColors.textGrey),
              ),
            ],
          )),
    );
  }
}