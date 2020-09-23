import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/messages_provider.dart';

import '../../helper/utils.dart';

import '../../models/conversation.dart';

class MessageDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final Conversation convo =
        Provider.of<Conversation>(context, listen: false);
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
          "Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 22, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "OPTIONS",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            DetailOptionTile(
              width: width,
              text: "Notifications",
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              onTap: () {},
            ),
            DetailOptionTile(
              width: width,
              text: "App Settings",
              contentPadding: const EdgeInsets.symmetric(vertical: 17),
              onTap: () {},
            ),
            DetailOptionTile(
              width: width,
              text: "Block & report spam",
              contentPadding: const EdgeInsets.symmetric(vertical: 17),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => CustomAlertDialog(convo: convo),
                );
              },
            ),
            SizedBox(height: 22),
            Text(
              "${convo.participants.length+1} PERSON",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),

            //Add people
            InkWell(
              onTap: () {},
              child: SizedBox(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Add people",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),

            //Sender tile
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: convo.isSpam
                            ? Colors.grey[200]
                            : convo.sender.avClr,
                        child: convo.sender.isAdded
                            ? Text(
                                convo.sender.name.substring(0, 1),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 20,
                              ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        convo.sender.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 5),

            //List of group members
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll){
                  overScroll.disallowGlow();
                  return false;
                },
                child: ListView(
                  children: convo.participants
                      .map(
                        (member) => InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                              width: width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: convo.isSpam
                                        ? Colors.grey[200]
                                        : convo.sender.avClr,
                                    child: convo.sender.isAdded
                                        ? Text(
                                            member.name.substring(0, 1),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19,
                                            ),
                                          )
                                        : Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    member.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailOptionTile extends StatelessWidget {
  const DetailOptionTile({
    Key key,
    @required this.width,
    @required this.contentPadding,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  final double width;
  final EdgeInsetsGeometry contentPadding;
  final text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: contentPadding,
        child: SizedBox(
          width: width,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    Key key,
    @required this.convo,
  }) : super(key: key);

  final Conversation convo;

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      titlePadding: const EdgeInsets.fromLTRB(24, 15, 24, 0),
      contentPadding: const EdgeInsets.fromLTRB(24, 13, 24, 10),
      actionsPadding: EdgeInsets.zero,
      title: Text(
        "Block & report spam",
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: SizedBox(
        height: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You won't receive calls or texts from ${widget.convo.sender.name}. This "
              "conversation will be moved to \"Spam & blocked.\"",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: isChecked,
                    onChanged: (val) => setState(() {
                      isChecked = !isChecked;
                    }),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2),
                      Text(
                        "Report spam",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          text:
                              "The spammer's number and recent texts go to Google and may go to your carrier (charges may apply).",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                          children: [
                            TextSpan(
                              text: " Learn more",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          color: Colors.white,
          child: Text(
            "CANCEL",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        FlatButton(
          color: Colors.white,
          child: Text(
            "OK",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            context.read<MessageManager>().toggleSpamConvo(widget.convo);
            Navigator.popUntil(context, (route) => route.settings.name == '/');
            Future.delayed(Duration(milliseconds: 300)).then(
              (value) => Utils.showFlushBar(
                context,
                "Conversation with ${widget.convo.sender.name} marked spam",
                Icons.block,
              ),
            );
          },
          splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }
}
