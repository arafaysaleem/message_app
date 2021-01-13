import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/contacts_provider.dart';

import '../../models/conversation.dart';
import '../../models/contact.dart';

import 'contact_list_item.dart';
import 'top_contacts_box.dart';

// ignore: must_be_immutable
class ContactsList extends StatelessWidget {
  final TextEditingController textEditingController;
  String prevAlphabet = "null";

  ContactsList({Key key, this.textEditingController})
      : super(key: key);

  String getAlphabet(String name) {
    if (RegExp("[a-zA-Z]").hasMatch(name.substring(0, 1)))
      return name.substring(0, 1).toUpperCase();
    else
      return "#";
  }

  List<Widget> getListItem(showLetter,letter,contact){
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
    final contactsProvider = Provider.of<ContactsProvider>(
        context, listen: false);
    final _contacts = contactsProvider.getFilteredContacts(
        textEditingController.text);

    if (_contacts.isEmpty)
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
        itemCount: _contacts.length,
        itemBuilder: (ctx, i) {
          Contact contact = _contacts[i];

          String letter = getAlphabet(contact.name);

          bool showLetter = false;

          if (letter != prevAlphabet) {
            showLetter = true;
            prevAlphabet = letter;
          }

          if(contactsProvider.addMemberActive){
            final convo = Provider.of<Conversation>(context,listen: false);
            if(convo.containsParticipant(contact)) return SizedBox.shrink();
            return Column(
              children: getListItem(showLetter, letter, contact),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Top contacts
              if (i == 0 && textEditingController.text.isEmpty)
                TopContactsBox(),

              ...getListItem(showLetter, letter, contact)
            ],
          );
        },
      ),
    );
  }
}
