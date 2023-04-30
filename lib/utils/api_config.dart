class ApiConfig{
  //Shared Key
  static const String token = 'token';
  static const String verificationCode = 'verificationCode';
  static const String phoneNumber = 'phone';
  static const String Continue = 'Continue';
  static const String email = 'email';
  static const String login = 'LOGIN';
  static const String loginWithEmail = 'Login With Email';
  static const String loginWithPhone = 'LOGIN WITH PHONE';

  static const String baseUrl = "http://185.100.234.129:8008/api";

  // ENDPOINTS
  static const String signUpUri = "/users";
  static const String signInUri = "/users/";

//  Complain
  static const String createComplainUri = "/complain";
  static const String getComplainsUri = "/complains";

}