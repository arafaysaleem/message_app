import 'package:flutter/foundation.dart';

class Message{
  final String number;
  final String body;
  final DateTime datetime;
  final String previewPath; //for any image or website preview

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          number == other.number &&
          body == other.body;

  @override
  int get hashCode => number.hashCode ^ body.hashCode;
  bool isFav=false;

  Message({@required this.number, @required this.body,@required this.datetime, this.previewPath});

  bool get hasPreview => previewPath != null;
}