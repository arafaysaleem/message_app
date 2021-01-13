import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class Contact{
  String _name,picturePath;
  final String number;
  final Color avClr;
  bool isBlocked;

  factory Contact.fromMap(Map<String, dynamic> map) {
    return new Contact(
      name: map['name'] as String,
      picturePath: map['picturePath'] as String,
      number: map['number'] as String,
      avClr: Color(int.tryParse(map['avClr'])),
      isBlocked: map['isBlocked'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this._name,
      'picturePath': this.picturePath,
      'number': this.number,
      'avClr': '0x${this.avClr.value.toRadixString(16).padLeft(8, '0')}',
      'isBlocked': this.isBlocked,
    } as Map<String, dynamic>;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          number == other.number;

  @override
  int get hashCode => number.hashCode;

  Contact({@required this.avClr, this.isBlocked = false, name, this.picturePath, @required this.number}) : _name=name;

  String get name => _name?? "${number.substring(0, 4)} ${number.substring(4)}" ;

  bool get isAdded => _name!=null;

  void setName(String name) => _name = name;

  @override
  String toString() {
    return 'Contact{_name: $_name, number: $number}';
  }
}