import 'dart:convert';

import 'package:flutter_mailtm/helpers/network_checker.dart';
import 'package:flutter_mailtm/models/maillist_response.dart';
import 'package:flutter_mailtm/repositories/mail_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  Future<void> fetchMoreMails() async{
    if(mails.length>=totalMails || fetchingMails.value){
      //all mails fetched or fetching currently.
      //no need to call api
      return;
    }

    index++;

    MailListResponse? response = await mailRepository.fetchMails(index);
    if(response!=null){
      if(response.hydraMember!=null){
        mails.addAll(response.hydraMember!);
      }
      if(response.hydraTotalItems!=null){
        totalMails = response.hydraTotalItems!;
      }
    }

  }

  Future<void> deleteMail(String mailId) async{
    int? response = await mailRepository.deleteMail(mailId);
    if(response==204){
      //deleted
      Fluttertoast.showToast(msg: "Mail is deleted!");
      fetchMails();
      Get.back();
    }else{
      Fluttertoast.showToast(msg: "Failed to delete the mail!");
    }
  }



}