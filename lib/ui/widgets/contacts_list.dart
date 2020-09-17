import 'package:flutter/material.dart';

import '../../models/contact.dart';

class ContactsList extends StatelessWidget {
  final TextEditingController textEditingController;

  List<Contact> _contacts = [
    Contact(name: "Bakh", number: "03328652868", avClr: Colors.blue),
    Contact(number: "03012668889", name: "Zain", avClr: Colors.amber),
    Contact(name: "Bakhtyar Bellcow", number: "03009565352", avClr: Colors.red),
    Contact(number: "03009756562", name: "Meeran", avClr: Colors.blue),
    Contact(
        name: "Zohaib", number: "03003528563", avClr: Colors.lightGreenAccent),
    Contact(number: "03012500876", name: "Mama", avClr: Colors.red),
    Contact(name: "Suraksha", number: "03010656505", avClr: Colors.blue),
    Contact(number: "03012668889", name: "Zain", avClr: Colors.amber),
    Contact(name: "Bakhtyar Bellcow", number: "03009565352", avClr: Colors.red),
    Contact(number: "03009756562", name: "Meeran", avClr: Colors.blue),
    Contact(
        name: "Zohaib", number: "03003528563", avClr: Colors.lightGreenAccent),
    Contact(number: "03012500876", name: "Mama", avClr: Colors.red),
    Contact(name: "Suraksha", number: "03010656505", avClr: Colors.blue),
    Contact(number: "03012668889", name: "Zain", avClr: Colors.amber),
    Contact(name: "Bakhtyar Bellcow", number: "03009565352", avClr: Colors.red),
    Contact(number: "03009756562", name: "Meeran", avClr: Colors.blue),
    Contact(
        name: "Zohaib", number: "03003528563", avClr: Colors.lightGreenAccent),
    Contact(number: "03012500876", name: "Mama", avClr: Colors.red),
    Contact(name: "Suraksha", number: "03010656505", avClr: Colors.blue),
  ];

  final _topContacts = [
    Contact(name: "Bakh", number: "03328652868", avClr: Colors.blue),
    Contact(number: "03012668889", name: "Zain", avClr: Colors.amber),
    Contact(name: "Bakhtyar Bellcow", number: "03009565352", avClr: Colors.red),
    Contact(number: "03009756562", name: "Meeran", avClr: Colors.blue),
    Contact(
        name: "Zohaib", number: "03003528563", avClr: Colors.lightGreenAccent),
    Contact(number: "03012500876", name: "Mama", avClr: Colors.red),
    Contact(name: "Suraksha", number: "03010656505", avClr: Colors.blue),
    Contact(number: "03012668889", name: "Zain", avClr: Colors.amber),
  ];

  ContactsList({Key key, this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _contacts.sort((Contact a, Contact b) => a.name.compareTo(b.name));
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 17, 0),
      child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: _contacts.length,
        separatorBuilder: (ctx, i) => SizedBox(height: 22),
        itemBuilder: (ctx, i) {
          Contact contact = _contacts[i];

          return Column(
            children: [
              if(i==0 && textEditingController.text.isEmpty) Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Column(
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
                        Text("Create group",style: TextStyle(
                            fontSize: 16
                        ),)
                      ],
                    ),

                    SizedBox(height: 20),

                    //top contacts
                    Text(
                      "TOP CONTACTS",
                      style:
                      TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),

                    SizedBox(height: 20),

                    //top 0-4 contacts
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for(int i=0;i<4;i++)
                          SizedBox(
                            width: 70,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 29,
                                  backgroundColor: _topContacts[i].avClr,
                                  child: Text(
                                    _topContacts[i].name.substring(0, 1),
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
                          )
                      ],
                    ),

                    SizedBox(height: 15),

                    //top 4-8 contact
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for(int i=4;i<8;i++)
                          SizedBox(
                            width: 70,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 29,
                                  backgroundColor: _topContacts[i].avClr,
                                  child: Text(
                                    _topContacts[i].name.substring(0, 1),
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
                          )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: i == 0 ? const EdgeInsets.only(top: 15) : EdgeInsets.zero,
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
                                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
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
            ],
          );
        },
      ),
    );
  }
}
