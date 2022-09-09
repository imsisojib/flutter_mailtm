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

    MailListResponse? response = await mailRepository.fetchMails(index);
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