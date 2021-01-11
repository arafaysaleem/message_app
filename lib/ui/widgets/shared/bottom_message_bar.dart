import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/messages_provider.dart';

import '../../../helper/utils.dart';

import '../../../models/conversation.dart';

class BottomMessageBar extends StatefulWidget {
  final ScrollController sController;

  BottomMessageBar({Key key, this.sController}) : super(key: key);

  @override
  _BottomMessageBarState createState() => _BottomMessageBarState();
}

class _BottomMessageBarState extends State<BottomMessageBar> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  void sendMessage(Conversation convo, BuildContext context) {
    setState(() {
      final msgMgr = context.read<MessageManager>();
      String msg = _textEditingController.text.trim();
      String path = Utils.extractUrl(msg);
      msgMgr.sendConversationMessages(convo: convo, text: msg, previewPath: path);
      _textEditingController.clear();
      widget.sController.jumpTo(widget.sController.position.maxScrollExtent);
      if (convo.isArchived) msgMgr.toggleArchiveConvo(convo);
      msgMgr.updateConversionList(convo);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  onChanged(String msg) {
    if (msg.trim().length < 2) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final convo = Provider.of<Conversation>(context, listen: false);
    return Container(
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
                onChanged: onChanged,
                keyboardType: TextInputType.multiline,
                controller: _textEditingController,
                cursorColor: Theme.of(context).primaryColor,
                maxLines: null,
                textInputAction: TextInputAction.send,
                onSubmitted: (String msg) {
                  if (msg.isEmpty) return;
                  sendMessage(convo, context);
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
                      child: _textEditingController.text.isEmpty
                          ? InkWell(
                              child: Icon(
                                Icons.person_add,
                                color: Theme.of(context).primaryColor,
                                size: 28,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                sendMessage(convo, context);
                                FocusScope.of(context).unfocus();
                              },
                              child: Icon(
                                Icons.send,
                                color: Theme.of(context).primaryColor,
                                size: 28,
                              ),
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
    );
  }
}
