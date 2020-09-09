import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/messages_provider.dart';

import 'ui/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Message Manager',
      theme: ThemeData(
        primaryColor: Colors.indigoAccent[700],
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Lato",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (ctx) => MessageManager(),
        child: HomeScreen(),
      ),
    );
  }
}
