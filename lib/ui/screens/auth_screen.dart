import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../../helper/enums/auth_status_enum.dart';

import 'home_screen.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Screen",
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
        ),
        centerTitle: true,
      ),
      body: Selector<AuthProvider,AuthStatus>(
        selector: (_,authProvider)=>authProvider.status,
        builder: (_,status,__){
          if(status == AuthStatus.AUTHENTICATED) {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }
          else if(status == AuthStatus.AUTHENTICATING){
            return Center(child: CircularProgressIndicator());
          }
          else if(status == AuthStatus.UNAUTHENTICATED){
            return Center(child: Text("Failed"));
          }
          else if(status == AuthStatus.OTP_SENT){
            return Column(
              children: [
                //OTP Field

                //Verify OTP button
              ],
            );
          }
          return Column(
            children: [
              //Phone number field

              //Send OTP button
            ],
          );
        },
      ),
    );
  }
}
