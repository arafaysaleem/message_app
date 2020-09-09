import 'package:flutter/material.dart';

class Utils{
  static int _avatarIndex=0;
  static final greyColor=const Color(0xFFEEEEEE);
  static final myMessageColor= const Color(0xffE0ECFF);
  static final myMessageTextColor= Colors.blue[800];
  static final List<Color> _avatarColors=[
    Colors.red,Colors.amber,Colors.purple,
    Colors.blue,Colors.pink,Colors.green[800]
  ];

  static Color getAvatarColor(){
    Color avClr = _avatarColors[_avatarIndex % _avatarColors.length];
    _avatarIndex++;
    return avClr;
  }
}