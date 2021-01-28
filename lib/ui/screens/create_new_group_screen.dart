import 'package:flutter/material.dart';
import 'package:message_app/providers/messages_provider.dart';

import 'package:provider/provider.dart';

import '../../providers/contacts_provider.dart';

import '../../models/conversation.dart';

import 'message_screen.dart';

class NewGroupScreen extends StatefulWidget {
  static const routeName = "NewGroupScreen";

  @override
  _NewGroupScreenState createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  TextEditingController _textEditingController;
  final formKey= GlobalKey<FormState>();
  final maxCharLimit = 100;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final contactsProvider =
        Provider.of<ContactsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 3,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          splashRadius: 21,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Text(
          "Add group name",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "Poppins",
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Conversation convo = contactsProvider.createNewGroupConversation(_textEditingController.text.trim());
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) {
                    return ChangeNotifierProvider.value(
                      value: convo,
                      child: MessageScreen(),
                    );
                  },
                ),
              );
              context.read<MessagesProvider>().readGroup(convo);
            },
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Text(
                _textEditingController.text.isEmpty ? "Skip" : "Next",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Poppins",
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 130),

              //Circle Avatars
              Wrap(
                runAlignment: WrapAlignment.spaceBetween,
                spacing: 6,
                runSpacing: 14,
                children: contactsProvider.selectedContacts
                    .map(
                      (contact) => CircleAvatar(
                        radius: 13,
                        backgroundColor: contact.avClr,
                        child: Text(
                          contact.name.substring(0, 1),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),

              SizedBox(height: 15),

              //Group name input field
              TextFormField(
                key: formKey,
                autofocus: true,
                onChanged: (_) {
                  setState(() {});
                },
                keyboardType: TextInputType.name,
                controller: _textEditingController,
                cursorColor: Theme.of(context).primaryColor,
                cursorHeight: 24,
                maxLines: 1,
                textInputAction: TextInputAction.done,
                validator: (msg){
                  if(msg.trim().length > 100) return "Name exceeding max length";
                  return null;
                },
                onFieldSubmitted: (_){
                  formKey.currentState.validate();
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16),
                  labelText: "Group name",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.grey[400],
                      width: 1.5,
                      style: BorderStyle.solid,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                      style: BorderStyle.solid,
                    ),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _textEditingController.clear();
                      });
                    },
                    child: _textEditingController.text.isNotEmpty
                        ? InkWell(
                            child: Icon(
                              Icons.cancel,
                              color: Colors.grey[700],
                              size: 28,
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                ),
              ),

              SizedBox(height: 5),

              //Character count
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${_textEditingController.text.length}/$maxCharLimit",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),

              SizedBox(height: 7),

              //Message
              Text(
                "Only you can see this group name",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
