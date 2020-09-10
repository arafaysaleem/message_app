import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/messages_provider.dart';

import 'ui/screens/spam_blocked_msg_screen.dart';
import 'ui/screens/archived_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/settings_screen.dart';
import 'ui/screens/web_message_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MessageManager(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Message Manager',
        theme: ThemeData(
          primaryColor: Colors.indigoAccent[700],
          scaffoldBackgroundColor: Color(0xFFfefefe),
          fontFamily: "Roboto",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          "/": (ctx) => HomeScreen(),
          ArchivedMessagesScreen.routeName: (ctx) => ArchivedMessagesScreen(),
          SpamAndBlockedMessagesScreen.routeName: (ctx) => SpamAndBlockedMessagesScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          MessagesForWebScreen.routeName: (ctx) => MessagesForWebScreen(),
        },
      ),
    );
  }
}
