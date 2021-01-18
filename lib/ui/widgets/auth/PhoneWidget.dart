import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../providers/auth_provider.dart';

import '../../../helper/utils.dart';

import 'ErrorDialog.dart';

class PhoneWidget extends StatefulWidget {
  @override
  _PhoneWidgetState createState() => _PhoneWidgetState();
}

class _PhoneWidgetState extends State<PhoneWidget> {
  final TextEditingController _phoneNoController = TextEditingController();
  final SmsAutoFill _autoFill = SmsAutoFill();

  OutlineInputBorder buildUnfocusedBorder(double radius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: Colors.grey[400],
        width: 1.4,
        style: BorderStyle.solid,
      ),
    );
  }

  OutlineInputBorder buildFocusedBorder(double radius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.4,
        style: BorderStyle.solid,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final fontFamily = "Poppins";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Message app SVG

        //Phone number row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              //Input
              Expanded(
                child: TextField(
                  controller: _phoneNoController,
                  style: TextStyle(fontFamily: fontFamily),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 2, 10),
                    hintText: "Phone# (+xx xxxxxxxxx)",
                    hintStyle: TextStyle(color: Colors.grey, fontFamily: fontFamily),
                    enabledBorder: buildUnfocusedBorder(40),
                    focusedBorder: buildFocusedBorder(40),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 15),

              //Autofill button
              SizedBox(
                height: 47,
                width: 85,
                child: RaisedButton(
                  onPressed: () async => {
                    _phoneNoController.text = await _autoFill.hint
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Autofill",
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),

        SizedBox(height: 30),

        //Send OTP button
        SizedBox(
          height: 45,
          width: 105,
          child: RaisedButton(
            onPressed: () {
              final phoneNumber = _phoneNoController.text.trim();
              if (phoneNumber.isNotEmpty && Utils.phoneNoRegex.hasMatch(phoneNumber)) {
                authProvider.verifyPhoneForOTP(phoneNumber);
              } else {
                showDialog(
                  context: context,
                  builder: (_) => ErrorDialog(),
                );
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.black,
            child: Text(
              "Send OTP",
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}