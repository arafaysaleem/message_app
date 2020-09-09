import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/messages_provider.dart';

import '../../helper/utils.dart';

import '../../models/conversation.dart';

import 'conversation_list_item.dart';

class ConversationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final convos = Provider.of<MessageManager>(context, listen: false).conversations;
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 17, 0),
      sliver: Selector<MessageManager, int>(
        selector: (ctx, msgManager) => msgManager.conversationsMap.length,
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
