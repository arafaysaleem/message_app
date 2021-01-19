import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

import 'CustomRaisedButton.dart';
import 'OTPDigitInput.dart';

class OTPWidget extends StatefulWidget {
  @override
  _OTPWidgetState createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  List<String> otpDigits = ["0", "0", "0", "0", "0", "0"];
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Message app SVG

        //OTP Fields
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: formKey,
            child: Row(
              children: [
                //Digit 1
                Expanded(
                  child: OTPDigitInput(
                    onSaved: (digit1) => otpDigits[0] = digit1,
                  ),
                ),

                //Digit 2-6
                for (int i = 0; i < 5; i++) ...[
                  SizedBox(width: 5),
                  Expanded(
                    child: OTPDigitInput(
                      onSaved: (digit) => otpDigits[i + 1] = digit,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        SizedBox(height: 30),

        //Verify OTP button
        CustomRaisedButton(
          text: "Verify OTP",
          buttonColor: Colors.black,
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              String otpCode =
              otpDigits.fold("", (otp, digit) => "$otp$digit");
              authProvider.verifyOTP(otpCode);
            }
          },
          height: 40,
          width: 115,
        ),
      ],
    );
  }
}
