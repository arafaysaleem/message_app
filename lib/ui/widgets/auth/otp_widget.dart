import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

import '../../../helper/enums/auth_status_enum.dart';

import '../../../helper/utils.dart';

import 'custom_raised_button.dart';
import 'otp_digit_input.dart';

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

            //Title Row
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: (){
                      context.read<AuthProvider>().changeAuthStatus(AuthStatus.LOGGED_OUT);
                    },
                    icon: Icon(Icons.arrow_back,size: 26,color: Colors.white,),
                  ),

                  SizedBox(width: 45),

                  Text(
                    "OTP Verification",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: fontFamily,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),

            //Image
            Positioned(
              top: 75,
              right: 0,
              left: 0,
              height: 250,
              child: Image.asset(Utils.otpAsset),
            ),

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
                      "We have sent an OTP on your number",
                      style: TextStyle(
                        fontSize: 16.7,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 30),

                  //OTP Fields
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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

                  //OTP message
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive an OTP?",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: (){
                            final authProvider = context.read<AuthProvider>();
                            authProvider.verifyPhoneForOTP(authProvider.userNumber);
                          },
                          child: Text(
                            "Resend OTP",
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
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
                    height: 45,
                    width: 145,
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
