import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../providers/messages_provider.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_fab.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/conversations_list.dart';


// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _controller = ScrollController();

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            CustomScrollView(
              controller: _controller,
              slivers: [
                Selector<MessageManager, int>(
                  selector: (ctx, msgMgr) => msgMgr.selectedConversations.length,
                  builder: (ctx, int length, child) =>  CustomAppBar(
                      length: length,
                      child: child,
                      duration: Duration(milliseconds: 300),
                  ),
                  child: DefaultAppBar(),
                ),
                ConversationsList(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10,right: 5),
        child: CustomFAB(
          controller: _controller,
        ),
      ),
    );
  }
}
