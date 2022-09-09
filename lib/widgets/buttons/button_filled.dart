import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonFilled extends StatelessWidget{
  final String buttonText;
  final Color? buttonColor;
  final double width;
  final double height;
  final double borderRadius;
  final TextStyle? buttonTextStyle;
  final Function? function;
  final Icon? prefixIcon;
  final EdgeInsetsGeometry? buttonPadding;
  ///do not use route and function at the same time. Only once can be perform at a time in the ButtonFilled
  const ButtonFilled({Key? key,required this.buttonText,this.buttonColor,this.width=100,this.height=35,this.borderRadius=8,this.buttonTextStyle, this.function, this.prefixIcon, this.buttonPadding,}):super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: buttonColor??theme.colorScheme.secondary,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))
      ),
      child: MaterialButton(
        padding: buttonPadding,
        onPressed: (){
          if(function==null) return;
          function!();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIcon??Container(),
            prefixIcon!=null?SizedBox(width: 4.w,):Container(),
            Flexible(child: Text(buttonText,style: buttonTextStyle??theme.textTheme.bodyText1?.copyWith(color: theme.colorScheme.onPrimary,),),),
          ],
        ),
      ),
    );
  }

}