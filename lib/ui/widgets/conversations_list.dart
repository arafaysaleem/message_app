import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../providers/messages_provider.dart';

import '../../enums/filters_enum.dart';

import '../../models/conversation.dart';

import 'group_conversation_tile.dart';
import 'conversation_list_item.dart';

class ConversationsList extends StatelessWidget {
  final Filters currentFilter;

  const ConversationsList({Key key, this.currentFilter}) : super(key: key);

  getConvos(BuildContext context) {
    if (currentFilter == Filters.Archived)
      return Provider.of<MessageManager>(context, listen: false)
          .archivedConversations;
    else if (currentFilter == Filters.SpamAndBlocked)
      return Provider.of<MessageManager>(context, listen: false)
          .spammedConversations;
    else if (currentFilter == Filters.Groups)
      return Provider.of<MessageManager>(context, listen: false)
          .groupsConversations;

    return Provider.of<MessageManager>(context, listen: false).conversations;
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 17, 0),
      sliver: Selector<MessageManager,
          Tuple2<UnmodifiableMapView<String, Conversation>, int>>(
        selector: (ctx, msgManager) {
          int length;
          if (currentFilter == Filters.Archived)
            length = msgManager.archivedConversations.length;
          else if (currentFilter == Filters.SpamAndBlocked)
            length = msgManager.spammedConversations.length;
          else if (currentFilter == Filters.Groups) {
            length = msgManager.groupsMap.length;
            return Tuple2(msgManager.groupsMap, length);
          }
          length = msgManager.conversationsMap.length;
          return Tuple2(msgManager.conversationsMap, length);
        },
        builder: (ctx, __, _) {
          final List<Conversation> convos = getConvos(ctx);
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => ChangeNotifierProvider.value(
                value: convos[convos.length - i - 1],
                child: currentFilter == Filters.Groups
                    ? GroupConversationTile()
                    : ConversationListItem(),
              ),
              childCount: convos.length,
            ),
          );
        },
      ),
    );
  }
}
