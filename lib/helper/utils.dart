import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class Utils {
  ///Grey color used in the app theme
  static final greyColor = const Color(0xFFEEEEEE);

  ///Color used to represent my messages' background
  static final myMessageColor = const Color(0xffE0ECFF);

  ///Color used to represent my messages' text
  static final myMessageTextColor = Colors.blue[800];

  ///Instance of random number generator
  static final _randomGenerator = Random();

  ///Getter for phone asset
  static final phoneAsset = "assets/phone.png";

  ///Getter for otp asset
  static final otpAsset = "assets/otp.png";

  ///Getter for failed asset
  static final failAsset = "assets/fail.png";

  ///Getter for success asset
  static final successAsset = "assets/success.png";

  ///Getter for auth user key name
  static final authUserKey = "uid";

  ///Getter for auth status key name
  static final authStatusKey = "status";

  static LinearGradient get linearGradient => const LinearGradient(
    colors: [
      const Color(0xFF0091EA),
      const Color(0xFF00AFF5),
    ],
    begin: const FractionalOffset(0.0, 0.0),
    end: const FractionalOffset(0.0, 1.0),
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp,
  );


  ///Regex for name
  static final RegExp nameRegex = RegExp('[a-z A-Z0-9]');

  ///Regex for phone no
  static final RegExp phoneNoRegex = RegExp('[+]{1}[0-9]');

  ///Regex for number
  static final RegExp numberRegex = RegExp('[0-9]');

  ///Rege for OTP
  static final RegExp otpRegex = RegExp('[0-9]{1}');

  ///Internal list of avatar colors
  static final List<Color> _avatarColors = [
    Colors.red,
    Colors.amber,
    Colors.purple,
    Colors.blue,
    Colors.pink,
    Colors.green[800]
  ];

  ///Returns a random avatar color
  static Color getAvatarColor() {
    Color avClr = _avatarColors[_randomGenerator.nextInt(_avatarColors.length)];
    return avClr;
  }

  ///Checks if a phone number is valid
  static bool isPhoneNumber(String number){
    if(phoneNoRegex.hasMatch(number) && number.length == 13) return true;
    return number.length == 11; //&& number.startsWith("03");
  }

  ///Parses a phone number to add country code in beginning
  static String parsePhoneNo(String number){
    if(phoneNoRegex.hasMatch(number)) return number;
    return "+92${number.substring(1)}";
  }

  ///Helper method to show toast message
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

  ///Helper method to launch URL
  static launchURL(String url) async {
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///Returns a list of split message components,
  ///Used to parse a message containing a URl to split URL from other parts
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

  ///Fetches the URl from a message if it contains any
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
