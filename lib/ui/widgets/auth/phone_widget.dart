import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../providers/auth_provider.dart';

import '../../../helper/utils.dart';

import 'custom_raised_button.dart';
import 'error_dialog.dart';

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
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            //Message app SVG
            Container(
              color: Theme.of(context).primaryColor,
              height: 360,
              width: double.infinity,
            ),

            //Title
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Phone Verification",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            ),

            //Image
            Positioned(
              top: 75,
              right: 0,
              left: 0,
              height: 250,
              child: Image.asset(Utils.phoneAsset),
            ),

            //Input
            Positioned(
              top: 410,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  //OTP message
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "We will send you one time pass (OTP)",
                      style: TextStyle(
                        fontSize: 16.7,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 25),

                  //Phone number row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 0, 10),
                              hintText: "Enter phone number",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: fontFamily,
                                fontSize: 15
                              ),
                              enabledBorder: buildUnfocusedBorder(8),
                              focusedBorder: buildFocusedBorder(8),
                              prefixIconConstraints: BoxConstraints(
                                minHeight: 33,
                                minWidth: 38,
                              ),
                              prefixIcon: Icon(
                                Icons.phone,
                                size: 22,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 15),

                        //Autofill button
                        CustomRaisedButton(
                          text: "Autofill",
                          buttonColor: Theme.of(context).primaryColor,
                          onPressed: () async {
                            _phoneNoController.text = await _autoFill.hint;
                          },
                          height: 45,
                          width: 90,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  Text(
                    "Carrier charges may apply",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),

                  SizedBox(height: 25),

                  //Send OTP button
                  CustomRaisedButton(
                    text: "Send OTP",
                    buttonColor: Colors.black,
                    onPressed: () {
                      final phoneNumber = _phoneNoController.text.trim();
                      if (phoneNumber.isNotEmpty &&
                          Utils.phoneNoRegex.hasMatch(phoneNumber)) {
                        authProvider.verifyPhoneForOTP(phoneNumber);
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => ErrorDialog(),
                        );
                      }
                    },
                    height: 45,
                    width: 125,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
