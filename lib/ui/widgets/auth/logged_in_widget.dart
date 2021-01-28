import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/contacts_provider.dart';
import '../../../providers/messages_provider.dart';

import '../../screens/home_screen.dart';

import 'custom_raised_button.dart';

class LoggedInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Successfully logged in",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
            color: Colors.black,
          ),
        ),

        SizedBox(height: 20),

        //View Messages Button
        CustomRaisedButton(
          buttonColor: Theme.of(context).primaryColor,
          onPressed: () {
            context.read<MessagesProvider>().init();
            context.read<ContactsProvider>().init();
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          },
          height: 45,
          width: 190,
          text: "",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "View messages",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),

              SizedBox(width: 12),

              Icon(Icons.arrow_forward,color: Colors.white,size: 22,)
            ],
          ),
        ),
      ],
    );
  }
}
