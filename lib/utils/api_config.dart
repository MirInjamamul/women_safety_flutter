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
  static const String signInWithPhoneUri = "/api/auth/phone-sign-in";
  static const String signUpWithPhoneUri = "/api/auth/phone-sign-up";
  static const String emailConfirmationUri = "/api/auth/email-confirm-verification";
  static const String getGiftBalanceInfoUri = "/api/customer/balance-info";
  static const String getOrderByIdUri = "/api/order/";
  static const String phoneConfirmation = "/api/auth/phone-confirm-verification";
  static const String loginWithEmailUri = "/api/auth/sign-in-with-email";
  static const String signUpUri = "/users";
  static const String updateInfoByPhoneUri1 = "/api/auth/update/";
  static const String updateInfoByPhoneUri2 = "/firstname-lastname-by-phone";

}