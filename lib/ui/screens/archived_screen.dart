import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/messages_provider.dart';

import '../../enums/filters_enum.dart';

import '../widgets/shared/conversations_list.dart';
import '../widgets/actions_app_bar.dart';

class ArchivedMessagesScreen extends StatelessWidget {
  static const routeName = "ArchivedMessagesScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                Selector<MessageManager, int>(
                  selector: (ctx, msgMgr) => msgMgr.selectedConversations.length,
                  builder: (ctx, int length, child) =>  SliverAppBar(
                    forceElevated: false,
                    toolbarHeight: 58,
                    collapsedHeight: 60,
                    automaticallyImplyLeading: false,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    floating: true,
                    flexibleSpace: AnimatedContainer(
                      curve: Curves.decelerate,
                      height: 60,
                      duration: Duration(milliseconds: 300),
                      child: AnimatedSwitcher(
                        child: length == 0
                            ? child
                            : ActionsAppBar(
                          length: length,
                          currentFilter: Filters.Archived,
                        ),
                        duration: Duration(milliseconds: 300),
                      ),
                    ),
                  ),
                  child: ArchivedAppBar(),
                ),
                //TODO: Add empty archive box message
                ConversationsList(
                  currentFilter: Filters.Archived,
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}

class ArchivedAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          splashRadius: 21,
          onPressed: () => Navigator.of(context).pushReplacementNamed("/"),
          icon: Icon(Icons.arrow_back),
        ),
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Text(
          "Archived",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          PopupMenuButton(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            onSelected: (Filters filter) => filter.actionOnFilter(context),
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey[600],
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Help & feedback"),
                value: Filters.HelpAndFeedback,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

