class FirestorePath{

  /// Path to a collection of conversations of a user.
  static String conversations(String uid) => 'users/$uid/conversations';

  /// Path to a single conversation of a user, represented by a number.
  static String conversation(String uid,String number) => 'users/$uid/conversations/$number';

  /// Paths for getting the normal/spammed/archived conversation.
  /// @deprecated after storing all conversations in a single collection.
  ///
  /// static String conversation(String uid, ConversationType type,String number) => 'users/$uid/${type.getCollectionName()}/$number';
  ///
  /// static String spammed(String uid) => 'users/$uid/spammed';
  ///
  /// static String archived(String uid) => 'users/$uid/archived';

  /// Path to a collection of groups of a user.
  static String groups(String uid) => 'users/$uid/groups';

  /// Path to a single group of a user, represented by a groupID.
  static String group(String uid, String groupID) => 'users/$uid/groups/$groupID';

  /// Path to a collection of contacts of a user.
  static String contacts(String uid) => 'users/$uid/contacts';

  /// Path to a single contact of a user, represented by a number.
  static String contact(String uid,String number) => 'users/$uid/contacts/$number';
}