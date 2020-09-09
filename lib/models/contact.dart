import 'package:flutter/foundation.dart';

class Contact{
  final String _name,picturePath;
  final int number;
  final bool isBlocked;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          number == other.number;

  @override
  int get hashCode => number.hashCode;

  Contact({this.isBlocked, name, this.picturePath, @required this.number}) : _name=name;

  String get name => _name??number.toString();

  bool get isAdded => _name!=null;

  @override
  String toString() {
    return 'Contact{_name: $_name, number: $number}';
  }
}