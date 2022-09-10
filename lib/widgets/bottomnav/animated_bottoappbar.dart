import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailtm/resources/app_colors.dart';
import 'package:flutter_mailtm/resources/app_images.dart';
import 'package:flutter_mailtm/widgets/animations/fade_through_transition_switcher.dart';
import 'package:flutter_mailtm/widgets/bottomnav/waterfall_notched_rectangle.dart';

import 'bottom_appbar_action_items.dart';

class AnimatedBottomAppBar extends StatelessWidget {
  final AnimationController bottomAppBarController;
  final Animation<double> bottomAppBarCurve;
  final bool bottomDrawerVisible;
  final AnimationController drawerController;
  final Animation<double> dropArrowCurve;
  final VoidCallback toggleBottomDrawerVisibility;
  final bool onMailView;
  final Function? onDeleteAction;
  const AnimatedBottomAppBar({
    required this.toggleBottomDrawerVisibility,
    required this.onMailView,
    required this.bottomAppBarController,
    required this.bottomAppBarCurve,
    required this.bottomDrawerVisible,
    required this.drawerController,
    required this.dropArrowCurve, this.onDeleteAction,
  });

  @override
  Widget build(BuildContext context) {
    var fadeOut = Tween<double>(begin: 1, end: -1).animate(
      drawerController.drive(CurveTween(curve: standardEasing)),
    );

    return SizeTransition(
      sizeFactor: bottomAppBarCurve,
      axisAlignment: -1,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 2),
        child: BottomAppBar(
          shape: const WaterfallNotchedRectangle(),
          notchMargin: 6,
          child: Container(
            color: Colors.transparent,
            height: kToolbarHeight,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  onTap: toggleBottomDrawerVisibility,
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      RotationTransition(
                        turns: Tween(
                          begin: 0.0,
                          end: 1.0,
                        ).animate(dropArrowCurve),
                        child: const Icon(
                          Icons.arrow_drop_up,
                          color: AppColors.white50,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const ImageIcon(
                        AssetImage(AppImages.appLogo,),
                        size: 32,
                        color: AppColors.white50,
                      ),
                      const SizedBox(width: 10),
                      FadeThroughTransitionSwitcher(
                        fillColor: Colors.transparent,
                        child: onMailView
                            ? const SizedBox(width: 48)
                            : FadeTransition(
                          opacity: fadeOut,
                          child: Text(
                            "Inbox",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                              color: AppColors.white50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: BottomAppBarActionItems(
                      onDelete: onDeleteAction,
                      drawerController: drawerController,
                      drawerVisible: bottomDrawerVisible,
                      onMailView: onMailView,
                    ),
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