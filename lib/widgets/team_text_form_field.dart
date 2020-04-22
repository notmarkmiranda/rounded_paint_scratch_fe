import 'package:flutter/material.dart';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';

class TeamTextFormField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  FocusNode focusNode;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  Function onEditingComplete;
  bool autofocus;

  TeamTextFormField({
    this.hintText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.onEditingComplete,
    this.autofocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      textCapitalization: TextCapitalization.words,
      autofocus: autofocus,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: AppColors.secondaryBlue,
          ),
        ),
        fillColor: Colors.white,
        contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        labelText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: AppColors.secondaryBlue,
            width: 2,
          ),
        ),
      ),
    );
  }
}
