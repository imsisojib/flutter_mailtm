import 'package:flutter_mailtm/controllers/mail_controller.dart';
import 'package:get/get.dart';

import 'controllers/account_controller.dart';

class StoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController());
    Get.lazyPut(() => MailController());
  }
}