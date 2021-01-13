import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/messages_provider.dart';
import '../../providers/contacts_provider.dart';

import '../../models/conversation.dart';

import '../screens/message_screen.dart';

// ignore: must_be_immutable
class TopContactsBox extends StatefulWidget {
  @override
  _TopContactsBoxState createState() => _TopContactsBoxState();
}

class _TopContactsBoxState extends State<TopContactsBox>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final contactsProvider = Provider.of<ContactsProvider>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Selector<ContactsProvider, int>(
            selector: (ctx, contactsProvider) =>
                contactsProvider.selectedContacts.length,
            builder: (ctx, _, child) => Wrap(
              spacing: 5,
              children: contactsProvider.selectedContacts
                  .map(
                    (contact) => Chip(
                      padding: const EdgeInsets.all(5),
                      deleteIcon: Icon(
                        Icons.clear,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      onDeleted: () {
                        contactsProvider.toggleSelected(contact);
                      },
                      elevation: 0,
                      avatar: CircleAvatar(
                        backgroundColor: contact.avClr,
                        child: contact.isAdded
                            ? Text(
                                contact.name.substring(0, 1),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 20,
                              ),
                      ),
                      label: Text(
                        contact.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          //create grp
          AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            child: contactsProvider.createGroupActive
                ? SizedBox.shrink()
                : InkWell(
                    onTap: contactsProvider.toggleCreateGroupMode,
                    child: Row(
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
                  ),
          ),

          if (contactsProvider.selectedContacts.length > 0 ||
              !contactsProvider.createGroupActive)
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
            children: contactsProvider.top8Contacts
                .map((contact) => TopContactItem(contact: contact))
                .toList(),
          ),
        ],
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
                    child: MessageScreen(),
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
