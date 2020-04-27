import 'package:flutter/material.dart';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';

class CountStat extends StatelessWidget {
  final String stat;
  final int number;
  final EdgeInsets padding = EdgeInsets.all(8.0);

  CountStat({this.stat, this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: padding,
          child: Text(
            stat,
            style: TextStyle(
              color: AppColors.secondaryBlue,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: padding,
          child: Text(
            number.toString(),
            style: TextStyle(
              color: AppColors.primaryBlue,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
