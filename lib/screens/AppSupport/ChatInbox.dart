// ChatInbox.dart
import 'package:flutter/material.dart';

import '../../constants/customColors.dart';
import '../Shop/Home.dart';

class ChatInbox extends StatelessWidget {
  final List<InboxItem> inboxItems = [
    InboxItem('Jane Cooper', 'Red blouse',
        'assets/images/logo_small_icon_only_inverted.png'),
    InboxItem('Jane Cooper', 'Pink shirt',
        'assets/images/logo_small_icon_only_inverted.png'),
    InboxItem('Jane Cooper', 'Pantalon',
        'assets/images/logo_small_icon_only_inverted.png'),
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

              // Unread messages text
              /*Text(
                '5 unread messages',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),*/

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
        
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: CustomColors.grey.withOpacity(0.3))),
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
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  item.itemName,
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
  final String itemName;
  final String characterImage;

  InboxItem(this.name, this.itemName, this.characterImage);
}
