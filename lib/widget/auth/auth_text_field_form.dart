import 'package:flutter/material.dart';

class AuthTextFromField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool obscureText;
  final Function validator;
  final String hintText;



  const AuthTextFromField({
    Key? key,
    required this.controller,
    required this.textInputType,

    required this.obscureText,
    required this.hintText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      keyboardType: textInputType,
      obscureText: obscureText,
      validator: (value) => validator(value),

      decoration: InputDecoration(
        hintText:hintText,
        hintStyle:const TextStyle(fontSize:14,fontWeight:FontWeight.w500,color:Colors.black45),

        enabledBorder:const UnderlineInputBorder(
          borderSide: BorderSide(
            color:Colors.grey,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color:Colors.grey,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color:Colors.red,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color:Colors.red,
          ),
        ),
      ),
      style: const TextStyle(color:Colors.black) ,
    );
  }
}