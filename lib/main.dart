import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';

import 'ui/screens/spam_blocked_msg_screen.dart';
import 'ui/screens/auth_screen.dart';
import 'ui/screens/archived_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/settings_screen.dart';
import 'ui/screens/web_message_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return MultiProvider(
      providers: [
        //TODO: Put these after AuthScreen but before HomeScreen
        // ChangeNotifierProvider(
        //   create: (ctx) => MessageManager(),
        // ),
        // ChangeNotifierProxyProvider<MessageManager, ContactsProvider>(
        //   create: (_) => ContactsProvider(),
        //   update: (_, msgMgr, contactsProvider) =>
        //       contactsProvider..update(msgMgr),
        // ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        )
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Message Manager',
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent[700],
          scaffoldBackgroundColor: Color(0xFFfefefe),
          fontFamily: "Roboto",
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.grey[800]),
          ),
          iconTheme: IconThemeData(color: Colors.grey[800]),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          "/": (_) => AuthScreen(),
          HomeScreen.routeName: (_) => HomeScreen(),
          ArchivedMessagesScreen.routeName: (_) => ArchivedMessagesScreen(),
          SpamBlockedMessagesScreen.routeName: (_) =>
              SpamBlockedMessagesScreen(),
          SettingsScreen.routeName: (_) => SettingsScreen(),
          MessagesForWebScreen.routeName: (_) => MessagesForWebScreen(),
        },
      ),
    );
  }
}
