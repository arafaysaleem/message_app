import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../../helper/enums/auth_status_enum.dart';

import '../widgets/auth/custom_wave_indicator.dart';
import '../widgets/auth/failed_widget.dart';
import '../widgets/auth/success_widget.dart';
import '../widgets/auth/otp_widget.dart';
import '../widgets/auth/phone_widget.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Theme.of(context).primaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          child: SafeArea(
            child: Selector<AuthProvider, AuthStatus>(
              selector: (_, authProvider) => authProvider.status,
              builder: (_, status, __) {
                if (status == AuthStatus.LOGGED_IN) {
                  return SuccessWidget();
                }
                else if (status == AuthStatus.AUTHENTICATING) {
                  return CustomWaveIndicator();
                }
                else if (status == AuthStatus.UNAUTHENTICATED) {
                  return FailedWidget();
                }
                else if (status == AuthStatus.OTP_SENT) {
                  return OTPWidget();
                }
                return PhoneWidget();
              },
            ),
          ),
        ),
      ),
    );
  }
}
