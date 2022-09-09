import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PasswordTextField extends StatefulWidget{
  final String? initialValue;
  final String? hintText;
  final String? tittleText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Function? onChanged;
  final bool isPasswordVisible;
  final Color? enableBorderColor;
  final double height;
  const PasswordTextField({Key? key,this.initialValue,this.height = 55, this.tittleText, this.controller, this.inputType, this.hintText,this.onChanged,this.isPasswordVisible=false,this.enableBorderColor}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PasswordTextFieldState(isPasswordVisible: isPasswordVisible);
  }

}

class _PasswordTextFieldState extends State<PasswordTextField>{

  bool isPasswordVisible;
  _PasswordTextFieldState({required this.isPasswordVisible,});

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: widget.tittleText==null?false:true,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.tittleText??"",style: theme.textTheme.subtitle2,),
                    Visibility(
                      visible: true, //always will be used for password field
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: isPasswordVisible?Icon(
                          Icons.visibility,
                          color: theme.colorScheme.error,
                        ):Icon(
                          Icons.visibility_off,
                          color: theme.colorScheme.error,
                        ),
                      ),
                    )
                  ],),
                const SizedBox(height: 6,),
              ],
            )),
        TextFormField(
          initialValue: widget.initialValue,
          onChanged: (value){
            widget.onChanged?.call(value);
          },
          style: theme.textTheme.bodyText2,
          scrollPhysics: const BouncingScrollPhysics(),
          maxLines: 1,
          obscureText: !isPasswordVisible,
          controller: widget.controller,
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
            isDense: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.enableBorderColor??theme.colorScheme.secondary,
                ),
                borderRadius: BorderRadius.circular(4)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: widget.enableBorderColor??theme.colorScheme.secondary,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(4)
            ),
            hintText: widget.hintText,
            hintStyle: theme.textTheme.bodyText2?.copyWith(color: theme.colorScheme.onSurface.withOpacity(.5)),


          ),
        ),
      ],
    );
  }

}