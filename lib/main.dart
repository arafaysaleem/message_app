import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'providers/messages_provider.dart';

import 'services/firestore_database.dart';

import 'ui/screens/spam_blocked_msg_screen.dart';
import 'ui/screens/archived_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/settings_screen.dart';
import 'ui/screens/web_message_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //TODO: Add firebase auth, get uid from authUser
      create: (ctx) => MessageManager(firestoredb: FirestoreDatabase(uid: "Rafay123")),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Message Manager',
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent[700],
          scaffoldBackgroundColor: Color(0xFFfefefe),
          fontFamily: "Roboto",
          iconTheme: IconThemeData(color: Colors.grey[800]),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          //TODO: Change to enum of page type
          "/": (_) => HomeScreen(),
          ArchivedMessagesScreen.routeName: (_) => ArchivedMessagesScreen(),
          SpamAndBlockedMessagesScreen.routeName: (_) =>
              SpamAndBlockedMessagesScreen(),
          SettingsScreen.routeName: (_) => SettingsScreen(),
          MessagesForWebScreen.routeName: (_) => MessagesForWebScreen(),
        },
      ),
    );
  }
}
