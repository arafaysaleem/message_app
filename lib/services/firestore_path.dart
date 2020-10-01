import '../enums/conversation_type_enum.dart';

class FirestorePath{
  static String conversations(String uid) => 'users/$uid/conversations';
  // static String spammed(String uid) => 'users/$uid/spammed';
  // static String archived(String uid) => 'users/$uid/archived';
  static String groups(String uid) => 'users/$uid/groups';
  //static String conversation(String uid, ConversationType type,String number) => 'users/$uid/${type.getCollectionName()}/$number';
  static String conversation(String uid,String number) => 'users/$uid/conversations/$number';
  static String group(String uid, String groupID) => 'users/$uid/groups/$groupID';
}