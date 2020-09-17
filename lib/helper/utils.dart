import 'dart:math';

import 'package:flutter/material.dart';

class Utils{
  static final greyColor=const Color(0xFFEEEEEE);
  static final myMessageColor= const Color(0xffE0ECFF);
  static final myMessageTextColor= Colors.blue[800];
  static final _randomGenerator=Random();
  static final List<Color> _avatarColors=[
    Colors.red,Colors.amber,Colors.purple,
    Colors.blue,Colors.pink,Colors.green[800]
  ];

  static Color getAvatarColor(){
    Color avClr = _avatarColors[_randomGenerator.nextInt(_avatarColors.length)];
    return avClr;
  }
}