import 'package:flutter/material.dart';
import 'package:flutter_mailtm/enums/dialogtype_enum.dart';
import 'package:flutter_mailtm/widgets/buttons/button_filled.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WidgetHelper{
  static Future<void> showAlertDialog(BuildContext context, String? title, String? body, DialogTypeEnum type, {Function? function, String? buttonText}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.h),
          ),
          title: Column(
              children:[
                Icon(
                    (type == DialogTypeEnum.success ? Icons.check_circle : Icons.warning),
                    color: (type == DialogTypeEnum.success ? Colors.green : Colors.red),
                    size: 72.h
                ),
                Text(title??"",softWrap: true,textAlign: TextAlign.center,),
              ]
          ),
          content: Text(body??"", style: Theme.of(context).textTheme.bodyText2,textAlign: TextAlign.start,),
          actions: <Widget>[
            ButtonFilled(
              buttonText: buttonText??"Ok",
              function: () {
                Get.back();
                function?.call();
              },
            )
          ],
        );
      },
    );
  }
}