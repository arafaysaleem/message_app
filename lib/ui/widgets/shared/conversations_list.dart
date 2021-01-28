import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../providers/messages_provider.dart';

import '../../../helper/enums/filters_enum.dart';

import '../../../models/conversation.dart';

import '../group_conversation_tile.dart';
import 'conversation_list_item.dart';
import 'empty_conversations_box.dart';

class ConversationsList extends StatelessWidget {
  final Filters currentFilter;

  const ConversationsList({Key key, @required this.currentFilter})
      : super(key: key);

  getConvos(BuildContext context) {
    final msgManager = Provider.of<MessagesProvider>(context, listen: false);
    switch (currentFilter) {
      case Filters.EnableDarkMode:
      case Filters.HelpAndFeedback:
      case Filters.MarkAllAsRead:
      case Filters.Settings:
      case Filters.MessagesForWeb:
      case Filters.Conversation:
        return msgManager.conversations;
      case Filters.Archived:
        return msgManager.archivedConversations;
      case Filters.SpamAndBlocked:
        return msgManager.spammedConversations;
      case Filters.Groups:
        return msgManager.groupsConversations;
      case Filters.ArchivedGroups:
        return msgManager.archivedGroups;
      case Filters.SpammedGroups:
        return msgManager.spammedGroups;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 17, 0),
      sliver: Selector<MessagesProvider,
          Tuple2<UnmodifiableMapView<String, Conversation>, int>>(
        selector: (ctx, msgManager) {
          int length;
          if (currentFilter == Filters.Archived)
            length = msgManager.archivedConversations.length;
          else if (currentFilter == Filters.SpamAndBlocked)
            length = msgManager.spammedConversations.length;
          else if (currentFilter == Filters.Groups) {
            if (currentFilter == Filters.ArchivedGroups)
              length = msgManager.archivedGroups.length;
            else if (currentFilter == Filters.SpammedGroups)
              length = msgManager.spammedGroups.length;
            else
              length = msgManager.groupsMap.length;
            return Tuple2(msgManager.groupsMap, length);
          }
          length = msgManager.conversationsMap.length;
          return Tuple2(msgManager.conversationsMap, length);
        },
        builder: (ctx, __, _) {
          final List<Conversation> convos = getConvos(ctx);
          if (convos.isEmpty)
            return SliverToBoxAdapter(child: EmptyConversationsBox());
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                final convo = convos[convos.length - i - 1];
                if (convo.messages.isNotEmpty)
                  return ChangeNotifierProvider.value(
                    value: convo,
                    child: {
                      Filters.SpammedGroups,
                      Filters.ArchivedGroups,
                      Filters.Groups
                    }.contains(currentFilter)
                        ? GroupConversationTile()
                        : ConversationListItem(),
                  );
                return SizedBox.shrink();
              },
              childCount: convos.length,
            ),
          );
        },
      ),
    );
  }
}
