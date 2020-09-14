import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/messages_provider.dart';

import '../../enums/filters_enum.dart';

import '../../helper/utils.dart';

import '../../models/conversation.dart';

import 'conversation_list_item.dart';

class ConversationsList extends StatelessWidget {
  final List<Conversation> convos;
  final Filters currentFilter;

  const ConversationsList({Key key, this.convos, this.currentFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 17, 0),
      sliver: Selector<MessageManager, int>(
        selector: (ctx, msgManager) {
          if(currentFilter == Filters.Archived) return msgManager.archivedConversations.length;
          else if(currentFilter == Filters.SpamAndBlocked) return msgManager.spammedConversations.length;
          return msgManager.conversationsMap.length;
        },
        builder: (ctx, int length, _) => SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => ChangeNotifierProvider.value(
              value: convos[i],
              child: ConversationListItem(
                avClr: Utils.getAvatarColor(),
              ),
            ),
            childCount: convos.length,
          ),
        ),
      ),
    );
  }
}
