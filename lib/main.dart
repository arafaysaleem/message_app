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

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Message Manager',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent[700],
        scaffoldBackgroundColor: Color(0xFFfefefe),
        fontFamily: "Roboto",
        iconTheme: IconThemeData(color: Colors.grey[800]),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: FirebaseInitializer.routeName,
      routes: {
        "/": (_) => HomeScreen(),
        FirebaseInitializer.routeName: (_) => FirebaseInitializer(),
        ArchivedMessagesScreen.routeName: (_) => ArchivedMessagesScreen(),
        SpamAndBlockedMessagesScreen.routeName: (_) =>
            SpamAndBlockedMessagesScreen(),
        SettingsScreen.routeName: (_) => SettingsScreen(),
        MessagesForWebScreen.routeName: (_) => MessagesForWebScreen(),
      },
    );
  }
}

class FirebaseInitializer extends StatelessWidget {
  static const routeName= "FirebaseInitialise";
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (ctx, snapshot) {

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
            create: (ctx) => MessageManager(FirestoreDatabase(uid: "Rafay123")),
            child: HomeScreen(),
          );
        }

        // Otherwise, show error/loading
        return Scaffold(
          body: Container(
            child: Center(
              child: snapshot.hasError
                  ? Text("Error loading firebase data")
                  : CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
