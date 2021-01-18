import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../../helper/enums/auth_status_enum.dart';

import 'home_screen.dart';

import '../widgets/auth/OTPWidget.dart';
import '../widgets/auth/PhoneWidget.dart';

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
                return Text("LOGGED IN UID: ${context.read<AuthProvider>().userNumber}");
                // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              } else if (status == AuthStatus.AUTHENTICATING) {
                return CircularProgressIndicator();
              } else if (status == AuthStatus.UNAUTHENTICATED) {
                return Text("Failed");
              } else if (status == AuthStatus.OTP_SENT) {
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


