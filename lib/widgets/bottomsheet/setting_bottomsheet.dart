import 'package:flutter/material.dart';
import 'package:flutter_mailtm/controllers/app_controller.dart';
import 'package:flutter_mailtm/di_container.dart';
import 'package:flutter_mailtm/repositories/cache_repository.dart';
import 'package:flutter_mailtm/router/routes.dart';
import 'package:flutter_mailtm/widgets/buttons/button_filled.dart';
import 'package:get/get.dart';


extension ThemeModeExtension on ThemeMode {
  String get name {
    switch (this) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }
}

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({Key? key}) : super(key: key);

  @override
  _SettingsBottomSheetState createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  late ThemeMode _themeMode;
  final AppController appController = Get.find();
  final CacheRepository cacheRepository = sl();

  @override
  void initState() {
    super.initState();
    _themeMode = appController.themeMode.value;
  }

  @override
  Widget build(BuildContext context) {
    var radius = const Radius.circular(12);
    final modalBorder = BorderRadius.only(
      topRight: radius,
      topLeft: radius,
    );

    return StatefulBuilder(builder: (context, state) {
      void setTheme(ThemeMode? theme) {
        state(() {
          _themeMode = theme!;
        });
        appController.themeMode(theme!);
        Get.changeThemeMode(theme);
      }

      return Container(
        decoration: BoxDecoration(
          borderRadius: modalBorder,
          color: Theme.of(context).colorScheme.surface,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ExpansionTile(
                title: const Text('Theme'),
                children: [
                  for (var themeMode in ThemeMode.values)
                    RadioListTile(
                      title: Text(themeMode.name),
                      value: themeMode,
                      groupValue: _themeMode,
                      onChanged: setTheme,
                    ),
                ],
              ),
              SizedBox(height: 8,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ButtonFilled(
                  width: MediaQuery.of(context).size.width,
                  buttonText: "Sign Out",
                  function: ()async{
                    await cacheRepository.clearCache();
                    Get.offAllNamed(Routes.welcomeScreen);
                  },
                ),
              ),
              SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      );
    });
  }
}
