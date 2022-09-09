import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailtm/controllers/account_controller.dart';
import 'package:flutter_mailtm/widgets/buttons/button_filled.dart';
import 'package:flutter_mailtm/widgets/textfields/basic_textfield.dart';
import 'package:flutter_mailtm/widgets/textfields/password_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AccountController accountController = Get.find();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h,),
              Text(
                "Login Now",
                style: theme.textTheme.headline5,
              ),
              SizedBox(height: 24.h,),
              BasicTextField(
                tittleText: "Email Address",
                hintText: "Email Address",
                onChanged: (value){
                  accountController.userName(value.trim());
                },
              ),
              SizedBox(height: 16.h,),
              PasswordTextField(
                hintText: "Type Password",
                tittleText: "Password",
                onChanged: (value){
                  accountController.password(value.trim());
                },
              ),
              SizedBox(height: 32.h,),
              Obx((){
                return accountController.loadingCreateAccount.value?Center(child: CircularProgressIndicator(),):ButtonFilled(
                  width: MediaQuery.of(context).size.width,
                  buttonText: "Login",
                  function: (){
                    accountController.loginAccount(context);
                  },
                );
              })

            ],
          ),
        ),
      ),
    );
  }
}