import 'package:flutter/material.dart';

import '../../../helper/enums/filters_enum.dart';

class DefaultAppBar extends StatelessWidget {
  final Filters currentFilter;

  const DefaultAppBar({Key key, @required this.currentFilter}) : super(key: key);

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
              child: currentFilter == Filters.Conversation ? Text("Groups") : Text("Individuals"),
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
              child: Text("Archived Groups"),
              value: Filters.ArchivedGroups,
            ),
            PopupMenuItem(
              child: Text("Spammed Groups"),
              value: Filters.SpammedGroups,
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
