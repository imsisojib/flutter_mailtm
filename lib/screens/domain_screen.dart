import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailtm/controllers/account_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DomainScreen extends StatefulWidget {
  const DomainScreen({Key? key}) : super(key: key);

  @override
  State<DomainScreen> createState() => _DomainScreenState();
}

class _DomainScreenState extends State<DomainScreen> {
  final AccountController accountController = Get.find();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      accountController.fetchDomains();
    });

  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.h),
          child: Obx(() {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        "Choose Domain",
                        style: theme.textTheme.headline5,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (_, index) {
                      return InkWell(
                        onTap: (){
                          accountController.selectedDomainName(accountController.domains[index].domain??"");
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(accountController.domains[index].domain??"",style: theme.textTheme.bodyText2?.copyWith(color: theme.colorScheme.secondary),),
                        ),
                      );
                    },
                    childCount: accountController.domains.length,
                  ),
                ),
                accountController.fetchingDomains.value?SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ):SliverToBoxAdapter()
              ],
            );
          }),
        ),
      ),
    );
  }
}
