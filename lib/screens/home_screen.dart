import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailtm/controllers/mail_controller.dart';
import 'package:flutter_mailtm/router/routes.dart';
import 'package:flutter_mailtm/widgets/bottomnav/animated_bottoappbar.dart';
import 'package:flutter_mailtm/widgets/fabbutton/mail_fab.dart';
import 'package:flutter_mailtm/widgets/mail_preview_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mailController.fetchMails();
    });

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
      bottomNavigationBar:  AnimatedBottomAppBar(
        bottomAppBarController: _bottomAppBarController,
        bottomAppBarCurve: _bottomAppBarCurve,
        bottomDrawerVisible: _bottomDrawerVisible,
        drawerController: _drawerController,
        dropArrowCurve: _dropArrowCurve,
        onMailView: false,
        toggleBottomDrawerVisibility: () {
          //todo
          Fluttertoast.showToast(msg: "Not Implemented!");
        },
      ),
      floatingActionButton: MailFab(onMailView: false,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}