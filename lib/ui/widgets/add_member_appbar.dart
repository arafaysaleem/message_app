import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/contacts_provider.dart';

import '../../models/conversation.dart';

class AddMemberAppBar extends StatefulWidget {
  final TextEditingController textEditingController;

  const AddMemberAppBar({Key key, this.textEditingController})
      : super(key: key);

  @override
  _AddMemberAppBarState createState() => _AddMemberAppBarState();
}

class _AddMemberAppBarState extends State<AddMemberAppBar> {
  double _splashRadius;
  FocusNode _focusNode;
  bool isDialPad = false;

  @override
  void initState() {
    super.initState();
    _splashRadius = 21;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.textEditingController.dispose();
    super.dispose();
  }

  toggleKeyboardType() {
    setState(() {
      isDialPad = !isDialPad;
    });
    if (_focusNode.hasFocus) _focusNode.unfocus();
    Future.delayed(const Duration(milliseconds: 1), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  double getAppBarHeight(int length) {
    double minHeight = 103;
    for (int i = 0; i < length; i++) {
      if (minHeight < 208)
        minHeight += 20;
      else
        break;
    }
    return minHeight;
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: false,
      collapsedHeight: 103,
      elevation: 3,
      shadowColor: Colors.grey[50],
      backgroundColor: Colors.white,
      forceElevated: true,
      flexibleSpace: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                //Back Button
                IconButton(
                  onPressed: () {
                    final contactProvider = context.read<ContactsProvider>();
                    if (contactProvider.selectedContacts.isNotEmpty) {
                      contactProvider.setAddMemberMode(false);
                      contactProvider.clearSelected();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  splashRadius: _splashRadius,
                  icon: Icon(Icons.arrow_back),
                ),

                SizedBox(width: 7),

                //AppBar title
                Text(
                  "New Member",
                  style: TextStyle(fontSize: 17, fontFamily: "Poppins"),
                ),

                Spacer(),

                //Proceed Add Member Button
                Consumer<ContactsProvider>(
                  builder: (ctx, contactsProvider, child) => InkWell(
                    onTap: () {
                      if(contactsProvider.selectedContacts.isNotEmpty) {
                        //fetch conversation from top, and add members in it
                        contactsProvider.addParticipant(context.read<Conversation>());
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: contactsProvider.selectedContacts.isNotEmpty
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 13),
              ],
            ),

            //Search bar
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 2),
              child: Row(
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(width: 33),
                  Expanded(
                    child: TextField(
                      focusNode: _focusNode,
                      cursorColor: Theme.of(context).primaryColor,
                      textInputAction: TextInputAction.search,
                      maxLines: null,
                      keyboardType: isDialPad
                          ? TextInputType.number
                          : TextInputType.emailAddress,
                      decoration: InputDecoration.collapsed(
                        hintText: "Type a name, phone number, or email",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      controller: widget.textEditingController,
                    ),
                  ),
                  IconButton(
                    onPressed: toggleKeyboardType,
                    splashRadius: _splashRadius,
                    icon: Icon(
                      isDialPad ? Icons.dialpad : Icons.keyboard,
                      color: Colors.grey[800],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
