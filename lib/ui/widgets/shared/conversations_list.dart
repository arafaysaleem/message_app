import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:message_app/ui/widgets/shared/empty_conversations_box.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../providers/messages_provider.dart';

import '../../../helper/enums/filters_enum.dart';

import '../../../models/conversation.dart';

import '../group_conversation_tile.dart';
import 'conversation_list_item.dart';

class ConversationsList extends StatelessWidget {
  final Filters currentFilter;

  const ConversationsList({Key key, @required this.currentFilter}) : super(key: key);

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
    else if (currentFilter == Filters.ArchivedGroups)
      return Provider.of<MessageManager>(context, listen: false)
          .archivedGroups;
    else if (currentFilter == Filters.SpammedGroups)
      return Provider.of<MessageManager>(context, listen: false)
          .spammedGroups;

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
            if (currentFilter == Filters.ArchivedGroups)
              length = msgManager.archivedGroups.length;
            else if (currentFilter == Filters.SpammedGroups)
              length = msgManager.spammedGroups.length;
            else length = msgManager.groupsMap.length;
            return Tuple2(msgManager.groupsMap, length);
          }
          length = msgManager.conversationsMap.length;
          return Tuple2(msgManager.conversationsMap, length);
        },
        builder: (ctx, __, _) {
          final List<Conversation> convos = getConvos(ctx);
          if(convos.isEmpty) return SliverToBoxAdapter(child: EmptyConversationsBox());
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                final convo=convos[convos.length - i - 1];
                if(convo.messages.isNotEmpty) return ChangeNotifierProvider.value(
                  value: convo,
                  child: {Filters.SpammedGroups,Filters.ArchivedGroups,Filters.Groups}.contains(currentFilter)
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
