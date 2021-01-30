enum AuthStatus {
  ///For logged in
  LOGGED_IN,

  ///For logged out
  LOGGED_OUT,

  ///For waiting authentication
  AUTHENTICATING,

  ///For error in login
  UNAUTHENTICATED,

  ///For OTP sent
  OTP_SENT
}
