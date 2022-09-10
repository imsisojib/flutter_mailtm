import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailtm/controllers/app_controller.dart';
import 'package:flutter_mailtm/screens/compose_mail_screen.dart';
import 'package:flutter_mailtm/widgets/animations/fade_through_transition_switcher.dart';
import 'package:get/get.dart';

class MailFab extends StatefulWidget {
  final bool onMailView;
  const MailFab({required this.onMailView});

  @override
  _MailFabState createState() => _MailFabState();
}

class _MailFabState extends State<MailFab>
    with SingleTickerProviderStateMixin {
  static final fabKey = UniqueKey();
  static const double _mobileFabDimension = 56;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const circleFabBorder = CircleBorder(
    );
    final tooltip = widget.onMailView ? 'Reply' : 'Compose';

    return OpenContainer(
      openBuilder: (context, closedContainer) {
        return ComposeMailScreen();
      },
      openColor: theme.cardColor,
      onClosed: (success) {

      },
      closedShape: circleFabBorder,
      closedColor: theme.colorScheme.secondary,
      closedElevation: 6,
      closedBuilder: (context, openContainer) {
        return Tooltip(
          message: tooltip,
          child: InkWell(
            customBorder: circleFabBorder,
            onTap: () {
              openContainer();
            },
            child: SizedBox(
              height: _mobileFabDimension,
              width: _mobileFabDimension,
              child: Center(
                child: FadeThroughTransitionSwitcher(
                  fillColor: Colors.transparent,
                  child: widget.onMailView
                      ? Icon(
                    Icons.reply_all,
                    key: fabKey,
                    color: Colors.black,
                  )
                      : const Icon(
                    Icons.create,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}