class Routes {
  static const String homeScreen = "/";
  static const String splashScreen = "/splash";
  static const String welcomeScreen = "/welcome";
  static const String loginScreen = "/login";
  static const String createAccountScreen = "/create_account";
  static const String domainsScreen = "/domains";

  //mail
  static const String mailViewScreen = "/mail/info";

  static String getMailViewScreen(String mailId){
    return "$mailViewScreen?id=$mailId";
  }

}
