import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailtm/controllers/mail_controller.dart';
import 'package:flutter_mailtm/models/maillist_response.dart';
import 'package:flutter_mailtm/router/routes.dart';
import 'package:flutter_mailtm/widgets/mail_preview_widget.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final MailController mailController = Get.find();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mailController.fetchMails();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx((){
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverList(delegate: SliverChildBuilderDelegate(
                    (_,index){
                  return MailPreviewCard(
                    email: mailController.mails[index],
                    onTap: (){
                      Get.toNamed(Routes.getMailViewScreen(mailController.mails[index].id??""),);
                    },
                  );
                },
                childCount: mailController.mails.length,
              )),
              mailController.fetchingMails.value?SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ):SliverToBoxAdapter()
            ],
          );
        }),
      ),
    );
  }
}