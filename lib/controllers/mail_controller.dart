import 'dart:convert';

import 'package:flutter_mailtm/helpers/network_checker.dart';
import 'package:flutter_mailtm/models/maillist_response.dart';
import 'package:flutter_mailtm/repositories/mail_repository.dart';
import 'package:get/get.dart';

class MailController extends GetxController{
  final MailRepository mailRepository;
  MailController({required this.mailRepository});

  //states
  int index = 1;
  int totalMails = 0;
  final mails = <Mail>[].obs;
  final fetchingMails = false.obs;

  Future<void> fetchMails() async {
    fetchingMails(true);
    mails.clear();
    MailListResponse? response;
    if(await NetworkHelper.connected()){
      response = await mailRepository.fetchMails(index);
    }else{
      response = MailListResponse.fromJson(jsonDecode(await mailRepository.cacheRepository.fetchMailList()??""));
    }
    if(response!=null){

      if(response.hydraMember!=null){
        mails.addAll(response.hydraMember!);
      }
      if(response.hydraTotalItems!=null){
        totalMails = response.hydraTotalItems!;
      }
    }

    fetchingMails(false);
  }



}