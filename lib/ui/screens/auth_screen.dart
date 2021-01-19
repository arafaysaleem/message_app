import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../../helper/enums/auth_status_enum.dart';

import '../widgets/auth/logged_in_widget.dart';
import '../widgets/auth/otp_widget.dart';
import '../widgets/auth/phone_widget.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            "Login Screen",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
              fontSize: 24,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Selector<AuthProvider, AuthStatus>(
            selector: (_, authProvider) => authProvider.status,
            builder: (_, status, __) {
              if (status == AuthStatus.LOGGED_IN) {
                return LoggedInWidget();
              }
              else if (status == AuthStatus.AUTHENTICATING) {
                return CircularProgressIndicator();
              }
              else if (status == AuthStatus.UNAUTHENTICATED) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PhoneWidget(),
                    SizedBox(height: 30),
                    Text(
                      "Phone Verification Failed",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Poppins",
                        color: Colors.red,
                      ),
                    ),
                  ],
                );
              }
              else if (status == AuthStatus.OTP_SENT) {
                return OTPWidget();
              }
              return PhoneWidget();
            },
          ),
        ),
      ),
    );
  }
}
