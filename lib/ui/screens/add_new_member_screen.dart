import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/contacts_provider.dart';

import '../widgets/contacts_list.dart';
import '../widgets/add_member_appbar.dart';

// ignore: must_be_immutable
class AddNewMemberScreen extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactsProvider>(context,listen: false);
    contactProvider.setAddMemberMode(true);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          if (contactProvider.selectedContacts.isNotEmpty) {
            contactProvider.setAddMemberMode(false);
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
                AddMemberAppBar(textEditingController: _textEditingController),
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
