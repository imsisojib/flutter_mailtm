import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckBox extends StatefulWidget{
  final bool checked;
  final Function onChecked;
  final String? name;
  const CustomCheckBox({Key? key, required this.checked, required this.onChecked,this.name}) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              splashRadius: 1,
              constraints: BoxConstraints(
                maxHeight: 24,
                maxWidth: 24,
              ),
              onPressed: (){
                widget.onChecked(!widget.checked);
              }, icon:widget.checked?Icon(Icons.radio_button_checked,color: theme.colorScheme.secondary,):Icon(Icons.circle_outlined,color: Theme.of(context).colorScheme.primary,),
            ),
            SizedBox(width: 12.w,),
            Flexible(child: Text(widget.name??"",style: theme.textTheme.bodyText1?.copyWith(color: theme.colorScheme.secondary)),),
          ],
        ),
        SizedBox(height: 20.h,),
      ],
    );
  }
}