// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:afkar/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomStatelessTextField extends StatelessWidget {
   const CustomStatelessTextField({Key? key,
     this.labelText,
     this.controller,
     this.helpText,
     this.onTap,
     this.keyType
  }) : super(key: key);
  final String? labelText;
  final String ?helpText;
  final void Function()? onTap;
  final TextInputType? keyType;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      keyboardType: keyType,
      onTap:onTap ,
      cursorColor: color7,
      controller: controller,
      style: const TextStyle(
          color: Colors.black
      ),
      validator: (value) {
        if(value!.isEmpty){
          return "$labelText must not be empty";
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: Colors.amberAccent,
          fontSize: 16
        ),
        hintText: helpText,
        hintStyle: TextStyle(
          color: Colors.grey
        ),
        label: Text(
          labelText!,
          style:  TextStyle(
              color: color7,
              fontSize: 19
          ),
        ),
        border:  UnderlineInputBorder(
          borderSide: BorderSide(
              color: color3,
              width: 1.25
          ),
        ),
        enabledBorder:  UnderlineInputBorder(
          borderSide: BorderSide(
              color:color3,
              width: 1.25
          ),
        ),
        focusedBorder:  UnderlineInputBorder(
          borderSide: BorderSide(
              color: color3,
              width: 1.25
          ),
        ),
      ),
    );
  }
}
