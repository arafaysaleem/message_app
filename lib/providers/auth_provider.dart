import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helper/enums/auth_status_enum.dart';

import '../models/user_account.dart';

class AuthProvider extends ChangeNotifier {
  //Firebase Auth object
  FirebaseAuth _auth = FirebaseAuth.instance;

  UserAccount _currentUser;

  String _verificationId;

  //Default status - Load from shared prefs
  AuthStatus _status = AuthStatus.LOGGED_OUT;

  AuthStatus get status => _status;

  UserAccount get currentUser => _currentUser;

  String get uid => _currentUser.number;

  Future<void> verifyPhoneForOTP(String phoneNo) async {
    _status = AuthStatus.AUTHENTICATING;
    notifyListeners();

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      _verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      _verificationId = verId;
      _status = AuthStatus.OTP_SENT;
      notifyListeners();
    };

    final PhoneVerificationFailed verifyFailed =
        (FirebaseAuthException exception) {
      _status = AuthStatus.UNAUTHENTICATED;
      notifyListeners();
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 5),
      verificationCompleted: _signInUser,
      verificationFailed: verifyFailed,
    );
  }

  Future<void> verifyOTP(String otp) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otp,
    );
    _signInUser(credential);
  }

  Future<void> _signInUser(AuthCredential credential) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      _status = AuthStatus.LOGGED_IN;
      _currentUser = _userAccountFromFirebase(userCredential.user);
    } catch (e) {
      print(e.toString());
      _status = AuthStatus.UNAUTHENTICATED;
    }
    notifyListeners();
  }

  //Create user object based on the given FirebaseUser
  UserAccount _userAccountFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return UserAccount(user.phoneNumber);
  }

  //Method to handle user signing out
  Future signOut() async {
    _auth.signOut();
    _status = AuthStatus.LOGGED_OUT;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
