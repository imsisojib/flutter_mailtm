import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailtm/di_container.dart';
import 'package:flutter_mailtm/repositories/cache_repository.dart';
import 'package:flutter_mailtm/repositories/token_repository.dart';
import 'package:flutter_mailtm/resources/app_images.dart';
import 'package:flutter_mailtm/router/routes.dart';
import 'package:flutter_mailtm/widgets/animations/visibility_tweeneffect.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final CacheRepository cacheRepository = sl();
  final TokenRepository tokenRepository = sl();

  @override
  void initState() {
    super.initState();

    initApp();

  }

  Future<void> initApp() async {
    //sample delay
    await Future.delayed(const Duration(seconds: 3,),);
    String? token = await cacheRepository.fetchToken();
    if(token==null || token.isEmpty){
      //goto welcome screen to login/create account
      Get.offAllNamed(Routes.welcomeScreen);
    }else{
      //goto home screen
      tokenRepository.token = token;
      Get.offAllNamed(Routes.homeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: VisibilityTweenEffect(
          child: Image.asset(AppImages.appLogo,height: 300.h,width: 300.h,fit: BoxFit.cover,),
          duration: Duration(seconds: 2),
        ),
      ),
    );
  }
}