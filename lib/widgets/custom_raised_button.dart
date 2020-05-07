import 'package:flutter/material.dart';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';
import 'package:rounded_paint_scratch_fe/providers/base_game_info.dart';

class CustomRaisedButton extends StatelessWidget {
  Function buttonPressed;
  String buttonText;
  Color color;
  Color splashColor;

  CustomRaisedButton({
    this.buttonPressed,
    this.buttonText,
    color,
    splashColor,
  })  : color = color ?? AppColors.primaryBlue,
        splashColor = splashColor ?? AppColors.secondaryBlue;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: color,
      splashColor: splashColor,
      textColor: Colors.white,
      onPressed: () {
        buttonPressed();
      },
      child: Text(buttonText),
    );
  }
}
