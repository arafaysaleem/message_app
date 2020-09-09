import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../helper/utils.dart';

import '../../models/conversation.dart';
import '../../models/message.dart';

class MessageScreen extends StatefulWidget {
  final Color avClr;

  const MessageScreen({Key key, @required contact, @required this.avClr})
      : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final double _splashRadius = 21;
  bool keyboardActive;
  ScrollController _sController;
  FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _sController = ScrollController();
    _textEditingController = TextEditingController();
    keyboardActive = false;
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _sController.jumpTo(_sController.position.maxScrollExtent));
  }

  void disableKeyboard() {
    setState(() {
      keyboardActive = false;
      _focusNode.unfocus();
    });
  }

  void sendMessage(convo) {
    setState(() {
      convo.sendMessage(text: _textEditingController.text.trim());
      _textEditingController.clear();
      _sController.jumpTo(_sController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _sController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final convo = Provider.of<Conversation>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white.withOpacity(0.9),
        leading: IconButton(
          splashRadius: _splashRadius,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Text(
          convo.sender.name,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          if (!convo.isSpam)
            IconButton(
              splashRadius: _splashRadius,
              onPressed: () {},
              icon: Icon(Icons.call),
            ),
          IconButton(
            splashRadius: _splashRadius,
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            splashRadius: _splashRadius,
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Stack(
        children: [
          //MessagesList
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: disableKeyboard,
              child: Scrollbar(
                isAlwaysShown: true,
                controller: _sController,
                child: ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: _sController,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: convo.messages.length,
                  itemBuilder: (ctx, i) {
                    bool myMsg = false;
                    if (Conversation.myContact.number == convo.messages[i].number)
                      myMsg = true;
                    if (i == convo.messages.length - 1)
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: MessageListItem(
                          isSpam: convo.isSpam,
                          contact: convo.sender,
                          msg: convo.messages[i],
                          avClr: widget.avClr,
                          myMessage: myMsg,
                        ),
                      );
                    return MessageListItem(
                      isSpam: convo.isSpam,
                      contact: convo.sender,
                      msg: convo.messages[i],
                      avClr: widget.avClr,
                      myMessage: myMsg,
                    );
                  },
                ),
              ),
            ),
          ),

          //Bottom Text Input Bar
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white.withOpacity(0.95),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  IconButton(
                    constraints: BoxConstraints(
                      maxWidth: 60,
                    ),
                    icon: Icon(
                      Icons.add_circle,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    constraints: BoxConstraints(
                      maxWidth: 60,
                    ),
                    padding: const EdgeInsets.fromLTRB(2, 8, 12, 8),
                    icon: Icon(
                      Icons.add_photo_alternate,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: TextField(
                        controller: _textEditingController,
                        cursorColor: Theme.of(context).primaryColor,
                        focusNode: _focusNode,
                        maxLines: null,
                        textInputAction: TextInputAction.send,
                        onTap: () {
                          setState(() {
                            keyboardActive = true;
                          });
                        },
                        onSubmitted: (String msg) {
                          if(msg.isEmpty) return;
                          sendMessage(convo);
                          //TODO: add regex check for any urls to show preview and it as a path
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(16),
                          hintText: "Text Message",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide(
                              color: Colors.grey[300],
                              width: 1.4,
                              style: BorderStyle.solid,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide(
                              color: Utils.greyColor,
                              width: 1.4,
                              style: BorderStyle.solid,
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.person_add,
                                color: Theme.of(context).primaryColor,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    constraints: BoxConstraints(maxWidth: 60),
                    padding: const EdgeInsets.fromLTRB(2, 8, 12, 8),
                    icon: Icon(
                      Icons.mic,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageListItem extends StatefulWidget {
  final isSpam, contact;
  final Message msg;
  final Color avClr;
  final bool myMessage;

  const MessageListItem({
    Key key,
    @required this.isSpam,
    @required this.avClr,
    @required this.contact,
    @required this.msg,
    @required this.myMessage,
  }) : super(key: key);

  @override
  _MessageListItemState createState() => _MessageListItemState();
}

class _MessageListItemState extends State<MessageListItem> with SingleTickerProviderStateMixin{
  bool showDate=false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: !widget.myMessage
          ? const EdgeInsets.fromLTRB(8, 0, 30, 0)
          : const EdgeInsets.fromLTRB(30, 0, 8, 0),
      child: Column(
        crossAxisAlignment: widget.myMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment:
                !widget.myMessage ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              if (!widget.myMessage)
                widget.isSpam
                    ? Icon(
                        Icons.block,
                        color: Colors.grey[700],
                      )
                    : CircleAvatar(
                        radius: 18.5,
                        backgroundColor: widget.avClr,
                        child: widget.contact.isAdded
                            ? Text(
                                widget.contact.name.substring(0, 1),
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
              SizedBox(width: 8),
              widget.msg.hasPreview ? getPreviewMessage() : getTextMessage(),
            ],
          ),
          Padding(
            padding: widget.myMessage ? const EdgeInsets.only(top: 3,right: 10) : const EdgeInsets.only(top: 3,left: 55),
            child: AnimatedSize(vsync: this,curve: Curves.decelerate,duration: Duration(milliseconds: 200),child: showDate ? getDate(convoDate: false) : SizedBox.shrink()),
          ),
        ],
      ),
    );
  }

  getPreviewMessage() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getDate(convoDate: true),
          SizedBox(height: 7),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: (){
              setState(() {
                showDate=!showDate;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.myMessage ? Utils.myMessageColor : Utils.greyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Text(
                    widget.msg.body,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.3,
                      color: widget.myMessage
                          ? Utils.myMessageTextColor
                          : Colors.grey[900],
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            splashColor: Colors.grey[100],
            highlightColor: Colors.grey[100],
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                border: Border.all(
                  color: Utils.greyColor,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.refresh),
                    SizedBox(height: 5),
                    Text(
                      "Tap to load preview",
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getTextMessage() {
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getDate(convoDate: true),
          SizedBox(height: 7),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: (){
              setState(() {
                showDate=!showDate;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.myMessage ? Utils.myMessageColor : Utils.greyColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  widget.msg.body,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.3,
                    color: widget.myMessage
                        ? Utils.myMessageTextColor
                        : Colors.grey[900],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getDate({@required bool convoDate}) {
    final msgDaysAgo = DateTime.now().difference(widget.msg.datetime).inDays;
    String date='';
    if(convoDate){
      if(msgDaysAgo == 0) return SizedBox.shrink();
      else if(msgDaysAgo > 0 && msgDaysAgo <= 6) date = DateFormat(DateFormat.ABBR_WEEKDAY).format(widget.msg.datetime);
      else if(msgDaysAgo > 6 && msgDaysAgo <= 365) date = DateFormat("MMM dd").format(widget.msg.datetime);
      else date = DateFormat("dd/MM/yy").format(widget.msg.datetime);
      return Padding(
        padding: const EdgeInsets.fromLTRB(0,14,0,10),
        child: Text(
          date + " - " + DateFormat('h:mm a').format(widget.msg.datetime),
          style: TextStyle(
            fontSize: 11,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    else{
      if(msgDaysAgo > 0 && msgDaysAgo <= 6) date = DateFormat(DateFormat.ABBR_WEEKDAY).format(widget.msg.datetime) + " - ";
      else if(msgDaysAgo > 6 && msgDaysAgo <= 365) date = DateFormat("MMM dd").format(widget.msg.datetime) + " - ";
      else if(msgDaysAgo > 365) date = DateFormat("dd/MM/yy").format(widget.msg.datetime) + " - ";
      return Text(
        date + DateFormat('h:mm a').format(widget.msg.datetime),
        style: TextStyle(
          fontSize: 11,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }
}
