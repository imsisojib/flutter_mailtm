import 'package:flutter_mailtm/controllers/mail_controller.dart';
import 'package:flutter_mailtm/di_container.dart';
import 'package:get/get.dart';

import 'controllers/account_controller.dart';

class StoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController(accountRepository: sl()));
    Get.lazyPut(() => MailController(mailRepository: sl()));
  }
}