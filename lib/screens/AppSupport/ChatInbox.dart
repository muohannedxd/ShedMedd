// ChatInbox.dart
import 'package:flutter/material.dart';

import '../../constants/customColors.dart';
import '../Shop/Home.dart';

class ChatInbox extends StatefulWidget {
  @override
  _ChatInboxState createState() => _ChatInboxState();
}

class _ChatInboxState extends State<ChatInbox> {
  List<InboxItem> inboxItems = [
    InboxItem('Jane Cooper', 'manhhachkt08@gmail.com',
        'assets/images/logo_small_icon_only_inverted.png', false),
    InboxItem('Jane Cooper', 'manhhachkt08@gmail.com',
        'assets/images/logo_small_icon_only_inverted.png', false),
    InboxItem('Jane Cooper', 'manhhachkt08@gmail.com',
        'assets/images/logo_small_icon_only_inverted.png', false),
    // Add more Inbox items as needed...
  ];

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),

              // Search Bar
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  width: 350.0, // Set the desired width
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
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
                                left: 20, top: 10, bottom: 10, right: 10),
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
                color: Colors.grey[300],
              ),
              SizedBox(height: 5), // Spacer

              // Unread messages text
              Text(
                '5 unread messages',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 25), // Spacer

              // Inbox Items
              for (int i = 0; i < inboxItems.length; i++) ...[
                buildInboxItem(inboxItems[i]),
                if (i < inboxItems.length - 1)
                  SizedBox(height: 2), // Add spacing between items
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInboxItem(InboxItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          item.isRead = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 15, horizontal: 15), // Added horizontal padding
        child: Row(
          children: [
            Stack(
              children: [
                Image.asset(
                  item.characterImage,
                  width: 50,
                  height: 50,
                ),
                if (!item.isRead)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue, // Change color as needed
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 18.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: item.isRead ? FontWeight.w400 : FontWeight.w800,
                  ),
                ),
                Text(
                  item.email,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InboxItem {
  final String name;
  final String email;
  final String characterImage;
  bool isRead;

  InboxItem(this.name, this.email, this.characterImage, this.isRead);
}
