import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final text;
  final buttonColor;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final Widget child;

  const CustomRaisedButton({
    Key key,
    @required this.text,
    @required this.buttonColor,
    @required this.onPressed,
    @required this.height,
    @required this.width,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: buttonColor,
        child: child ?? Text(
          text,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
