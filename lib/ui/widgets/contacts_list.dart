import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/messages_provider.dart';
import '../../providers/contacts_provider.dart';

import '../../models/conversation.dart';
import '../../models/contact.dart';

import '../screens/message_screen.dart';

// ignore: must_be_immutable
class ContactsList extends StatelessWidget {
  final TextEditingController textEditingController;
  String prevAlphabet = "null";

  ContactsList({Key key, this.textEditingController}) : super(key: key);

  List<Contact> getFilteredContacts(context) {
    if (textEditingController.text.isEmpty) {
      return Provider.of<ContactsProvider>(context, listen: false).contacts;
    }
    String search = textEditingController.text.toLowerCase();
    List<Contact> filteredContacts = [];
    Provider.of<ContactsProvider>(context, listen: false)
        .contacts
        .forEach((contact) {
      if (contact.name.toLowerCase().startsWith(search)) {
        filteredContacts.add(contact);
      }
    });
    return filteredContacts;
  }

  String getAlphabet(String name) {
    if (RegExp("[a-zA-Z]").hasMatch(name.substring(0, 1)))
      return name.substring(0, 1).toUpperCase();
    else
      return "#";
  }

  @override
  Widget build(BuildContext context) {
    final _contacts = getFilteredContacts(context);
    final conversationsMap =
        Provider.of<MessageManager>(context, listen: false).conversationsMap;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 17, 0),
      child: _contacts.isEmpty
          ? Center(
              child: Text(
                "No contacts found",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Top contacts
                    if (i == 0 && textEditingController.text.isEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Selector<ContactsProvider, UnmodifiableListView>(
                          selector: (ctx, contactsProvider) =>
                              contactsProvider.top8Contacts,
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
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600]),
                              ),

                              SizedBox(height: 20),

                              //top 0-4 contacts
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  for (int i = 0; i < 4; i++)
                                    SizedBox(
                                      width: 70,
                                      child: InkWell(
                                        onTap: () {
                                          Conversation convo = conversationsMap[
                                              _topContacts[i].number];
                                          Navigator.of(context)
                                              .push(
                                                MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      ChangeNotifierProvider
                                                          .value(
                                                    value: convo,
                                                    child: MessageScreen(
                                                      contact: _topContacts[i],
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .then((value) =>
                                                  convo.readConversation());
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 29,
                                              backgroundColor:
                                                  _topContacts[i].avClr,
                                              child: Text(
                                                _topContacts[i]
                                                    .name
                                                    .substring(0, 1),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 32,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              _topContacts[i].name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                              ),

                              SizedBox(height: 15),

                              //top 4-8 contact
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  for (int i = 4; i < 8; i++)
                                    SizedBox(
                                      width: 70,
                                      child: InkWell(
                                        onTap: () {
                                          Conversation convo = conversationsMap[
                                              _topContacts[i].number];
                                          Navigator.of(context)
                                              .push(
                                                MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      ChangeNotifierProvider
                                                          .value(
                                                    value: convo,
                                                    child: MessageScreen(
                                                      contact: _topContacts[i],
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .then((value) =>
                                                  convo.readConversation());
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 29,
                                              backgroundColor:
                                                  _topContacts[i].avClr,
                                              child: Text(
                                                _topContacts[i]
                                                    .name
                                                    .substring(0, 1),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 32,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              _topContacts[i].name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    //Alphabet
                    if (showLetter)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 8, 0, 8),
                        child: Text(
                          letter,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      ),

                    //List of contacts
                    InkWell(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //picture
                            CircleAvatar(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600]),
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
                    ),
                  ],
                );
              },
            ),
    );
  }
}
