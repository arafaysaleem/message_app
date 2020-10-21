import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:animations/animations.dart';

import '../../providers/contacts_provider.dart';
import '../../providers/messages_provider.dart';

import '../../enums/filters_enum.dart';

import 'new_message_screen.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_fab.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/shared/conversations_list.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _controller = ScrollController();

  // bool runOnce=false;

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if(!runOnce) {
  //     context.read<MessageManager>().addAllToFirebase();
  //     context.read<MessageManager>().addGroupsToFirebase();
  //     runOnce=true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowGlow();
                return false;
              },
              child: CustomScrollView(
                controller: _controller,
                slivers: [
                  Selector<MessageManager, int>(
                    selector: (ctx, msgMgr) =>
                        msgMgr.selectedConversations.length,
                    builder: (ctx, int length, child) => CustomAppBar(
                      length: length,
                      child: child,
                      duration: Duration(milliseconds: 300),
                    ),
                    child: DefaultAppBar(
                      currentFilter: context.select<MessageManager, bool>(
                              (msgManager) =>
                                  msgManager.displayGroupConversations)
                          ? Filters.Groups
                          : Filters.Conversation,
                    ),
                  ),
                  Selector<MessageManager, bool>(
                    selector: (ctx, msgManger) =>
                        msgManger.displayGroupConversations,
                    builder: (ctx, displayGroups, child) => displayGroups
                        ? ConversationsList(
                            currentFilter: Filters.Groups,
                          )
                        : child,
                    child: ConversationsList(
                      currentFilter: Filters.Conversation,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: OpenContainer(
        openElevation: 0,
        closedElevation: 0,
        openColor: Colors.transparent,
        closedColor: Colors.transparent,
        tappable: false,
        transitionType: ContainerTransitionType.fade,
        transitionDuration: Duration(milliseconds: 500),
        closedBuilder: (ctx, openFunction) => Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 5),
          child: CustomFAB(
            controller: _controller,
            onTap: openFunction,
          ),
        ),
        openBuilder: (ctx, _) => ChangeNotifierProvider(
          create: (_) => ContactsProvider(context.read<MessageManager>()),
          child: NewMessageScreen(),
        ),
      ),
    );
  }
}
