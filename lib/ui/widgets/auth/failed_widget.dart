import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

import '../../../helper/enums/auth_status_enum.dart';

import '../../../helper/utils.dart';

import 'custom_raised_button.dart';

class FailedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: Utils.linearGradient,
            ),
            height: double.infinity,
            width: double.infinity,
          ),

          //Failed SVG
          Positioned(
            top: 40,
            right: 0,
            left: 0,
            height: 250,
            child: Image.asset(Utils.failAsset),
          ),

          Positioned(
            top: 330,
            left: 0,
            right: 0,
            child: //OTP message
                Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Phone verification failed",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Positioned(
            top: 460,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRaisedButton(
                  text: "Retry",
                  buttonColor: Colors.black,
                  onPressed: () {
                    context
                        .read<AuthProvider>()
                        .changeAuthStatus(AuthStatus.LOGGED_OUT);
                  },
                  height: 45,
                  width: 145,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
