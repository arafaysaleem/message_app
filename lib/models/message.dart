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

  Message({@required this.number, @required this.body,@required this.datetime, this.previewPath, bool isFav});

  bool get hasPreview => previewPath != null;

  factory Message.fromMap(Map<String, dynamic> map) {
    return new Message(
      number: map['number'] as String,
      body: map['body'] as String,
      datetime: map['datetime'].toDate() as DateTime,
      previewPath: map['previewPath'] as String,
      isFav: map['isFav'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'number': this.number,
      'body': this.body,
      'datetime': this.datetime,
      'previewPath': this.previewPath,
      'isFav': this.isFav,
    } as Map<String, dynamic>;
  }
}