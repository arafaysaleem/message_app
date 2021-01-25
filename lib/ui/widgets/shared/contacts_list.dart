import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/contacts_provider.dart';
import '../../../providers/messages_provider.dart';

import '../../../helper/utils.dart';

import '../../../models/conversation.dart';
import '../../../models/contact.dart';

import '../../screens/message_screen.dart';

import 'contact_list_item.dart';
import '../top_contacts_box.dart';

// ignore: must_be_immutable
class ContactsList extends StatelessWidget {
  final TextEditingController textEditingController;
  String prevAlphabet = "null";

  ContactsList({Key key, this.textEditingController}) : super(key: key);

  String getAlphabet(String name) {
    if (RegExp("[a-zA-Z]").hasMatch(name.substring(0, 1)))
      return name.substring(0, 1).toUpperCase();
    else
      return "#";
  }

  List<Widget> getListItem(showLetter, letter, contact) {
    return [
      //Alphabet
      if (showLetter)
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 0, 8),
          child: Text(
            letter,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

      //Contact list item
      ContactListItem(contact: contact),
    ];
  }

  @override
  Widget build(BuildContext context) {
    String contactString = textEditingController.text;
    final contactsProvider =
        Provider.of<ContactsProvider>(context, listen: false);
    final isNum = Utils.numberRegex.hasMatch(contactString);
    final contacts = contactsProvider.getFilteredContacts(contactString);

    if (contacts.isEmpty && !isNum)
      return Center(
        child: Text(
          "No contacts found",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 17, 0),
      child: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: contacts.length + (isNum ? 1 : 0),
        itemBuilder: (ctx, i) {
          if (isNum) return _SendUnknownListItem(contactInput: contactString,);

          Contact contact = contacts[i];

          String letter = getAlphabet(contact.name);

          bool showLetter = false;

          if (letter != prevAlphabet) {
            showLetter = true;
            prevAlphabet = letter;
          }

          if (contactsProvider.addMemberActive) {
            final convo = Provider.of<Conversation>(context, listen: false);
            if (convo.containsParticipant(contact)) return SizedBox.shrink();
            return Column(
              children: getListItem(showLetter, letter, contact),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Top contacts
              if (i == 0 && contactString.isEmpty) TopContactsBox(),

              ...getListItem(showLetter, letter, contact)
            ],
          );
        },
      ),
    );
  }
}

class _SendUnknownListItem extends StatelessWidget {
  final contactInput;

  const _SendUnknownListItem({
    Key key,
    @required this.contactInput,
  }) : super(key: key);

  getContactString() {
    String string = "Send to ";
    if (contactInput.length < 5) {
      string += contactInput;
    } else {
      string +=
      "${contactInput.substring(0, 4)} ${contactInput.substring(4)}";
    }
    return string;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Conversation convo = context.read<MessageManager>().getConversation(
              Contact(avClr: Utils.getAvatarColor(), number: contactInput),
            );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ChangeNotifierProvider.value(
              value: convo,
              child: MessageScreen(),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //picture
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.red,
              child: Icon(Icons.person,color: Colors.white),
            ),

            //body
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                getContactString(),
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[700],
                  fontSize: 15,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
