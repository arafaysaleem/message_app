import 'package:flutter/foundation.dart';

enum ConversationType{
  NORMAL,SPAMMED,ARCHIVED
}

extension ConversationTypeExtension on ConversationType{
  String get name => describeEnum(this);

  String getCollectionName() {
    switch (this) {
      case ConversationType.SPAMMED: return "spammed";
      case ConversationType.ARCHIVED: return "archived";
      default: return "conversations";
    }
  }
}