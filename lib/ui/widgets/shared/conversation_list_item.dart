import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/messages_provider.dart';

import '../../../models/conversation.dart';

import '../../screens/message_screen.dart';

// ignore: must_be_immutable
class ConversationListItem extends StatelessWidget {
  Conversation convo;
  MessagesProvider msgManager;

  Widget getProfilePicture() {
    return Selector<MessagesProvider, int>(
      selector: (ctx, msgManager) => msgManager.selectedConversations.length,
      builder: (BuildContext context, _, child) {
        if (msgManager.isSelected(convo))
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
        backgroundColor: convo.isSpam ? Colors.grey[200] : convo.sender.avClr,
        child: convo.isSpam
            ? Container(
                margin: EdgeInsets.all(2),
                child: Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                ),
              )
            : convo.sender.isAdded
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
    );
  }

  Widget getMessageBody() {
    String message = convo.latestMessage.body;
    bool myMessage = convo.latestMessage.isMyMessage;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 1, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            convo.sender.name,
            style: convo.isRead
                ? TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[700],
                    fontSize: 16,
                  )
                : TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16,
                  ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            myMessage? "You: $message" : message,
            style: convo.isRead
                ? TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[700],
                    fontSize: 14,
                  )
                : TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14,
                  ),
            maxLines: convo.isRead ? 1 : 3,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget getDate() {
    final msg = convo.latestMessage;
    final msgDaysAgo = DateTime.now().difference(msg.datetime).inDays;
    return Text(
      msgDaysAgo == 0
          ? DateFormat('h:mm a').format(msg.datetime)
          : msgDaysAgo > 0 && msgDaysAgo <= 6
              ? DateFormat(DateFormat.ABBR_WEEKDAY).format(msg.datetime)
              : msgDaysAgo > 6 && msgDaysAgo <= 365
                  ? DateFormat("MMM dd").format(msg.datetime)
                  : DateFormat("dd/MM/yy").format(msg.datetime),
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    msgManager = Provider.of<MessagesProvider>(context, listen: false);
    convo = Provider.of<Conversation>(context);
    return InkWell(
      splashColor: Colors.grey[300],
      highlightColor: Colors.transparent,
      onTap: () {
        if (msgManager.selectedConversations.length >= 1) {
          msgManager.toggleSelected(convo);
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ChangeNotifierProvider.value(
                value: convo,
                child: MessageScreen(),
              ),
            ),
          );
          msgManager.readConversation(convo);
        }
      },
      onLongPress: () {
        msgManager.toggleSelected(convo);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //picture
            getProfilePicture(),

            //body
            Expanded(child: getMessageBody()),

            //msg Datetime
            getDate()
          ],
        ),
      ),
    );
  }
}
