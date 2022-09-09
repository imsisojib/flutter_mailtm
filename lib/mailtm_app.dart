import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailtm/resources/app_themes.dart';
import 'package:flutter_mailtm/router/router_helper.dart';
import 'package:flutter_mailtm/router/routes.dart';
import 'package:flutter_mailtm/store_bindings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MailTmApp extends StatefulWidget{
  const MailTmApp({Key? key}) : super(key: key);

  @override
  State<MailTmApp> createState() => _MailTmAppState();
}

class _MailTmAppState extends State<MailTmApp> {

  @override
  void initState() {
    super.initState();

    RouterHelper().setupRouter();

  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, app) {
        return GetMaterialApp(
          builder: (context, child) {
            return ScrollConfiguration(
              //Removes the whole app's scroll glow
              behavior: AppBehavior(),
              child: child!,
            );
          },
          title: 'mail@tm',
          themeMode: ThemeMode.system,
          theme: buildLightTheme(context),
          darkTheme: buildDarkTheme(context),
          initialBinding: StoreBinding(),
          initialRoute: Routes.splashScreen,
          onGenerateRoute: RouterHelper.router.generator,
        );
      },
    );
  }
}

//to avoid scroll glow in whole app
class AppBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context,
      Widget child,
      AxisDirection axisDirection,
      ) {
    return child;
  }
}