import 'package:flutter/material.dart';

import 'package:message_app/ui/widgets/contacts_list.dart';

import '../widgets/new_message_appbar.dart';

// ignore: must_be_immutable
class NewMessageScreen extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
    );
  }
}
