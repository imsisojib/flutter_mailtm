import 'package:flutter/cupertino.dart';
import 'package:flutter_mailtm/enums/dialogtype_enum.dart';
import 'package:flutter_mailtm/helpers/widget_helper.dart';
import 'package:flutter_mailtm/models/create_account_response.dart';
import 'package:flutter_mailtm/models/domains_response.dart';
import 'package:flutter_mailtm/models/login_response.dart';
import 'package:flutter_mailtm/repositories/account_repository.dart';
import 'package:flutter_mailtm/router/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AccountController extends GetxController{
  final AccountRepository accountRepository;

  AccountController({required this.accountRepository});

  //states
  final loadingCreateAccount = false.obs;
  final domainName = "".obs;
  final fetchingDomains = false.obs;
  final domains = <HydraMember>[].obs;
  final userName = "".obs;
  final password = "".obs;

  //setters
  void selectedDomainName(String name) async{
    domainName(name);
    if(name.isNotEmpty){
      Get.toNamed(Routes.createAccountScreen);
    }
  }

  //methods
  Future<void> fetchDomains() async {
    fetchingDomains(true);
    domains.clear();
    DomainsResponse? response = await accountRepository.fetchDomains();
    if(response!=null && response.hydraMember!=null && response.hydraMember!.isNotEmpty){
      domains.addAll(response.hydraMember!);
    }
    fetchingDomains(false);
  }

  Future<void> createAccount(BuildContext context) async {
    if(userName.isEmpty){
      WidgetHelper.showAlertDialog(context, "Error!", "Username can't be empty!", DialogTypeEnum.failed);
      return;
    }
    if(password.isEmpty){
      WidgetHelper.showAlertDialog(context, "Error!", "Password can't be empty!", DialogTypeEnum.failed);
      return;
    }

    loadingCreateAccount(true);
    CreateAccountResponse? response = await accountRepository.createAccount("${userName.value}@${domainName.value}", password.value);
    loadingCreateAccount(false);
    if(response!=null && response.statusCode==201){
      //success
      //clear sates
      domainName("");
      userName("");
      password("");

      WidgetHelper.showAlertDialog(
          context,
          "Account Created!",
          "Please login to your account now.", 
          DialogTypeEnum.success,
        function: (){
            Get.offAllNamed(Routes.loginScreen);
        }
      );
    }else{
      WidgetHelper.showAlertDialog(context, "Failed!", response?.hydraDescription??"Something is went wrong. Please check your data.", DialogTypeEnum.failed);
    }

  }

  Future<void> loginAccount(BuildContext context) async {
    if(userName.isEmpty){
      WidgetHelper.showAlertDialog(context, "Error!", "Email Address can't be empty!", DialogTypeEnum.failed);
      return;
    }
    if(password.isEmpty){
      WidgetHelper.showAlertDialog(context, "Error!", "Password can't be empty!", DialogTypeEnum.failed);
      return;
    }

    loadingCreateAccount(true);
    LoginResponse? response = await accountRepository.loginAccount(userName.value, password.value);
    loadingCreateAccount(false);
    if(response!=null && response.token!=null){
      //success
      accountRepository.tokenRepository.token = response.token;
      accountRepository.cacheRepository.saveToken(response.token??"");
      accountRepository.cacheRepository.saveUserName(userName.value);

      Fluttertoast.showToast(msg: "Login Successful!");
      Get.offAllNamed(Routes.homeScreen);
    }else{
      WidgetHelper.showAlertDialog(context, "Failed!", response?.message??"Something is went wrong. Please check your data.", DialogTypeEnum.failed);
    }

  }

}