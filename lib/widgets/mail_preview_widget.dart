import 'package:flutter/material.dart';
import 'package:flutter_mailtm/models/maillist_response.dart';
import 'package:flutter_mailtm/resources/app_images.dart';
import 'package:flutter_mailtm/widgets/animations/visibility_tweeneffect.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MailPreviewCard extends StatelessWidget {
  final Mail email;
  final Function onTap;

  const MailPreviewCard({Key? key, required this.email, required this.onTap,})  : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = theme.colorScheme;

    return Dismissible(
      key: ObjectKey(email),
      dismissThresholds: const {
        DismissDirection.startToEnd: 0.8,
      },
      background: AnimatedContainer(
        alignment: Alignment.centerLeft,
        color: colorScheme.primary,
        curve: standardEasing,
        duration: kThemeAnimationDuration,
        padding: const EdgeInsetsDirectional.only(start: 20),
        child: const Material(
          color: Colors.transparent,
          child: Icon(Icons.delete),
        ),
      ),
      confirmDismiss: (direction) async {
        switch (direction) {
          case DismissDirection.startToEnd:{
            Fluttertoast.showToast(msg: "Mail will be deleted!");
            break;
          }
          default:
        }
      },
      child: VisibilityTweenEffect(
        duration: Duration(milliseconds: 700),
        child: InkWell(
          onTap: (){
            onTap.call();
          },
          child: Container(
            color: theme.cardColor,
            margin: EdgeInsets.only(bottom: 4.h),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${email.from?.address??""} - ${email.createdAt?.substring(0,10)??""}',
                            style: textTheme.caption,
                          ),
                          const SizedBox(height: 4),
                          Text(email.subject??"", style: textTheme.headline5,maxLines: 3,softWrap: true,overflow: TextOverflow.ellipsis,),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Material(
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
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 20,
                  ),
                  child: Text(
                    email.intro??"",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: textTheme.bodyText2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
