import 'package:flutter/material.dart';
import 'package:flutter_mailtm/resources/app_colors.dart';
import 'package:flutter_mailtm/widgets/animations/fade_through_transition_switcher.dart';
import 'package:flutter_mailtm/widgets/bottomsheet/setting_bottomsheet.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BottomAppBarActionItems extends StatelessWidget {
  final AnimationController drawerController;
  final bool drawerVisible;
  final bool onMailView;
  final Function? onDelete;

  const BottomAppBarActionItems({
    required this.drawerController,
    required this.drawerVisible,
    required this.onMailView,
    this.onDelete,
  });


  @override
  Widget build(BuildContext context) {
    var radius = const Radius.circular(12);
    final modalBorder = BorderRadius.only(
      topRight: radius,
      topLeft: radius,
    );


    return FadeThroughTransitionSwitcher(
      fillColor: Colors.transparent,
      child: onMailView
          ? Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          IconButton(
            icon: Icon(Icons.delete_outline_outlined),
            onPressed: () {
              onDelete?.call();
            },
            color: AppColors.white50,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              Fluttertoast.showToast(msg: "Not Implemented!");
            },
            color: AppColors.white50,
          ),
        ],
      )
          : Align(
        key: UniqueKey(),
        alignment: AlignmentDirectional.bottomEnd,
        child: IconButton(
          icon: const Icon(Icons.settings),
          color: AppColors.white50,
          onPressed: () async {
            drawerController.reverse();
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: modalBorder,
                ),
                builder: (context) => const SettingsBottomSheet(),
            );
          },
        ),
      ),
    );

  }
}