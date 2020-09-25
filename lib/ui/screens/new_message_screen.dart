import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/contacts_provider.dart';

import '../widgets/contacts_list.dart';
import '../widgets/new_message_appbar.dart';

// ignore: must_be_immutable
class NewMessageScreen extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: (){
          final contactProvider=context.read<ContactsProvider>();
          if(contactProvider.createGroupActive) {
            contactProvider.toggleCreateGroupMode();
            contactProvider.clearSelected();
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              NewMessageAppBar(textEditingController: _textEditingController),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 104,
                  child: ContactsList(textEditingController: _textEditingController,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
