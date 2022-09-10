import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget{
  const PageNotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Page Not Found!",style: Theme.of(context).textTheme.bodyText1,),
        ),
      ),
    );
  }
}