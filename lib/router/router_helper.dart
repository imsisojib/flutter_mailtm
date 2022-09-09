import 'package:fluro/fluro.dart';
import 'package:flutter_mailtm/router/routes.dart';
import 'package:flutter_mailtm/screens/create_account_screen.dart';
import 'package:flutter_mailtm/screens/domain_screen.dart';
import 'package:flutter_mailtm/screens/home_screen.dart';
import 'package:flutter_mailtm/screens/login_screen.dart';
import 'package:flutter_mailtm/screens/mail_view_screen.dart';
import 'package:flutter_mailtm/screens/page_not_found_screen.dart';
import 'package:flutter_mailtm/screens/splash_screen.dart';
import 'package:flutter_mailtm/screens/welcome_screen.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

  ///Handlers
  static final Handler _homeScreenHandler =
  Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const HomeScreen();
  });

  static final Handler _welcomeScreenHandler =
  Handler(handlerFunc: (context, parameters) => const WelcomeScreen());
  static final Handler _splashScreenHandler =
  Handler(handlerFunc: (context, parameters) => const SplashScreen());

  //account
  static final Handler _loginScreenHandler =
  Handler(handlerFunc: (context, parameters) => const LoginScreen());
  static final Handler _createAccountScreenHandler =
  Handler(handlerFunc: (context, parameters) => const CreateAccountScreen());
  static final Handler _domainScreenHandler =
  Handler(handlerFunc: (context, parameters) => const DomainScreen());

  //mail
  static final Handler _mailViewScreenHandler =
  Handler(handlerFunc: (context, parameters) =>
      MailViewScreen(
        mailId: parameters['id']?[0],
      ),);

  static final Handler _notFoundHandler =
  Handler(handlerFunc: (context, parameters) => const PageNotFoundScreen());

  void setupRouter() {
    router.notFoundHandler = _notFoundHandler;

    router.define(Routes.homeScreen,
        handler: _homeScreenHandler, transitionType: TransitionType.cupertino);


    router.define(Routes.welcomeScreen,
        handler: _welcomeScreenHandler,
        transitionType: TransitionType.cupertino);
    router.define(Routes.splashScreen,
        handler: _splashScreenHandler,
        transitionType: TransitionType.cupertino);

    //account
    router.define(Routes.loginScreen,
        handler: _loginScreenHandler,
        transitionType: TransitionType.cupertino);
    router.define(
      Routes.createAccountScreen,
      handler: _createAccountScreenHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      Routes.domainsScreen,
      handler: _domainScreenHandler,
      transitionType: TransitionType.cupertino,
    );

    //mail
    router.define(
      Routes.mailViewScreen,
      handler: _mailViewScreenHandler,
      transitionType: TransitionType.cupertino,
    );
  }

}
