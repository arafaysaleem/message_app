import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/messages_provider.dart';

import '../utils.dart';

import '../../models/conversation.dart';

import '../../ui/screens/add_contact_screen.dart';
import '../../ui/screens/message_details_screen.dart';

enum ConversationActions { DELETE, DETAILS, ARCHIVE, HELP, ADD_CONTACT }

extension ConversationActionExtension on ConversationActions {
  String get name => describeEnum(this);

  void actionOnConversation(BuildContext context, convo) {
    switch (this) {
      case ConversationActions.DELETE:
        {
          final msgManger = context.read<MessagesProvider>();
          msgManger.deleteConversation(convo);
          Navigator.of(context).pop();
          Future.delayed(Duration(milliseconds: 300)).then(
            (value) => Utils.showFlushBar(
              context,
              "Conversation with ${convo.sender.name} deleted",
              Icons.delete,
            ),
          );
          return;
        }
      case ConversationActions.ARCHIVE:
        {
          final msgManger = context.read<MessagesProvider>();
          msgManger.toggleArchiveConvo(convo);
          Navigator.of(context).pop();
          Future.delayed(Duration(milliseconds: 300)).then(
            (value) => Utils.showFlushBar(
              context,
              "Conversation with ${convo.sender.name} archived",
              Icons.delete,
            ),
          );
          return;
        }
      case ConversationActions.HELP:
        {
          //go to help page
          return;
        }
      case ConversationActions.DETAILS:
        {
          final convo = context.read<Conversation>();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ChangeNotifierProvider.value(
                value: convo,
                child: MessageDetailsScreen(),
              ),
            ),
          );
          return;
        }
      case ConversationActions.ADD_CONTACT:
        {
          final convo = context.read<Conversation>();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ChangeNotifierProvider.value(
                value: convo,
                child: AddContactScreen(),
              ),
            ),
          );
          return;
        }
    }
  }
}
