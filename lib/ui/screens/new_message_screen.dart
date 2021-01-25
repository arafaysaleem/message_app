import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/contacts_provider.dart';

import '../widgets/shared/contacts_list.dart';
import '../widgets/new_message_appbar.dart';

// ignore: must_be_immutable
class NewMessageScreen extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();

  //TODO: Add support for sending message to other firebase user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          final contactProvider = context.read<ContactsProvider>();
          if (contactProvider.createGroupActive) {
            contactProvider.toggleCreateGroupMode();
            contactProvider.clearSelected();
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowGlow();
              return false;
            },
            child: CustomScrollView(
              slivers: [
                NewMessageAppBar(textEditingController: _textEditingController),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 129,
                    child: ContactsList(
                      textEditingController: _textEditingController,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
