import 'package:flutter/material.dart';

import 'package:rounded_paint_scratch_fe/config/app_colors.dart';
import 'package:rounded_paint_scratch_fe/widgets/nav_bar.dart';
import 'package:rounded_paint_scratch_fe/views/games_index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GamesIndex(),
    );
  }
}
