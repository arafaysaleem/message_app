import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/messages_provider.dart';

import 'ui/screens/spam_blocked_msg_screen.dart';
import 'ui/screens/archived_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/settings_screen.dart';
import 'ui/screens/web_message_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark
  ));
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
          "/": (_) => HomeScreen(),
          ArchivedMessagesScreen.routeName: (_) => ArchivedMessagesScreen(),
          SpamAndBlockedMessagesScreen.routeName: (_) => SpamAndBlockedMessagesScreen(),
          SettingsScreen.routeName: (_) => SettingsScreen(),
          MessagesForWebScreen.routeName: (_) => MessagesForWebScreen(),
        },
      ),
    );
  }
}
