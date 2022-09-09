import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicTextField extends StatelessWidget{
  final String? initialValue;
  final String? hintText;
  final String? tittleText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Function? onChanged;
  final Color? enableBorderColor;
  const BasicTextField({Key? key, this.initialValue, this.tittleText,this.controller, this.inputType, this.hintText,this.onChanged,this.enableBorderColor,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: tittleText==null?false:true,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Text(tittleText??"",style: theme.textTheme.subtitle2,),
                    ],),
                  ],),
                const SizedBox(height: 6,),
              ],
            )),
        SizedBox(
          child: TextFormField(
            initialValue: initialValue,
            onChanged: (value){
              if(onChanged != null) onChanged!(value);
            },
            style: theme.textTheme.bodyText2,
            scrollPhysics: const BouncingScrollPhysics(),
            controller: controller,
            keyboardType: inputType,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
              isDense: true,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: enableBorderColor??theme.colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(4)
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: enableBorderColor??theme.colorScheme.secondary,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(4)
              ),
              hintText: hintText,
              hintStyle: theme.textTheme.bodyText2?.copyWith(color: theme.colorScheme.onSurface.withOpacity(.5)),

            ),
          ),
        ),
      ],
    );
  }

}