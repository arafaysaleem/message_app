import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/messages_provider.dart';
import '../../providers/contacts_provider.dart';

import '../../models/conversation.dart';

import '../screens/message_screen.dart';

class TopContactsBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Selector<ContactsProvider, UnmodifiableListView>(
        selector: (ctx, contactsProvider) => contactsProvider.top8Contacts,
        builder: (ctx, _topContacts, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //create grp
            Row(
              children: [
                SizedBox(width: 10),
                Icon(
                  Icons.group_add,
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
                SizedBox(width: 25),
                Text(
                  "Create group",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),

            SizedBox(height: 20),

            //top contacts
            Text(
              "TOP CONTACTS",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),

            SizedBox(height: 20),

            //top 0-4 contacts
            Wrap(
              runAlignment: WrapAlignment.spaceBetween,
              spacing: 15.5,
              runSpacing: 15.5,
              children: _topContacts
                  .map((contact) => TopContactItem(contact: contact))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class TopContactItem extends StatelessWidget {
  final contact;

  const TopContactItem({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversationsMap =
        Provider.of<MessageManager>(context, listen: false).conversationsMap;
    return SizedBox(
      width: 70,
      child: InkWell(
        onTap: () {
          Conversation convo = conversationsMap[contact.number];
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (ctx) => ChangeNotifierProvider.value(
                value: convo,
                child: MessageScreen(
                  contact: contact,
                ),
              ),
            ),
          )
              .then((value) => convo.readConversation());
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 29,
              backgroundColor: contact.avClr,
              child: Text(
                contact.name.substring(0, 1),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              contact.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}