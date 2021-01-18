import 'package:flutter/material.dart';
import 'package:message_app/helper/utils.dart';
import 'package:provider/provider.dart';

import '../../providers/contacts_provider.dart';

import '../../models/conversation.dart';

class AddContactScreen extends StatefulWidget {
  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String firstName = "", lastName = "";
  bool _formChecked = false, _formChanged = false;

  void _submitForm(Conversation convo) async {
    bool isValid = _formKey.currentState.validate();
    if (!isValid) {
      _formChecked = true;
      return;
    }
    _formKey.currentState.save();
    context.read<ContactsProvider>().addContact(convo, "$firstName$lastName");
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final convo = Provider.of<Conversation>(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white.withOpacity(0.9),
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Text(
          "Add contact",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save), onPressed: () => _submitForm(convo)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Profile Picture box
            Container(
              color: convo.sender.avClr,
              height: 160,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey,
                  size: 60,
                ),
              ),
            ),

            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                onChanged: () {
                  _formChanged = true;
                },
                onWillPop: () {
                  if (_formChanged) {
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        content: Text(
                          "Do you want to go back without saving your form data?",
                        ),
                        title: Text("Are you sure?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                          FlatButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              "No",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          )
                        ],
                      ),
                    );
                  }
                  return Future<bool>.value(true);
                },
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: _formChecked
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      decoration: InputDecoration(
                        labelText: "First Name",
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String title) {
                        FocusScope.of(context).requestFocus(_lastNameFocusNode);
                      },
                      onSaved: (fName) {
                        firstName = fName.trim();
                      },
                      validator: (fName) {
                        fName = fName.trim();
                        if (fName.isEmpty) {
                          return "Please enter a first name";
                        } else {
                          if (!Utils.nameRegex.hasMatch(fName)) {
                            return "Invalid characters found";
                          }
                          return null;
                        }
                      },
                    ),

                    SizedBox(height: 20),

                    //Last Name
                    TextFormField(
                      autovalidateMode: _formChecked
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      decoration: InputDecoration(
                        labelText: "Last Name",
                      ),
                      focusNode: _lastNameFocusNode,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (String title) {
                        _lastNameFocusNode.unfocus();
                      },
                      onSaved: (lName) {
                        lastName = lName.trim();
                        if (lastName.isNotEmpty) lastName = " $lastName";
                      },
                      validator: (lName) {
                        lName = lName.trim();
                        if (lName.isNotEmpty &&
                            !Utils.nameRegex.hasMatch(lName)) {
                          return "Invalid characters found";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
