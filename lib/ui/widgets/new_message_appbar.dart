import 'package:flutter/material.dart';

class NewMessageAppBar extends StatefulWidget {
  final TextEditingController textEditingController;

  const NewMessageAppBar({Key key, this.textEditingController})
      : super(key: key);

  @override
  _NewMessageAppBarState createState() => _NewMessageAppBarState();
}

class _NewMessageAppBarState extends State<NewMessageAppBar> {
  double _splashRadius;
  FocusNode _focusNode;
  bool isDialPad=false;

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

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: false,
      collapsedHeight: 104,
      elevation: 3,
      shadowColor: Colors.grey[50],
      backgroundColor: Colors.white,
      forceElevated: true,
      flexibleSpace: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 4),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  splashRadius: _splashRadius,
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 7),
                Text(
                  "New Conversation",
                  style: TextStyle(fontSize: 17, fontFamily: "Poppins"),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 2),
              child: Row(
                children: [
                  Text(
                    "To",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(width: 33),
                  Expanded(
                    child: TextField(
                      focusNode: _focusNode,
                      cursorColor: Theme.of(context).primaryColor,
                      textInputAction: TextInputAction.search,
                      keyboardType: isDialPad
                          ? TextInputType.number
                          : TextInputType.emailAddress,
                      decoration: InputDecoration.collapsed(
                          hintText: "Type a name, phone number, or email",
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey[700])),
                      controller: widget.textEditingController,
                    ),
                  ),
                  IconButton(
                    onPressed: toggleKeyboardType,
                    splashRadius: _splashRadius,
                    icon: Icon(
                      isDialPad ? Icons.dialpad:Icons.keyboard,
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
