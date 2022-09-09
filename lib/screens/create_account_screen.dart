import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailtm/controllers/account_controller.dart';
import 'package:flutter_mailtm/widgets/buttons/button_filled.dart';
import 'package:flutter_mailtm/widgets/textfields/basic_textfield.dart';
import 'package:flutter_mailtm/widgets/textfields/password_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateAccountScreen extends StatefulWidget{
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
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
                "Create Account",
                style: theme.textTheme.headline5,
              ),
              SizedBox(height: 24.h,),
              Row(
                children: [
                  Expanded(child: BasicTextField(
                    hintText: "Type User Name",
                    onChanged: (value){
                      accountController.userName(value.trim());
                    },
                  ),),
                  SizedBox(width: 8.w,),
                  Obx(()=>Text(
                    "@${accountController.domainName.value}",
                    style: theme.textTheme.caption?.copyWith(color: theme.colorScheme.secondary),
                  ),),
                ],
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
                  buttonText: "Create Account",
                  function: (){
                    accountController.createAccount(context);
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