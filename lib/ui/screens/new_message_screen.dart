import 'package:flutter/material.dart';
import 'package:message_app/ui/widgets/new_message_appbar.dart';

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
            // SliverToBoxAdapter(
            //   child: GestureDetector(
            //     onTap: () => FocusScope.of(context).unfocus(),
            //     child: Container(),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height-104,
                child: ListView.separated(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: 50,
                  separatorBuilder: (ctx,i) => SizedBox(height: 10,),
                  itemBuilder: (ctx,i) => Container(
                    height: 10,
                    color: Colors.blue,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
