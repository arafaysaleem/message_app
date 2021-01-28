import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../providers/messages_provider.dart';
import '../../../providers/contacts_provider.dart';

import '../../../models/contact.dart';
import '../../../models/conversation.dart';

import '../../screens/message_screen.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;

  const ContactListItem({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msgManager = Provider.of<MessagesProvider>(context, listen: false);
    final contactsProvider =
        Provider.of<ContactsProvider>(context, listen: false);
    return InkWell(
      onLongPress: () {
        if (contactsProvider.createGroupActive || contactsProvider.addMemberActive) {
          contactsProvider.toggleSelected(contact);
        }
      },
      onTap: () {
        if (contactsProvider.createGroupActive || contactsProvider.addMemberActive) {
          contactsProvider.toggleSelected(contact);
        } else {
          Conversation convo = msgManager.getConversation(contact);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ChangeNotifierProvider.value(
                value: convo,
                child: MessageScreen(),
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //picture
            Selector<ContactsProvider, int>(
              selector: (ctx, contactsProvider) =>
                  contactsProvider.selectedContacts.length,
              builder: (BuildContext context, _, child) {
                if (contactsProvider.isSelected(contact))
                  return CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.indigoAccent[700],
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  );
                return child;
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: contact.avClr,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: contact.avClr,
                  child: Text(
                    contact.name.substring(0, 1),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
            ),

            //body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 1, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contact.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${contact.number.substring(0, 4)} ${contact.number.substring(4)}",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[700],
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Mobile",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
