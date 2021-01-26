import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class Utils {
  static final greyColor = const Color(0xFFEEEEEE);
  static final myMessageColor = const Color(0xffE0ECFF);
  static final myMessageTextColor = Colors.blue[800];
  static final _randomGenerator = Random();
  static final authUserKey = "uid";
  static final authStatusKey = "status";
  static final RegExp nameRegex = RegExp('[a-z A-Z0-9]');
  static final RegExp phoneNoRegex = RegExp('[+]{1}[0-9]');
  static final RegExp numberRegex = RegExp('[0-9]');
  static final RegExp otpRegex = RegExp('[0-9]{1}');
  static final List<Color> _avatarColors = [
    Colors.red,
    Colors.amber,
    Colors.purple,
    Colors.blue,
    Colors.pink,
    Colors.green[800]
  ];

  static Color getAvatarColor() {
    Color avClr = _avatarColors[_randomGenerator.nextInt(_avatarColors.length)];
    return avClr;
  }

  static bool isPhoneNumber(String number){
    if(phoneNoRegex.hasMatch(number) && number.length == 13) return true;
    return number.length == 11; //&& number.startsWith("03");
  }

  static String parsePhoneNo(String number){
    if(phoneNoRegex.hasMatch(number)) return number;
    return "+92${number.substring(1)}";
  }

  static void showFlushBar(context, String message, IconData icon) {
    Flushbar(
      messageText: Text(
        message,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: 7,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      icon: Icon(
        icon,
        size: 28.0,
        color: Theme.of(context).primaryColor,
      ),
      shouldIconPulse: false,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  static launchURL(String url) async {
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static List<String> splitMessageComponents(String message) {
    List<String> list = [];
    var elements = linkify(
      message,
      options: LinkifyOptions(
        humanize: false,
      ),
    );
    for (var e in elements) {
      if (e is TextElement) {
        list.add(e.text);
      }
      if (e is LinkableElement){
        list.add('\$url\$');
      }
    }
    return list;
  }

  static String extractUrl(String input) {
    var elements = linkify(
      input,
      options: LinkifyOptions(
        humanize: false,
      ),
    );
    for (var e in elements) {
      if (e is LinkableElement) {
        return e.url;
      }
    }
    return null;
  }
}
