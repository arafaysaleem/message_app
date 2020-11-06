import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/messages_provider.dart';

import '../../ui/screens/archived_screen.dart';
import '../../ui/screens/settings_screen.dart';
import '../../ui/screens/spam_blocked_msg_screen.dart';
import '../../ui/screens/web_message_screen.dart';

enum Filters {
  MarkAllAsRead,
  EnableDarkMode,
  SpamAndBlocked,
  SpammedGroups,
  MessagesForWeb,
  Settings,
  Conversation,
  Groups,
  Archived,
  ArchivedGroups,
  HelpAndFeedback
}

extension SelectedFilterExtension on Filters{
  String get name => describeEnum(this);

  void actionOnFilter(BuildContext context){
    switch(this){
      case Filters.MessagesForWeb: {
        Navigator.of(context).pushNamed(MessagesForWebScreen.routeName);
        return;
      }
      case Filters.Archived: {
        Navigator.of(context).pushReplacementNamed(ArchivedMessagesScreen.routeName,arguments: Filters.Conversation);
        return;
      }
      case Filters.SpamAndBlocked: {
        Navigator.of(context).pushReplacementNamed(SpamAndBlockedMessagesScreen.routeName, arguments: Filters.Conversation);
        return;
      }
      case Filters.ArchivedGroups: {
        Navigator.of(context).pushReplacementNamed(ArchivedMessagesScreen.routeName, arguments: Filters.Groups);
        return;
      }
      case Filters.SpammedGroups: {
        Navigator.of(context).pushReplacementNamed(SpamAndBlockedMessagesScreen.routeName, arguments: Filters.Groups);
        return;
      }
      case Filters.Settings: {
        Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName);
        return;
      }
      case Filters.MarkAllAsRead: {
        final msgManger = context.read<MessageManager>();
        msgManger.readAllConversations();
        return;
      }
      case Filters.EnableDarkMode: {
        //switch theme
        return;
      }
      case Filters.HelpAndFeedback: {
        //open chrome url
        return;
      }
      case Filters.Conversation: return;
      case Filters.Groups: {
        final msgManager= context.read<MessageManager>();
        msgManager.toggleDisplayGroupConvos();
        return;
      }
    }
  }
}
