import 'package:flutter/material.dart';

import '../../enums/filters_enum.dart';

class DefaultAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          splashColor: Colors.grey,
          icon: Icon(
            Icons.search,
            color: Colors.grey[600],
          ),
          onPressed: () {},
        ),
        Expanded(
          child: TextField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              hintText: "Search images and video",
            ),
          ),
        ),
        PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
          ),
          onSelected: (Filters filter) => filter.actionOnFilter(context),
          icon: Icon(
            Icons.more_vert,
            color: Colors.grey[600],
          ),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: Text("Groups"),
              value: Filters.Groups,
            ),
            PopupMenuItem(
              child: Text("Mark all as read"),
              value: Filters.MarkAllAsRead,
            ),
            PopupMenuItem(
              child: Text("Messages for web"),
              value: Filters.MessagesForWeb,
            ),
            PopupMenuItem(
              child: Text("Enable dark mode"),
              value: Filters.EnableDarkMode,
            ),
            PopupMenuItem(
              child: Text("Archived"),
              value: Filters.Archived,
            ),
            PopupMenuItem(
              child: Text("Spam & Blocked"),
              value: Filters.SpamAndBlocked,
            ),
            PopupMenuItem(
              child: Text("Settings"),
              value: Filters.Settings,
            ),
            PopupMenuItem(
              child: Text("Help & feedback"),
              value: Filters.HelpAndFeedback,
            ),
          ],
        ),
      ],
    );
  }
}
