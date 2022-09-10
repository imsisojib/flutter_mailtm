import 'package:flutter/material.dart';
import 'package:flutter_mailtm/controllers/mail_controller.dart';
import 'package:flutter_mailtm/di_container.dart';
import 'package:flutter_mailtm/models/single_mail_response.dart';
import 'package:flutter_mailtm/repositories/mail_repository.dart';
import 'package:flutter_mailtm/resources/app_images.dart';
import 'package:flutter_mailtm/widgets/bottomnav/animated_bottoappbar.dart';
import 'package:flutter_mailtm/widgets/fabbutton/mail_fab.dart';
import 'package:flutter_mailtm/widgets/html/html_viewer.dart';
import 'package:get/get.dart';

class MailViewScreen extends StatefulWidget {
  final String? mailId;
  const MailViewScreen({Key? key, required this.mailId,})
      : super(key: key);

  @override
  State<MailViewScreen> createState() => _MailViewScreenState();
}

class _MailViewScreenState extends State<MailViewScreen> with TickerProviderStateMixin{
  final MailController mailController = Get.find();

  late final AnimationController _drawerController;
  late final AnimationController _dropArrowController;
  late final AnimationController _bottomAppBarController;
  late final Animation<double> _drawerCurve;
  late final Animation<double> _dropArrowCurve;
  late final Animation<double> _bottomAppBarCurve;
  final _kAnimationDuration = Duration(milliseconds: 300);
  bool _bottomDrawerVisible = false;

  @override
  void initState() {
    super.initState();

    _drawerController = AnimationController(
      duration: _kAnimationDuration,
      value: 0,
      vsync: this,
    )..addListener(() {
      if (_drawerController.status == AnimationStatus.dismissed &&
          _drawerController.value == 0) {
        //change state
      }

      if (_drawerController.value < 0.01) {

      }
    });

    _dropArrowController = AnimationController(
      duration: _kAnimationDuration,
      vsync: this,
    );

    _bottomAppBarController = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 250),
    );

    _drawerCurve = CurvedAnimation(
      parent: _drawerController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );

    _dropArrowCurve = CurvedAnimation(
      parent: _dropArrowController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );

    _bottomAppBarCurve = CurvedAnimation(
      parent: _bottomAppBarController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: FutureBuilder(
          future: mailController.mailRepository.fetchSingleMail(widget.mailId),
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
                          receiverName: (mailResponse.to!=null && mailResponse.to!.isNotEmpty)?mailResponse.to![0].address:"",
                          senderMail: mailResponse.from?.address,
                          date: mailResponse.createdAt,
                        ),
                        const SizedBox(height: 32),
                        (mailResponse.html!=null && mailResponse.html!.isNotEmpty)?
                        HtmlViewer(
                          description: mailResponse.html![0],
                        ):
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
      bottomNavigationBar:  AnimatedBottomAppBar(
        bottomAppBarController: _bottomAppBarController,
        bottomAppBarCurve: _bottomAppBarCurve,
        bottomDrawerVisible: _bottomDrawerVisible,
        drawerController: _drawerController,
        dropArrowCurve: _dropArrowCurve,
        onMailView: true,
        toggleBottomDrawerVisibility: () {  },
        onDeleteAction: (){
          mailController.deleteMail(widget.mailId??"");
        },
      ),
      floatingActionButton: MailFab(onMailView: true,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

    String? parseName = receiverName?.split("@").first;

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
                  'To ${parseName??""},',
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

