import 'package:flutter/material.dart';

import '../../resources/brand_colors.dart';

class AuthButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const AuthButton({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:onPressed,
        style:ElevatedButton.styleFrom(
          primary:BrandColors.colorAccent,
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(25),
          )
        ),
        child:  SizedBox(
            height: 40,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "Brand-Bold",
                ),
              ),
      )));
  }
}
