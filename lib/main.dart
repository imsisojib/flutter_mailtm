import 'package:flutter/material.dart';
import 'di_container.dart' as di;
import 'mailtm_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();  //initializing Dependency Injection

  runApp(const MailTmApp());
}
