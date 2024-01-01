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

class ChatInbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Shop(currentIndex: 0)),
            (route) => false);
        return false;
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
                          // Handle search action
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
              SizedBox(height: 5), // Spacer

              StreamBuilder(
                  stream: ChatDatabase().listenToChatInbox(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return /*CustomErrorWidget(errorText: 'An error occured!')*/
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                      return inboxItems.isNotEmpty
                          ? Flexible(
                              child: ListView.builder(
                                itemCount: inboxItems.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      buildInboxItem(
                                          context, inboxItems[index]),
                                      if (index < inboxItems.length - 1)
                                        SizedBox(height: 2),
                                    ],
                                  );
                                },
                              ),
                            )
                          : EmptyListWidget(
                              emptyError: 'You have no previous messages yet!');
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
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(child: CustomCircularProgress()),
                          errorWidget: (context, url, error) =>
                              Text(initials),
                        )
                      ),
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
