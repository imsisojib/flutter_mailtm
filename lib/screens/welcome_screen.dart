import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailtm/resources/app_images.dart';
import 'package:flutter_mailtm/router/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(
                    image: const AssetImage(AppImages.appLogo),
                    width: 300.w,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "Welcome",
                    style: theme.textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in ultrices sapien. Vestibulum finibus auctor dolor. Proin finibus nulla in luctus suscipit. Phasellus nisi risus, tincidunt ac tincidunt quis, mattis eu ligula. Nulla imperdiet urna id molestie condimentum. Nullam ligula nulla, pulvinar in ullamcorper vel, dapibus placerat augue. Nullam imperdiet, risus ut ullamcorper faucibus, mauris dolor tristique augue, in pretium nibh neque sit amet ipsum.""",
                      style: theme.textTheme.subtitle2?.copyWith(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.domainsScreen);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 24, right: 24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                  ),
                  width: MediaQuery.of(context).size.width - 48,
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Create Account",
                          style: theme.textTheme.subtitle2?.copyWith(color: theme.colorScheme.onPrimary,),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: theme.colorScheme.onPrimary,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have account?",
                      style: theme.textTheme.caption?.copyWith(color: theme.colorScheme.secondary,)),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.loginScreen);
                    },
                    child: Text("Login", style: theme.textTheme.caption?.copyWith(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              SizedBox(height: 24.h,),
            ],
          ),
        ],
      )),
    );
  }
}
