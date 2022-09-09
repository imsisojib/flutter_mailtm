import 'package:flutter/material.dart';
import 'package:flutter_mailtm/di_container.dart';
import 'package:flutter_mailtm/models/single_mail_response.dart';
import 'package:flutter_mailtm/repositories/mail_repository.dart';
import 'package:flutter_mailtm/resources/app_images.dart';
import 'package:get/get.dart';

class MailViewScreen extends StatefulWidget {
  final String? mailId;
  const MailViewScreen({Key? key, required this.mailId,})
      : super(key: key);

  @override
  State<MailViewScreen> createState() => _MailViewScreenState();
}

class _MailViewScreenState extends State<MailViewScreen> {

  final MailRepository mailRepository = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: FutureBuilder(
          future: mailRepository.fetchSingleMail(widget.mailId),
          builder: (_,AsyncSnapshot response){
            if(response.connectionState==ConnectionState.done){

              SingleMailResponse? mailResponse = response.data;
              if(mailResponse==null){
                //no mail found
                return Center(child: Text("No data found!",style: Theme.of(context).textTheme.bodyText2,),);
              }

              return SizedBox(
                height: double.infinity,
                child: Material(
                  color: Theme.of(context).cardColor,
                  child: SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.only(
                      top: 42,
                      start: 20,
                      end: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MailViewHeader(
                          subject: mailResponse.subject,
                          receiverName: (mailResponse.to!=null && mailResponse.to!.isNotEmpty)?mailResponse.to![0].name:"",
                          senderMail: mailResponse.from?.address,
                          date: mailResponse.createdAt,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          mailResponse.text??"",
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: kToolbarHeight),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}

class _MailViewHeader extends StatelessWidget {
  final String? subject;
  final String? senderMail;
  final String? receiverName;
  final String? date;
  const _MailViewHeader({this.subject, this.senderMail, this.receiverName, this.date});


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                subject??"",
                style: textTheme.headline4!.copyWith(height: 1.1),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              onPressed: () {
                Get.back();
              },
              splashRadius: 20,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${senderMail??""} - ${date?.substring(0,10)??""}'),
                const SizedBox(height: 4),
                Text(
                  'To ${receiverName??""},',
                  style: textTheme.caption!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.64),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 4),
              child: Material(
                color: Colors.transparent,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).canvasColor,
                  child: ClipOval(
                    child: Image.asset(
                      AppImages.appLogo,
                      height: 42,
                      width: 42,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

