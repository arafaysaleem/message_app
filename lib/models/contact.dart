import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class Contact{
  final String _name,picturePath;
  final String number;
  final Color avClr;
  final bool isBlocked;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          number == other.number;

  @override
  int get hashCode => number.hashCode;

  Contact({@required this.avClr, this.isBlocked, name, this.picturePath, @required this.number}) : _name=name;

  String get name => _name?? "${number.substring(0, 4)} ${number.substring(4)}" ;

  bool get isAdded => _name!=null;

  @override
  String toString() {
    return 'Contact{_name: $_name, number: $number}';
  }
}