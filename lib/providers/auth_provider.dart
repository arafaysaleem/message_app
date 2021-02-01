import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/prefs.dart';
import '../services/firestore_database.dart';

import '../helper/enums/auth_status_enum.dart';

import '../models/conversation.dart';
import '../models/user_account.dart';

class AuthProvider extends ChangeNotifier {

  ///Instance of firebase auth object
  FirebaseAuth _auth = FirebaseAuth.instance;

  ///Instance of shared prefs wrapper
  Prefs _prefs = Prefs.instance;

  ///Logged in user
  UserAccount _currentUser;

  ///Verification id of logged in user
  String _verificationId;

  ///Resend token
  int resendToken;

  ///Status of authentication process
  AuthStatus _status;

  ///Initializes authentication
  AuthProvider() {
    _loadDefaults();
  }

  ///Returns current status of authentication
  AuthStatus get status => _status;

  ///Returns current logged in user
  UserAccount get currentUser => _currentUser;

  ///Returns number of current logged in user
  String get userNumber => _currentUser.number;

  ///Loads local saved preferences if any
  void _loadDefaults() async {
    _currentUser = await _prefs.getAuthUserKey();
    _status = await _prefs.getAuthStatusKey();
    if(_currentUser!=null) {
      //Initialize database for the loaded user
      FirestoreDatabase.init(uid: userNumber);

      //Set myContact
      Conversation.setMyContact(userNumber);
    }
  }

  ///Verifies a phone number and if successful,
  /// sends an OTP code via SMS.
  ///else
  /// updates auth status to fail
  Future<void> verifyPhoneForOTP(String phoneNo) async {
    _status = AuthStatus.AUTHENTICATING;
    notifyListeners();

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      _verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      _verificationId = verId;
      resendToken = forceCodeResend;
      _currentUser = UserAccount(phoneNo);
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
      timeout: const Duration(seconds: 30),
      verificationCompleted: _signInUser,
      verificationFailed: verifyFailed,
      forceResendingToken: resendToken
    );
  }

  ///Verifies the input OTP againts the one sent and if successful,
  /// signs in the user
  ///else
  /// updates auth status to fail
  void verifyOTP(String otp) {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otp,
    );
    _signInUser(credential);
  }

  ///Internal method to sign in the user with the provided credentials
  ///Creates a new user document in database on 1st sign in.
  ///Initializes firestore database, sets myContact, sets preferences,
  ///Else updates auth status if fail.
  void _signInUser(AuthCredential credential) async {
    try {
      //Sign in, change status and get user
      final userCredential = await _auth.signInWithCredential(credential);
      _status = AuthStatus.LOGGED_IN;
      _currentUser = _userAccountFromFirebase(userCredential.user);

      //create user firestore document
      if (userCredential.additionalUserInfo.isNewUser) {
        FirestoreDatabase.instance.createUser(userNumber, {
          'exists': true,
          'uid': userCredential.user.uid,
        });
      }

      //Initialize database for this user
      FirestoreDatabase.init(uid: userNumber);

      //Set myContact
      Conversation.setMyContact(userNumber);

      //Save preferences
      await _prefs.setAuthUserKey(userNumber);
      await _prefs.setAuthStatusKey(_status);
    } catch (e) {
      print(e.toString());
      _status = AuthStatus.UNAUTHENTICATED;
    }
    notifyListeners();
  }

  void changeAuthStatus(AuthStatus status) {
    _status = status;
    notifyListeners();
  }

  ///Create user object based on the given FirebaseUser
  UserAccount _userAccountFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return UserAccount(user.phoneNumber);
  }

  ///Method to handle user signing out
  void signOut() async {
    if (_auth.currentUser != null) await _auth.signOut();
    _status = AuthStatus.LOGGED_OUT;
    await _prefs.resetAuth();
    notifyListeners();
  }
}
